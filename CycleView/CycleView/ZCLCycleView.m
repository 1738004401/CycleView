//
//  ZCLCycleView.m
//  CycleView
//
//  Created by YiXue on 2017/4/20.
//  Copyright © 2017年 赵刘磊. All rights reserved.
//

#import "ZCLCycleView.h"
static NSString * const reuseIdentifier = @"ControllerCell";

@interface ZCLCycleView ()<UICollectionViewDelegate,UICollectionViewDataSource>

/**
 利用CollectionView的复用特性
 */
@property (weak, nonatomic) UICollectionView *collectionView;

/**
 CollectionViewCell的布局
 */
@property (weak, nonatomic) UICollectionViewFlowLayout *flowLayout;

/**
 *父控制器
 */
@property (weak, nonatomic) UIViewController *parentvc;


@end
@implementation ZCLCycleView

#pragma mark 对外创建的实例
+ (instancetype)ChildControllers:(NSArray<UIViewController*> *)array parentController:(UIViewController *)parentvc childControllerFrame:(CGRect)ChildControllectframe
{
    //1.0 将CycleView添加到父控制器上
    ZCLCycleView *cycleView = [[ZCLCycleView alloc] init];
    [parentvc.view addSubview:cycleView];
    
    //2.0 设置对应属性
    
    cycleView.childControllerFrame = ChildControllectframe;
    cycleView.controllers = array;
    cycleView.parentvc = parentvc;
    
   
    
    return cycleView;

}
#pragma mark 动态改变自控制器数据源
- (void)setControllers:(NSArray *)controllers
{
    
    _controllers = controllers;
    
    //1.0  循环view.size == collectionview.size == cell.size == flowLayout.size
    self.frame = _childControllerFrame;
    self.collectionView.frame = CGRectMake(0, 0, _childControllerFrame.size.width, _childControllerFrame.size.height) ;
    self.flowLayout.itemSize = self.collectionView.frame.size;
    
    for (UIViewController *vc in controllers) {
        
        [_parentvc addChildViewController:vc];
        
    }
    [self.collectionView reloadData];
}


#pragma mark 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        //1.0 Cell 布局
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout = flowLayout;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        //2.0 创建CollectionView
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:kScreen_Bounds collectionViewLayout:flowLayout];
        _collectionView = collectionView;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.pagingEnabled = YES;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [self addSubview:collectionView];
        
        //3.0 禁用滚动到最顶部的属性
        self.collectionView.scrollsToTop = NO;
        
        
    }
    return self;
}
#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.controllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //1.0 取出cell
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //2.0 设置Cell上ViewController.View 的尺寸
    UIView *view = [self.controllers[indexPath.row] view];
    [cell.contentView addSubview:view];
    view.frame = cell.bounds;
    
    return cell;
}
#pragma mark 对外属性
#pragma mark - collectionView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / self.bounds.size.width;
    
    if (self.IndexHasChangedBlock) {
        self.IndexHasChangedBlock(index);
    }
}

#pragma mark - setting

- (void)setCurrentIndex:(NSUInteger)currentIndex
{
    _currentIndex = currentIndex;
    CGFloat offsetX = self.bounds.size.width * currentIndex;
    self.collectionView.contentOffset = CGPointMake(offsetX, 0);
}

- (void)setHorScrollEnabled:(BOOL)horScrollEnabled
{
    _horScrollEnabled = horScrollEnabled;
    self.collectionView.scrollEnabled = horScrollEnabled;
}

@end
