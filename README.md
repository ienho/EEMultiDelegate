# EEMultiProxy

![support](https://img.shields.io/badge/cocoaPod-0.0.1-green.svg)
![platform](https://img.shields.io/badge/platform-iOS-blue.svg)

A `multicast`/`multidelegate` class with thread-safe

# Cocoa Pods

> pod 'EEMultiDelegate', :git => "https://github.com/GrayLand119/EEMultiDelegate.git"

or 

> pod 'EEMultiDelegate'

# Example

```objc

@protocol MyDelegate <NSObject>
- (void)delegateMethodA:(NSString *)message;
- (void)delegateMethodB:(NSString *)message;
@end

@interface MyService : NSObject

- (void)addDelegate:(id<MyDelegate>)delegate;
- (void)removeDelegate:(id<MyDelegate>)delegate;
- (void)removeAllDelegates;

- (void)doSomethingWillCallDelegate;

@end

@implementation MyService {
    EEMultiProxy *_proxy;
}

- (instancetype)init {
    if (self = [super init]) {
        _proxy = [EEMultiProxy proxy];
    }
    return self;
}

- (void)addDelegate:(id<MyDelegate>)delegate {
    [_proxy addDelegate:delegate];
}

- (void)removeDelegate:(id<MyDelegate>)delegate {
    [_proxy removeDelete:delegate];
}

- (void)removeAllDelegates {
	[_proxy removeAllDelegates];
}

- (void)doSomethingWillCallDelegate {
	[(id<MyDelegate>)_proxy delegateMethodA:@"doSomethingWillCallDelegate"];
}

```

```objc
MyService *service;
UIViewController *controllerA;
UIViewController *controllerB;
UIViewController *controllerC;

[service addDelegate:controllerA];
[service addDelegate:controllerB];
[service addDelegate:controllerC];

[service doSomethingWillCallDelegate];

// Then controllerA, controllerB, controllerC
// will be invoke with the delegate's method if they had implement.
...


```
