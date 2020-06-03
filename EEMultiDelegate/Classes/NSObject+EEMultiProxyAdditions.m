//
//  NSObject+EEMultiProxyAdditions.m
//  EEMultiDelegate
//
//  Created by ian<https://github.com/ienho>. on 2019/7/8.
//  Copyright © 2019 ian. All rights reserved.
//

#import "NSObject+EEMultiProxyAdditions.h"
#import <objc/runtime.h>

@implementation NSObject (EEMultiProxyAdditions)

#pragma mark - Public Methods

- (void)ee_addDelegate:(id)delegate {
    [self.ee_multiProxy addDelegate:delegate];
}

- (void)ee_removeDelegate:(id)delegate {
    [self.ee_multiProxy removeDelete:delegate];
}

- (void)ee_removeAllDelegates {
    [self.ee_multiProxy removeAllDelegates];
}

#pragma mark - Getters and Setters

- (EEMultiProxy *)ee_multiProxy {
    @synchronized (self) {
        EEMultiProxy *proxy = objc_getAssociatedObject(self, @selector(ee_multiProxy));
        if (!proxy) {
            proxy = EEMultiProxy.proxy;
            objc_setAssociatedObject(self, @selector(ee_multiProxy), proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        return proxy;
    }
}

@end
