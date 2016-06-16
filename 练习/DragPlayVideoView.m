//
//  DragPlayVideoView.m
//  练习
//
//  Created by 付金诗 on 15/6/18.
//  Copyright (c) 2015年 www.fujinshi.com. All rights reserved.
//

#import "DragPlayVideoView.h"
#import "VerLabel.h"
#define LABEL_ORIGN_X 30
#define LABEL_ORIGN_Y 25
#define LABEL_SIZE_WIDTH 25

@interface DragPlayVideoView ()
@property (nonatomic,strong)VerLabel * label;
@property (nonatomic,strong)UIImageView * arrowImageView;
@end
@implementation DragPlayVideoView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 90, 20, 20)];
//        self.arrowImageView.backgroundColor = [UIColor redColor];
        self.arrowImageView.image = [UIImage imageNamed:@"0"];
        [self addSubview:self.arrowImageView];
        
        self.label = [[VerLabel alloc] initWithFrame:CGRectMake(LABEL_ORIGN_X, LABEL_ORIGN_Y, LABEL_SIZE_WIDTH, self.bounds.size.height - LABEL_ORIGN_Y * 2) andText:@"向左拖拽播放视频" andLineSpace:2 andfontSize:15 andTextColor:[UIColor blackColor]];
        [self addSubview:self.label];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)setStatue:(BOOL)statue
{
    NSString * imageName = statue?@"1":@"0";
    self.arrowImageView.image = [UIImage imageNamed:imageName];
}



@end
