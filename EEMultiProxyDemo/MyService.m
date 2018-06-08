//
//  MyService.m
//  EEMultiProxyDemo
//
//  Created by ian  on 2017/9/9.
//  Copyright © 2017年 ian. All rights reserved.
//

#import "MyService.h"

@implementation MyService {
    EEMultiProxy *_proxy;
}

- (instancetype)init {
    if (self = [super init]) {
        _proxy = [EEMultiProxy proxy];
    }
    return self;
}

- (void)addDelegate:(id<MessageReceiveDelegate>)delegate {
    [_proxy addDelegate:delegate];
}

- (void)removeDelegate:(id<MessageReceiveDelegate>)delegate {
    [_proxy removeDelete:delegate];
}

- (void)receiveNewMessage {
    static NSInteger count = 0;
    NSString *newMessage = [NSString stringWithFormat:@"message %ld", (long)count];
    NSLog(@"receive new message : %@", newMessage);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        // call method
        [(id<MessageReceiveDelegate>)_proxy receiveMessage:newMessage];
    });
    count ++;
}

@end
