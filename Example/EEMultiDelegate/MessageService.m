//
//  MyService.m
//  EEMultiProxyDemo
//
//  Created by ian<https://github.com/ienho> on 2017/9/9.
//  Copyright © 2017年 ian. All rights reserved.
//

#import "MessageService.h"
#import <EEMultiDelegate/NSObject+EEMultiProxyAddition.h>

@implementation MessageService {
    dispatch_source_t _timer;
}

- (void)stopReceive {
    if (_timer) {
        dispatch_cancel(_timer);
        _timer = nil;
    }
}

- (void)receiveNewMessage {
    static NSInteger count = 0;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        NSString *newMessage = [NSString stringWithFormat:@"message %ld", (long)count];
        NSLog(@"--- --- --- --- --- --- --- --- --- --- --- --- --- ---");
        NSLog(@"the service receiving new message : %@", newMessage);
        [EEProxy(MessageReceiveDelegate) receiveMessage:newMessage];
        count++;
    });
    dispatch_resume(_timer);
}

@end
