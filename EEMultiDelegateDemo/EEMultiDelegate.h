//
//  EEMultiDelegate.h
//
//  a multicast delegate class with thread-safe
//
//  Created by ian  on 2017/9/9.
//  Copyright © 2017年 ian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EEMultiDelegate : NSObject

+ (EEMultiDelegate *)multiDelegate;
- (void)addDelegate:(id)delegate;
- (void)removeDelete:(id)delegate;

@end
