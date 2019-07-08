//
//  MessagePanel.h
//  EEMultiProxyDemo
//
//  Created by ian  on 2017/9/9.
//  Copyright © 2017年 ian. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyService;

@interface MessagePanel : NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name service:(MyService *)service;

@end
