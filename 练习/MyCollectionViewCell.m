//
//  MyCollectionViewCell.m
//  练习
//
//  Created by 付金诗 on 15/6/17.
//  Copyright (c) 2015年 www.fujinshi.com. All rights reserved.
//

#import "MyCollectionViewCell.h"
@interface MyCollectionViewCell ()
@end
@implementation MyCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        self.label.backgroundColor = [UIColor whiteColor];
        self.label.textAlignment = 1;
        self.label.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:self.label];
    }
    return self;
}







-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.label setFrame:self.contentView.bounds];
}



@end
