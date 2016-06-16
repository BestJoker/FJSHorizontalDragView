//
//  BQPlayVideoRightView.m
//  练习
//
//  Created by 付金诗 on 15/6/17.
//  Copyright (c) 2015年 www.fujinshi.com. All rights reserved.
//

#import "BQPlayVideoRightView.h"
#import <objc/runtime.h>
#import "DragPlayVideoView.h"
@interface BQPlayVideoRightView ()
@property (assign, nonatomic) NSInteger lastRefreshCount;
@property (nonatomic,strong) DragPlayVideoView * dragPlayView;
@end
@implementation BQPlayVideoRightView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        self.dragPlayView = [[DragPlayVideoView alloc] initWithFrame:self.bounds];
        self.dragPlayView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.dragPlayView];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.dragPlayView setFrame:self.bounds];
}

+ (instancetype)header
{
    return [[BQPlayVideoRightView alloc] init];
}

#pragma mark 监听UIScrollView的属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //     不能跟用户交互就直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;
    
    if ([BQPlayVideoContentSize isEqualToString:keyPath]) {
        
        [self adjustFrameWithContentSize];
        
    }else if ([BQPlayVideoViewOffset isEqualToString:keyPath]) {
#warning 这个返回一定要放这个位置
        if (self.state == BQPlayStatePlaying) return;
        // 调整状态
        [self adjustStateWithContentOffset];
    }
}

/**
 *  调整状态
 */
- (void)adjustStateWithContentOffset
{
    // 当前的contentOffset
    CGFloat currentOffsetX = self.scrollView.contentOffset.x;
    // 尾部控件刚好出现的offsetY
    CGFloat happenOffsetY = [self happenOffsetX];
    
    // 如果是向下滚动到看不见尾部控件，直接返回
    if (currentOffsetX <= happenOffsetY)
    {
        return;
    }
    
    if (self.scrollView.isDragging) {
#warning 在此修改的刷新临界点
        // 普通 和 即将刷新 的临界点
        CGFloat normal2pullingOffsetY = happenOffsetY + BQPlayVideoRightSizeWidth;
//        NSLog(@"%f========%f",normal2pullingOffsetY,currentOffsetX);
        if (self.state == BQPlayStateNormal && currentOffsetX > normal2pullingOffsetY) {
            NSLog(@"即将转为刷新状态");
            // 转为即将刷新状态
            self.state = BQPlayStatePulling;
        } else if (self.state == BQPlayStatePulling && currentOffsetX <= normal2pullingOffsetY) {
            // 转为普通状态
            NSLog(@"即将转为普通状态");
            self.state = BQPlayStateNormal;
        }
    } else if (self.state == BQPlayStatePulling) {// 即将刷新 && 手松开
        self.state = BQPlayStatePlaying;
    }
}




-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    [self.superview removeObserver:self forKeyPath:BQPlayVideoContentSize context:nil];
    
    if (newSuperview) {
        // 新的父控件
        [newSuperview addObserver:self forKeyPath:BQPlayVideoContentSize options:NSKeyValueObservingOptionNew context:nil];
        
        // 重新调整frame
        [self adjustFrameWithContentSize];
    }
}

#pragma mark 重写调整frame
- (void)adjustFrameWithContentSize
{
    // 内容的宽度
    CGFloat contentHeight = self.scrollView.contentSize.width;
    // 表格的宽度
    CGFloat scrollHeight = self.scrollView.bounds.size.width - self.scrollView.contentInset.right;
    
    // 设置位置和尺寸
    CGRect frame = self.frame;
    frame.origin.x = MAX(contentHeight, scrollHeight) + 10;
    self.frame = frame;
}

#pragma mark 获得scrollView的内容 超出 view 的高度
- (CGFloat)heightForContentBreakView
{
    CGFloat h = self.scrollView.frame.size.width - self.scrollViewOriginalInset.right - self.scrollViewOriginalInset.left;
    return self.scrollView.contentSize.width - h;
}

#pragma mark - 在父类中用得上
/**
 *  刚好看到上拉刷新控件时的contentOffset.x
 */
- (CGFloat)happenOffsetX
{
    CGFloat deltaH = [self heightForContentBreakView];
    if (deltaH > 0) {
        return deltaH - self.scrollViewOriginalInset.right;
    } else {
        return - self.scrollViewOriginalInset.right;
    }
}


#pragma mark 设置状态
#pragma mark 设置状态
- (void)setState:(BQPlayState)state
{
    // 1.一样的就直接返回
    if (self.state == state) return;
    
    // 2.保存旧状态
    BQPlayState oldState = self.state;
    
    // 3.调用父类方法
    [super setState:state];
    
    // 4.根据状态来设置属性
    switch (state)
    {
        case BQPlayStateNormal:
        {
            NSLog(@"正常状态");
            self.backgroundColor = [UIColor greenColor];
            self.dragPlayView.statue = 0;
            // 刷新完毕
            if (BQPlayStatePlaying == oldState) {
                [UIView animateWithDuration:BQPlayVideoAnimationDuration animations:^{
                    
                }];
            } else {
                // 执行动画
                [UIView animateWithDuration:BQPlayVideoAnimationDuration animations:^{
                    
                }];
            }
            CGFloat deltaH = [self heightForContentBreakView];
            int currentCount = [self totalDataCountInScrollView];
            // 刚刷新完毕
            if (BQPlayStatePlaying == oldState && deltaH > 0 && currentCount != self.lastRefreshCount) {
                self.scrollView.contentOffsetX = self.scrollView.contentOffsetX;
            }
            break;
        }
            
        case BQPlayStatePulling:
        {
            self.backgroundColor = [UIColor yellowColor];
            self.dragPlayView.statue = 1;
            [UIView animateWithDuration:BQPlayVideoAnimationDuration animations:^{
                
            }];
            break;
        }
            
        case BQPlayStatePlaying:
        {
            // 记录刷新前的数量
            self.lastRefreshCount = [self totalDataCountInScrollView];
            [UIView animateWithDuration:BQPlayVideoAnimationDuration animations:^{

            }];
            break;
        }
            
        default:
            break;
    }
}

- (int)totalDataCountInScrollView
{
    int totalCount = 0;
    if ([self.scrollView isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self.scrollView;
        
        for (int section = 0; section<tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self.scrollView isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self.scrollView;
        
        for (int section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
