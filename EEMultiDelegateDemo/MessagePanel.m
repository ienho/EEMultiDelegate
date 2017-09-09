//
//  MessagePanel.m
//  EEMultiDelegateDemo
//
//  Created by ian  on 2017/9/9.
//  Copyright © 2017年 ian. All rights reserved.
//

#import "MessagePanel.h"
#import "MyService.h"

@interface MessagePanel() <MessageReceiveDelegate>

@end

@implementation MessagePanel

- (instancetype)initWithName:(NSString *)name service:(MyService *)service {
    if (self = [super init]) {
        _name = [name copy];
        [service addDelegate:self];
    }
    return self;
}

- (void)showMessage:(NSString *)message {
    NSLog(@"MessagePanel [%@] show message : %@", _name, message);
}

#pragma mark - MessageReceiveDelegate

- (void)receiveMessage:(NSString *)message {
    [self showMessage:message];
}

@end
