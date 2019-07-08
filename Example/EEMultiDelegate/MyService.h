//
//  MyService.h
//  EEMultiProxyDemo
//
//  Created by ian  on 2017/9/9.
//  Copyright © 2017年 ian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EEMultiProxy.h"

@protocol MessageReceiveDelegate <NSObject>

- (void)receiveMessage:(NSString *)message;

@end

@interface MyService : NSObject

- (void)addDelegate:(id<MessageReceiveDelegate>)delegate;
- (void)removeDelegate:(id<MessageReceiveDelegate>)delegate;
- (void)receiveNewMessage;

@end
