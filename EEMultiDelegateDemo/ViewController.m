//
//  ViewController.m
//  EEMultiDelegateDemo
//
//  Created by ian  on 2017/9/9.
//  Copyright © 2017年 ian. All rights reserved.
//

#import "ViewController.h"
#import "MyService.h"
#import "MessagePanel.h"

@interface ViewController () {
    MyService *_service;
    MessagePanel *_panel1;
    MessagePanel *_panel2;
    MessagePanel *_panel3;
}

@end

@implementation ViewController

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
