//
//  EEMultiDelegate.m
//
//  a multicast delegate class with thread-safe
//
//  Created by ian  on 2017/9/9.
//  Copyright © 2017年 ian. All rights reserved.
//

#import "EEMultiDelegate.h"

@implementation EEMultiDelegate {
    NSHashTable *_delegates;
    dispatch_semaphore_t _sema;
}

#pragma mark - Lifecycle

- (instancetype)init {
    if (self = [super init]) {
        _delegates = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
        _sema = dispatch_semaphore_create(1);
    }
    return self;
}

#pragma mark - Public Methods

+ (EEMultiDelegate *)multiDelegate {
    EEMultiDelegate *multiDelegate = [[EEMultiDelegate alloc] init];
    return multiDelegate;
}

- (void)addDelegate:(id)delegate {
    dispatch_semaphore_wait(_sema, DISPATCH_TIME_FOREVER);
    [_delegates addObject:delegate];
    dispatch_semaphore_signal(_sema);
}

- (void)removeDelete:(id)delegate {
    dispatch_semaphore_wait(_sema, DISPATCH_TIME_FOREVER);
    [_delegates removeObject:delegate];
    dispatch_semaphore_signal(_sema);
}

#pragma mark - Forward Methods

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    dispatch_semaphore_wait(_sema, DISPATCH_TIME_FOREVER);
    NSMethodSignature *result = nil;
    for (id delegate in _delegates) {
        if ([delegate respondsToSelector:selector]) {
            result = [delegate methodSignatureForSelector:selector];
            if (result) {
                break;
            }
        }
    }
    dispatch_semaphore_signal(_sema);

    return result? : [super methodSignatureForSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL selector = invocation.selector;
    dispatch_semaphore_wait(_sema, DISPATCH_TIME_FOREVER);
    for (id delegate in _delegates) {
        if ([delegate respondsToSelector:selector]) {
            // the invocation must duplicated before invoke (because each invacation has different target property)
            NSInvocation *dupInvocation = [self duplicateInvocation:invocation];
            dupInvocation.target = delegate;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [dupInvocation invoke];
            });
        }
    }
    dispatch_semaphore_signal(_sema);
}

- (NSInvocation *)duplicateInvocation:(NSInvocation *)origInvocation {
    NSMethodSignature *methodSignature = [origInvocation methodSignature];
    NSInvocation *dupInvocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [dupInvocation setSelector:[origInvocation selector]];
    
    NSUInteger count = [methodSignature numberOfArguments];
    for (NSUInteger i = 2; i < count; i++) {
        const char *type = [methodSignature getArgumentTypeAtIndex:i];
        
        if (*type == *@encode(BOOL)) {
            BOOL value;
            [origInvocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(char) || *type == *@encode(unsigned char)) {
            char value;
            [origInvocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(short) || *type == *@encode(unsigned short)) {
            short value;
            [origInvocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(int) || *type == *@encode(unsigned int)) {
            int value;
            [origInvocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(long) || *type == *@encode(unsigned long)) {
            long value;
            [origInvocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(long long) || *type == *@encode(unsigned long long)) {
            long long value;
            [origInvocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(double)) {
            double value;
            [origInvocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(float)) {
            float value;
            [origInvocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == '@') {
            void *value;
            [origInvocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == '^') {
            void *block;
            [origInvocation getArgument:&block atIndex:i];
            [dupInvocation setArgument:&block atIndex:i];
        }
        else {
            NSString *selectorStr = NSStringFromSelector([origInvocation selector]);
            NSString *format = @"Argument %lu to method %@ - Type(%c) not supported";
            NSString *reason = [NSString stringWithFormat:format, (unsigned long)(i - 2), selectorStr, *type];
            [[NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil] raise];
        }
    }
    [dupInvocation retainArguments];
    
    return dupInvocation;
}

@end
