//
//  SecondViewController.m
//  练习
//
//  Created by 付金诗 on 15/6/18.
//  Copyright (c) 2015年 www.fujinshi.com. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"播放咯";
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
}
@end
