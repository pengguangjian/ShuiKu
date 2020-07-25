//
//  RiLiDayCollectionViewCell.m
//  WuYeYuanGongDuan
//
//  Created by Mac on 2020/6/29.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "RiLiDayCollectionViewCell.h"


@interface RiLiDayCollectionViewCell ()
@property (nonatomic , retain) UILabel *lbValue;

@property (nonatomic , retain) UIView *viewpoint;

@property (nonatomic , retain) UILabel *lbnumber;
@end

@implementation RiLiDayCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _lbValue = [[UILabel alloc] init];
        [_lbValue setTextColor:RGB(50, 50, 50)];
        [_lbValue setTextAlignment:NSTextAlignmentCenter];
        [_lbValue setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:_lbValue];
        [_lbValue.layer setMasksToBounds:YES];
        [_lbValue.layer setCornerRadius:13];
        [_lbValue.layer setBorderColor:RGB(200, 200, 200).CGColor];
        [_lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.sizeOffset(CGSizeMake(26, 26));
        }];
        
        UILabel *lbnumber = [[UILabel alloc] init];
        [lbnumber setTextColor:RGB(255, 255, 255)];
        [lbnumber setTextAlignment:NSTextAlignmentCenter];
        [lbnumber setFont:[UIFont systemFontOfSize:9]];
        [lbnumber setBackgroundColor:[UIColor redColor]];
        [lbnumber.layer setMasksToBounds:YES];
        [lbnumber.layer setCornerRadius:7.5];
        [self.contentView addSubview:lbnumber];
        [lbnumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_lbValue).offset(5);
            make.top.equalTo(_lbValue).offset(-5);
            make.height.width.offset(15);
        }];
        [lbnumber setText:@"99"];
        [lbnumber setHidden:YES];
        _lbnumber = lbnumber;
        
//        _viewpoint = [[UIView alloc] init];
//        [_viewpoint.layer setMasksToBounds:YES];
//        [_viewpoint.layer setCornerRadius:2];
//        [self.contentView addSubview:_viewpoint];
//        [_viewpoint mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.sizeOffset(CGSizeMake(4, 4));
//            make.centerX.equalTo(self);
//            make.top.equalTo(_lbValue.mas_bottom).offset(5);
//        }];
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [_lbValue setText:_valueday==nil?@"":_valueday];
    
//    if(_type==1)
//    {
//
//        [_viewpoint setBackgroundColor:RGB(86, 141, 230)];
//    }
//    else if (_type == 2)
//    {
//        [_viewpoint setBackgroundColor:RGB(240, 47, 56)];
//    }
//    else
//    {
//        [_viewpoint setBackgroundColor:[UIColor clearColor]];
//    }
    
    if(_isselect)
    {
        
        [_lbValue.layer setBorderWidth:1];
        [_lbValue setTextColor:RGB(50, 50, 50)];
        
        
    }
    else
    {
        [_lbValue setTextColor:RGB(50, 50, 50)];
        
        [_lbValue.layer setBorderWidth:0];
    }
    
    if(_istoday)
    {
        [_lbValue setBackgroundColor:MenuColor];
        [_lbValue setTextColor:RGB(255, 255, 255)];
    }
    else
    {
        [_lbValue setBackgroundColor:[UIColor clearColor]];
        [_lbValue setTextColor:RGB(50, 50, 50)];
    }
    
    if(self.NoDuty.intValue>0)
    {
        [self.lbnumber setHidden:NO];
        [self.lbnumber setText:self.NoDuty];
    }
    else
    {
        [self.lbnumber setHidden:YES];
    }
    
}

@end
