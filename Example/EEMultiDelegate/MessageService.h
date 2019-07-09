//
//  MessageService.h
//  EEMultiProxyDemo
//
//  Created by ian<https://github.com/ienho> on 2017/9/9.
//  Copyright © 2017年 ian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MessageReceiveDelegate <NSObject>

- (void)receiveMessage:(NSString *)message;

@end

@interface MessageService : NSObject

- (void)stopReceive;
- (void)receiveNewMessage;

@end
