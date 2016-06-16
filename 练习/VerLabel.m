//
//  VerLabel.m
//  练习
//
//  Created by 付金诗 on 15/6/18.
//  Copyright (c) 2015年 www.fujinshi.com. All rights reserved.
//

#import "VerLabel.h"

@interface VerLabel ()
@property (nonatomic,assign)CGFloat lineSpace;

@end
@implementation VerLabel

-(instancetype)initWithFrame:(CGRect)frame andText:(NSString *)string andLineSpace:(CGFloat)lineSpace andfontSize:(CGFloat)fontSize andTextColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineSpace = lineSpace;
        self.font = [UIFont systemFontOfSize:fontSize];
        self.textColor = color;
        self.text = string;
        self.textAlignment = 1;
    }
    return self;
    
}
-(void)drawRect:(CGRect)rect
{

    float view_height = self.frame.size.height;
    float view_width = self.frame.size.width;
    
    float start_x = 0;
    float start_y = 0;
    float width = self.font.pointSize;
    float height = self.font.pointSize + 1;
    float x;
    float y;
    
    start_x = view_width - width;
    
    NSInteger charNumber;
    
    NSInteger containerNumber;
    
    containerNumber = floor(view_width/height);
    
    charNumber = floor(view_height/height);
    
    NSString * drawStr = self.text;
    
    NSInteger lineNumber = ceilf([drawStr length] / charNumber);

    
    
    if (lineNumber >= containerNumber) {
        NSRange range;
        range.location = 0;
        range.length = containerNumber * charNumber - 1;
        NSLog(@"%ld======%ld",(long)containerNumber,(long)charNumber);

        drawStr = [drawStr substringWithRange:range];
        drawStr = [drawStr stringByAppendingFormat:@"..."];
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineSpacing = self.lineSpace; //行距
    
    NSDictionary *attributes = @{ NSFontAttributeName:self.font,NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:self.textColor};
    
    for (NSInteger i = 0; i < [drawStr length]; i++) {
        x = start_x - floor(i / charNumber) * width;
        y = start_y + (i % charNumber) * height;
        CGRect Aframe = CGRectMake(x, y, width, height);
        NSRange range;
        range.length = 1;
        range.location = i;
        NSString * str = [drawStr substringWithRange:range];
        [str drawInRect:Aframe withAttributes:attributes];
    }
    
}
@end
