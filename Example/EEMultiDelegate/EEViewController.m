//
//  EEViewController.m
//  EEMultiDelegate
//
//  Created by hyhshiwool@163.com on 07/08/2019.
//  Copyright (c) 2019 hyhshiwool@163.com. All rights reserved.
//

#import "EEViewController.h"
#import "MyService.h"
#import "MessagePanel.h"

@interface EEViewController () {
    MyService *_service;
    MessagePanel *_panel1;
    MessagePanel *_panel2;
    MessagePanel *_panel3;
}

@end

@implementation EEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 50)];
    btn.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    btn.backgroundColor = [UIColor blackColor];
    btn.tintColor = [UIColor whiteColor];
    [btn setTitle:@"receive" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    _service = [[MyService alloc] init];
    _panel1 = [[MessagePanel alloc] initWithName:@"A" service:_service];
    _panel2 = [[MessagePanel alloc] initWithName:@"B" service:_service];
    _panel3 = [[MessagePanel alloc] initWithName:@"C" service:_service];
}

- (void)buttonClick {
    [_service receiveNewMessage];
}

@end
