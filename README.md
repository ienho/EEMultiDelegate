# EEMultiProxy

![support](https://img.shields.io/badge/cocoaPod-0.2.0-green.svg)
![platform](https://img.shields.io/badge/platform-iOS-blue.svg)

A `multicast-delegate` class with thread-safe

# Cocoa Pods

> pod 'EEMultiDelegate', :git => "https://github.com/ienho/EEMultiDelegate.git"

or 

> pod 'EEMultiDelegate'

# Example

1. Let `MessageService` support `multicast-delegate` use `EEMultiProxy`

```objc

#import <Foundation/Foundation.h>

@protocol MessageReceiveDelegate <NSObject>

- (void)receiveMessage:(NSString *)message;

@end

@interface MessageService : NSObject

- (void)stopReceive;
- (void)receiveNewMessage;

@end

```

```objc
#import "MessageService.h"
#import <EEMultiDelegate/NSObject+EEMultiProxyAddition.h>

@implementation MessageService {
    dispatch_source_t _timer;
}

- (void)stopReceive {
    if (_timer) {
        dispatch_cancel(_timer);
        _timer = nil;
    }
}

- (void)receiveNewMessage {
    static NSInteger count = 0;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        NSString *newMessage = [NSString stringWithFormat:@"message %ld", (long)count];
        NSLog(@"--- --- --- --- --- --- --- --- --- --- --- --- --- ---");
        NSLog(@"the service receiving new message : %@", newMessage);
        [EEProxy(MessageReceiveDelegate) receiveMessage:newMessage];
        count++;
    });
    dispatch_resume(_timer);
}

@end

```

2. `MessagePanel` implement delegate `MessageReceiveDelegate`

```objc

@implementation MessagePanel

- (instancetype)initWithName:(NSString *)name service:(MessageService *)service {
    if (self = [super init]) {
        _name = [name copy];
        [service ee_addDelegate:self];
    }
    return self;
}

- (void)showMessage:(NSString *)message {
    NSLog(@"MessagePanel-%@ show message : %@", _name, message);
}

#pragma mark - MessageReceiveDelegate

- (void)receiveMessage:(NSString *)message {
    [self showMessage:message];
}

@end

```

3. the _panel1, _panel2, _panel3
will be invoke method  `receiveMessage`.

```objc

_service = MessageService.new;

_panel1 = [[MessagePanel alloc] initWithName:@"A" service:_service];
_panel2 = [[MessagePanel alloc] initWithName:@"B" service:_service];
_panel3 = [[MessagePanel alloc] initWithName:@"C" service:_service];

[_service receiveNewMessage];

```
