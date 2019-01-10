//
//  EEMultiProxy.h
//
//  a multicast delegate class with thread-safe
//
//  Created by ian  on 2017/9/9.
//  Copyright © 2017 ian<https://github.com/ienho>. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EEMultiProxy : NSProxy

@property (nonatomic, assign) BOOL runInMainThread;///< Default is YES

/**
 create a EEMultiProxy instance when you add the multicast delegate funciton to your class

 @return new instance
 */
+ (EEMultiProxy *)proxy;

/**
 add a delegate to the list
 */
- (void)addDelegate:(id)delegate;

/**
 remove a delegate from the list
 */
- (void)removeDelete:(id)delegate;


/**
 Remove all delegates from the list
 */
- (void)removeAllDelegates;

@end
