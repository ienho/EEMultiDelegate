//
//  EESecondViewController.m
//  EEMultiDelegate_Example
//
//  Created by iMAC_HYH on 2019/7/9.
//  Copyright © 2019 hyhshiwool@163.com. All rights reserved.
//

#import "EESecondViewController.h"
#import "MessageService.h"
#import "MessagePanel.h"

@interface EESecondViewController () {
    MessageService *_service;
    MessagePanel *_panel1;
    MessagePanel *_panel2;
    MessagePanel *_panel3;
}

@end

@implementation EESecondViewController

- (void)dealloc {
    [_service stopReceive];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *btnSendMessage = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 50)];
    btnSendMessage.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    btnSendMessage.backgroundColor = [UIColor blackColor];
    btnSendMessage.tintColor = [UIColor whiteColor];
    [btnSendMessage setTitle:@"send message" forState:UIControlStateNormal];
    [btnSendMessage addTarget:self action:@selector(sendClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSendMessage];
    
    UIButton *btnClose = [[UIButton alloc] initWithFrame:CGRectMake(btnSendMessage.frame.origin.x, btnSendMessage.frame.origin.y + btnSendMessage.frame.size.height + 24, 120, 50)];
    btnClose.backgroundColor = [UIColor blackColor];
    btnClose.tintColor = [UIColor whiteColor];
    [btnClose setTitle:@"close" forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(closeClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnClose];
    
    _service = MessageService.new;
    
    _panel1 = [[MessagePanel alloc] initWithName:@"A" service:_service];
    _panel2 = [[MessagePanel alloc] initWithName:@"B" service:_service];
    _panel3 = [[MessagePanel alloc] initWithName:@"C" service:_service];
}

- (void)sendClicked {
    [_service receiveNewMessage];
}

- (void)closeClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
