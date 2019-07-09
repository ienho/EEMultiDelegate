//
//  EEViewController.m
//  EEMultiDelegate
//
//  Created by ian<https://github.com/ienho> on 07/08/2019.
//  Copyright (c) 2019 ian. All rights reserved.
//

#import "EEViewController.h"
#import "EESecondViewController.h"

@implementation EEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 50)];
    btn.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    btn.backgroundColor = [UIColor blackColor];
    btn.tintColor = [UIColor whiteColor];
    [btn setTitle:@"go" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)buttonClicked {
    EESecondViewController *secondViewController = [[EESecondViewController alloc] init];
    [self presentViewController:secondViewController animated:YES completion:nil];
}

@end
