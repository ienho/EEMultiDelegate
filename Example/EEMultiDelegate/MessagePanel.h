//
//  MessagePanel.h
//  EEMultiProxyDemo
//
//  Created by ian<https://github.com/ienho>. on 2017/9/9.
//  Copyright © 2017年 ian. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MessageService;

@interface MessagePanel : NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name service:(MessageService *)service;

@end
