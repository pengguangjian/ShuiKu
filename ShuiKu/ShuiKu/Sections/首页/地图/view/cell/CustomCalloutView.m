//
//  CustomCalloutView.m
//  WisdomSchool
//
//  Created by Resuming on 2018/11/4.
//  Copyright © 2018年 Resuming. All rights reserved.
//

#define kTitleWidth         100
#define kTitleHeight        20

#import "CustomCalloutView.h"

@interface CustomCalloutView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *stateTitleLabel;

@property (nonatomic, strong) UIImageView *imgvitem;

@end

@implementation CustomCalloutView

- (void)drawRect:(CGRect)rect
{
    
//    self.layer.borderColor = [UIColor blueColor].CGColor;
//    self.layer.borderWidth = 2.0f;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    
    // 添加标题
//    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.width-20, kTitleHeight)];
//    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
//    self.titleLabel.textColor = RGB(100, 100, 100) ;
//    self.titleLabel.text = @"titletitletitletitle";
//    [self addSubview:self.titleLabel];
//
//    // 添加副标题
//    self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLabel.bottom, self.width-20, self.height-self.titleLabel.bottom)];
//    self.subTitleLabel.font = [UIFont systemFontOfSize:14];
//    self.subTitleLabel.textColor = RGB(100, 100, 100) ;
//    self.subTitleLabel.numberOfLines = 0;
//    self.subTitleLabel.text = @"subtitleLabelsubtitleLabelsubtitleLabel";
//    [self addSubview:self.subTitleLabel];
    self.imgvitem = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    [self.imgvitem setImage:[UIImage imageNamed:@"dingweidianji"]];
    [self addSubview:self.imgvitem];
    
    
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setSubTitle:(NSString *)subTitle
{
    self.subTitleLabel.text = subTitle;
}

@end
