
//
//  MapShaiXuanView.m
//  ShuiKu
//
//  Created by Mac on 2020/7/12.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MapShaiXuanView.h"

@interface MapShaiXuanView ()

@property (nonatomic , strong) UIView *viewback;

@property (nonatomic , strong) UIButton *btselect;

@end

@implementation MapShaiXuanView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:RGBAlpha(0, 0, 0, 0.4)];
        [self setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapview)];
        [self addGestureRecognizer:tapview];
        
        
        UIView *viewback = [[UIView alloc] init];
        [viewback setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:viewback];
        [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.5);
        }];
        _viewback = viewback;
        
        UILabel *lbtitle = [[UILabel alloc] init];
        [lbtitle setText:@"监测类型"];
        [lbtitle setTextColor:RGB(153, 153, 153)];
        [lbtitle setTextAlignment:NSTextAlignmentLeft];
        [lbtitle setFont:[UIFont systemFontOfSize:13]];
        [viewback addSubview:lbtitle];
        [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.top.offset(50);
        }];
        
        NSArray *arrtitle =@[@"流量",@"浊度",@"温度",@"PH值",@"水质",@"综合"];
        UIButton *btlast = nil;
        for(int i = 0 ; i < arrtitle.count; i++)
        {
            UIButton *btitem = [[UIButton alloc] init];
            [viewback addSubview:btitem];
            [btitem setTag:i];
            [btitem addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
            [btitem mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(viewback);
                make.top.equalTo(lbtitle.mas_bottom).offset(15+35*i);
                make.height.offset(35);
            }];
            
            UIImageView *imgvitem = [[UIImageView alloc] init];
            [imgvitem setImage:[UIImage imageNamed:@"选择框"]];
            [btitem addSubview:imgvitem];
            [imgvitem mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(20);
                make.width.height.offset(14);
                make.centerY.equalTo(btitem);
            }];
            [imgvitem setTag:1000];
            
            
            UILabel *lbitem = [[UILabel alloc] init];
            [lbitem setText:arrtitle[i]];
            [lbitem setTextColor:RGB(20, 20, 20)];
            [lbitem setTextAlignment:NSTextAlignmentLeft];
            [lbitem setFont:[UIFont systemFontOfSize:14]];
            [viewback addSubview:lbitem];
            [lbitem mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imgvitem.mas_right).offset(5);
                make.top.bottom.equalTo(btitem);
            }];
            btlast = btitem;
        }
        
        UIButton *btik = [[UIButton alloc] init];
        [btik setTitle:@"确定" forState:UIControlStateNormal];
        [btik setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btik.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btik.layer setMasksToBounds:YES];
        [btik.layer setCornerRadius:3];
        [btik setBackgroundColor:MenuColor];
       [viewback addSubview:btik];
       [btik mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.offset(20);
           make.right.equalTo(viewback).offset(-20);
           make.top.equalTo(btlast.mas_bottom).offset(30);
           make.height.offset(35);
       }];
        
        [btik addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)tapview
{
    [UIView animateWithDuration:0.5 animations:^{
        [self->_viewback setLeft:kMainScreenW];
    } completion:^(BOOL finished) {
        [self setHidden:YES];
    }];
}

-(void)showView
{
    [UIView animateWithDuration:0.5 animations:^{
        [self->_viewback setRight:kMainScreenW];
    } completion:^(BOOL finished) {
        
    }];
}
-(void)okAction
{
    [UIView animateWithDuration:0.5 animations:^{
        [self->_viewback setLeft:kMainScreenW];
    } completion:^(BOOL finished) {
        [self setHidden:YES];
    }];
}

-(void)itemAction:(UIButton *)sender
{
    if(_btselect)
    {
        UIImageView *imgv = [_btselect viewWithTag:1000];
        [imgv setImage:[UIImage imageNamed:@"选择框"]];
    }
    
    _btselect = sender;
    UIImageView *imgv = [_btselect viewWithTag:1000];
    [imgv setImage:[UIImage imageNamed:@"选择"]];
    
    
}

@end
