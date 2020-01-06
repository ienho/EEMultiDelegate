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
                         aByte:(Byte)aByte;

@end

@interface MessageService : NSObject

- (void)stopReceive;
- (void)receiveNewMessage;

@end
