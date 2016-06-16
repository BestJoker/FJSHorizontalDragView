//
//  BQPlayVideoBaseView.h
//  练习
//
//  Created by 付金诗 on 15/6/17.
//  Copyright (c) 2015年 www.fujinshi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 控件的刷新状态
typedef enum {
    BQPlayStatePulling = 1, // 松开就可以进行刷新的状态
    BQPlayStateNormal = 2, // 普通状态
    BQPlayStatePlaying = 3,
} BQPlayState;

#pragma mark - 控件的类型
typedef enum {
    BQPlayVideoTypeLeft = -1, // 头部控件
    BQPlayVideoTypeRight = 1 // 尾部控件
} BQPlayVideoType;

@interface BQPlayVideoBaseView : UIView

#pragma mark - 父控件
@property (nonatomic, weak,readonly) UIScrollView *scrollView;

@property (nonatomic, assign, readonly) UIEdgeInsets scrollViewOriginalInset;
#pragma mark - 交给子类去实现 和 调用
@property (assign, nonatomic) BQPlayState state;

#pragma mark - 回调
/**
 *  开始进入刷新状态的监听器
 */
@property (weak, nonatomic) id beginRefreshingTaget;
/**
 *  开始进入刷新状态的监听方法
 */
@property (assign, nonatomic) SEL beginRefreshingAction;

#pragma mark - 刷新相关
/**
 *  是否正在刷新
 */
@property (nonatomic, readonly, getter=isRefreshing) BOOL refreshing;


/**
 *  结束刷新
 */
- (void)finishPlayVideo;


@end
