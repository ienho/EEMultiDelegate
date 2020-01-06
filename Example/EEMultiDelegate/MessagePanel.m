//
//  MessagePanel.m
//  EEMultiProxyDemo
//
//  Created by ian<https://github.com/ienho>. on 2017/9/9.
//  Copyright © 2017年 ian. All rights reserved.
//

#import "MessagePanel.h"
#import "MessageService.h"
#import <EEMultiDelegate/NSObject+EEMultiProxyAddition.h>

@interface MessagePanel() <MessageReceiveDelegate>

@end

@implementation MessagePanel

- (instancetype)initWithName:(NSString *)name service:(MessageService *)service {
    if (self = [super init]) {
        _name = [name copy];
        [service ee_addDelegate:self];
    }
    return self;
}

- (void)showMessage:(NSString *)message {
    NSLog(@"MessagePanel-%@ show message : %@", _name, message);
}

#pragma mark - MessageReceiveDelegate

- (void)receiveMessage:(NSString *)message {
    [self showMessage:message];
}

// type test
- (void)receiveMessageTypeTest:(NSString *)message
                           obj:(NSObject *)obj
                        intger:(NSInteger)age
                          size:(CGSize)size
                         point:(CGPoint)point
                         array:(NSArray *)array
                           sel:(SEL)sel
                         block:(void(^)(void))block
                         cChar:(char)cChar
                        cArray:(int [])cArray
                        cPoint:(void *)cPoint
                         aByte:(Byte)aByte {
    NSLog(@"type test");
}

@end
