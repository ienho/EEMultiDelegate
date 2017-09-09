//
//  MyService.m
//  EEMultiDelegateDemo
//
//  Created by ian  on 2017/9/9.
//  Copyright © 2017年 ian. All rights reserved.
//

#import "MyService.h"

@implementation MyService {
    EEMultiDelegate *_multiDelegate;
}

- (instancetype)init {
    if (self = [super init]) {
        _multiDelegate = [[EEMultiDelegate alloc] init];
    }
    return self;
}

- (void)addDelegate:(id<MessageReceiveDelegate>)delegate {
    [_multiDelegate addDelegate:delegate];
}

- (void)receiveNewMessage {
    static NSInteger count = 0;
    NSString *newMessage = [NSString stringWithFormat:@"message %ld", (long)count];
    NSLog(@"receive new message : %@", newMessage);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        // call multicast delegates
        [(id<MessageReceiveDelegate>)_multiDelegate receiveMessage:newMessage];
    });
    count ++;
}

@end
