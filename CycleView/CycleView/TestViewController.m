//
//  TestViewController.m
//  CycleView
//
//  Created by YiXue on 2017/4/20.
//  Copyright © 2017年 赵刘磊. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(0, 0, 50, 25);
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}
- (void)clicked:(UIButton *)btn
{
    NSLog(@"%p",btn);
}


@end
