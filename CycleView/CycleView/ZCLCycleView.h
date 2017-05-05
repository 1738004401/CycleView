//
//  ZCLCycleView.h
//  CycleView
//
//  Created by YiXue on 2017/4/20.
//  Copyright © 2017年 赵刘磊. All rights reserved.
//

#define kScreen_Bounds          [UIScreen mainScreen].bounds
#define kScreen_Height          [UIScreen mainScreen].bounds.size.height
#define kScreen_Width           [ UIScreen mainScreen].bounds.size.width


#import <UIKit/UIKit.h>

@interface ZCLCycleView : UIView
/**
 *  设置当前索引
 */
@property (nonatomic, copy) void (^IndexHasChangedBlock)(NSUInteger Index);

/**
 * 水平方向是否可以被用户滑动
 */
@property(nonatomic,assign) BOOL horScrollEnabled;

/**
 *  设置当前选中页面
 */
@property (nonatomic , assign)NSUInteger currentIndex;

/**
 *  设置自控制器的frame
 */
@property (nonatomic , assign)CGRect childControllerFrame;


/*
 子控制器
 **/
@property (nonatomic, strong) NSArray *controllers;


+ (instancetype)ChildControllers:(NSArray<UIViewController*> *)array parentController:(UIViewController *)parentvc childControllerFrame:(CGRect)ChildControllectframe;

@end
