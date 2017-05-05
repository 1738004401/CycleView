//
//  ViewController.m
//  CycleView
//
//  Created by YiXue on 2017/4/20.
//  Copyright © 2017年 赵刘磊. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "ZCLCycleView.h"
#import "UIColor+Expanded.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSMutableArray<UIViewController *> *vcs = [NSMutableArray array];
    for (int i = 0; i < 30; i++) {
        TestViewController *vc = [[TestViewController alloc]init];
        vc.title = [NSString stringWithFormat:@"%d",i];
        vc.view.backgroundColor = [UIColor randomColor];
        [vcs addObject:vc];
    }
    
    ZCLCycleView *cycleView = [ZCLCycleView ChildControllers:vcs parentController:self childControllerFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height - 64)];
    [cycleView setIndexHasChangedBlock:^(NSUInteger index){
        NSLog(@"%lu",index);
    }];
}




@end
