//
//  EEMultiDelegate.m
//
//  a multicast delegate class with thread-safe
//
//  Created by ian  on 2017/9/9.
//  Copyright © 2017 ian<https://github.com/ienho>. All rights reserved.
//

#import "EEMultiDelegate.h"

@implementation EEMultiDelegate {
    NSHashTable *_delegates;
    dispatch_semaphore_t _semaphore;
}

#pragma mark - Lifecycle

- (instancetype)init {
    if (self = [super init]) {
        _delegates = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
        _semaphore = dispatch_semaphore_create(1);
    }
    return self;
}

#pragma mark - Public Methods

+ (EEMultiDelegate *)multiDelegate {
    EEMultiDelegate *multiDelegate = [[EEMultiDelegate alloc] init];
    return multiDelegate;
}

- (void)addDelegate:(id)delegate {
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    [_delegates addObject:delegate];
    dispatch_semaphore_signal(_semaphore);
}

- (void)removeDelete:(id)delegate {
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    [_delegates removeObject:delegate];
    dispatch_semaphore_signal(_semaphore);
}

#pragma mark - Forward Methods

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    NSMethodSignature *result = nil;
    for (id delegate in _delegates) {
        if ([delegate respondsToSelector:selector]) {
            result = [delegate methodSignatureForSelector:selector];
            if (result) {
                break;
            }
        }
    }
    dispatch_semaphore_signal(_semaphore);
    
    return result? : [super methodSignatureForSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL selector = invocation.selector;
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    for (id delegate in _delegates) {
        if ([delegate respondsToSelector:selector]) {
            // must use duplicated invocation when you invoke with async
            NSInvocation *dupInvocation = [self duplicateInvocation:invocation];
            dupInvocation.target = delegate;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [dupInvocation invoke];
            });
        }
    }
    dispatch_semaphore_signal(_semaphore);
}

- (NSInvocation *)duplicateInvocation:(NSInvocation *)invocation {
    NSMethodSignature *methodSignature = invocation.methodSignature;
    SEL selector = invocation.selector;
    NSInvocation *dupInvocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    dupInvocation.selector = selector;
    
    NSUInteger count = methodSignature.numberOfArguments;
    for (NSUInteger i = 2; i < count; i++) {
        const char *type = [methodSignature getArgumentTypeAtIndex:i];
        if (*type == *@encode(BOOL)) {
            BOOL value;
            [invocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(char) || *type == *@encode(unsigned char)) {
            char value;
            [invocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(short) || *type == *@encode(unsigned short)) {
            short value;
            [invocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(int) || *type == *@encode(unsigned int)) {
            int value;
            [invocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(long) || *type == *@encode(unsigned long)) {
            long value;
            [invocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(long long) || *type == *@encode(unsigned long long)) {
            long long value;
            [invocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(double)) {
            double value;
            [invocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(float)) {
            float value;
            [invocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == '@') {
            // type of [object / block], such as 'NSString *' 'void(^)(NSInteger)'
            void *value;
            [invocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == '^') {
            // type of [pointer] , when user '&' to get the address, such as '&intValue' '&(NSString *)'
            void *pointer;
            [invocation getArgument:&pointer atIndex:i];
            [dupInvocation setArgument:&pointer atIndex:i];
        }
        else if (*type == ':') {
            // type of [SEL] , such as '@selector(setValue:forKey:)'
            void *value;
            [invocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else {
            NSString *selectorStr = NSStringFromSelector(selector);
            NSString *format = @"Argument %lu to method %@ - Type(%c) not supported";
            NSString *reason = [NSString stringWithFormat:format, (unsigned long)(i - 2), selectorStr, *type];
            [[NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil] raise];
        }
    }
    [dupInvocation retainArguments];
    
    return dupInvocation;
}

@end
