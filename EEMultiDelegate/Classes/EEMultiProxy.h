//
//  EEMultiProxy.h
//
//  A multicast delegate class with thread-safe
//
//  Created by ian<https://github.com/ienho> on 2017/9/9.
//  Copyright © 2017 ian. All rights reserved.
//

#import <Foundation/Foundation.h>

///
/// All delegate's methods will responds in async thread [default in main thread]
///
/// ！！！
/// Not support arguments which type is 'union',
/// because it will be cause a crash when call the method [NSMethodSignature signatureWithObjCTypes:]
///
@interface EEMultiProxy : NSProxy

///
/// By default (YES), the proxy will invoke methods in main thread,
/// otherwise will invoke methods in a asyncronous thread
///
/// ！！！
/// runInMainThread only works when this.runAsynchronously = YES
///
@property (nonatomic, assign) BOOL runInMainThread;

///
/// By default (YES), the proxy will invoke methods asynchronously,
/// otherwise will invoke methods in current synchronously
///
@property (nonatomic, assign) BOOL runAsynchronously;

/// Create a instance when you add the multicast delegate funciton to your class
+ (EEMultiProxy *)proxy;

/// Add a delegate to the list
/// @param delegate : delegate
- (void)addDelegate:(id)delegate;

/// Remove a delegate from the list
/// @param delegate : delegate
- (void)removeDelete:(id)delegate;

/// Remove all delegates from the list
- (void)removeAllDelegates;

@end
