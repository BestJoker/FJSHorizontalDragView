//
//  BQPlayVideoBaseView.m
//  练习
//
//  Created by 付金诗 on 15/6/17.
//  Copyright (c) 2015年 www.fujinshi.com. All rights reserved.
//

#import "BQPlayVideoBaseView.h"
#import <objc/message.h>


@implementation BQPlayVideoBaseView

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    frame.size.height = BQPlayVideoViewHeight;
    if (self = [super initWithFrame:frame]) {
        // 1.自己的属性
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor whiteColor];
        // 2.设置默认状态
        self.state = BQPlayStateNormal;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 旧的父控件
    [self.superview removeObserver:self forKeyPath:BQPlayVideoViewOffset context:nil];
    if (newSuperview) { // 新的父控件
        [newSuperview addObserver:self forKeyPath:BQPlayVideoViewOffset options:NSKeyValueObservingOptionNew context:nil];
        // 设置宽度
        self.width = newSuperview.width;
        // 设置位置
        self.x = 0;
        // 记录UIScrollView
        _scrollView = (UIScrollView *)newSuperview;
        // 记录UIScrollView最开始的contentInset
        _scrollViewOriginalInset = _scrollView.contentInset;
    }
}


#pragma mark 是否正在刷新
- (BOOL)isRefreshing
{
    return BQPlayStatePlaying == self.state;
}


- (void)setState:(BQPlayState)state
{
    // 0.存储当前的contentInset
    if (self.state != BQPlayStatePlaying) {
        _scrollViewOriginalInset = self.scrollView.contentInset;
    }
    
    // 1.一样的就直接返回
    if (self.state == state) return;
    // 2.根据状态执行不同的操作
    switch (state) {
        case BQPlayStateNormal: // 普通状态
        {
#warning 这里要做普通状态的设置
//            // 显示箭头
//            self.arrowImage.hidden = NO;
//            // 停止转圈圈
//            [self.activityView stopAnimating];
            break;
        }
        case BQPlayStatePulling:
            break;
        case BQPlayStatePlaying:
        {
#warning  这里要进行正在播放的处理
//            // 开始转圈圈
//            [self.activityView startAnimating];
//            // 隐藏箭头
//            self.arrowImage.hidden = YES;
            // 回调
            if ([self.beginRefreshingTaget respondsToSelector:self.beginRefreshingAction]) {
                objc_msgSend(self.beginRefreshingTaget, self.beginRefreshingAction, self);
            }
//            if (self.beginRefreshingCallback) {
//                self.beginRefreshingCallback();
//            }
            break;
        }
        default:
            break;
    }
    // 3.存储状态
    _state = state;
    
}

/**
 *  结束刷新
 */
- (void)finishPlayVideo
{
    double delayInSeconds = 0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.state = BQPlayStateNormal;
    });
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
