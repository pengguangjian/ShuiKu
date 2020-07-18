//
//  RightBtnSXView.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "RightBtnSXView.h"

@interface RightBtnSXView ()

@property (nonatomic , strong) UIView *viewback;

@property (nonatomic , strong) UILabel *lbaddress;


@property (nonatomic , strong) UITextField *fieldsearch;


@end

@implementation RightBtnSXView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:RGBAlpha(0, 0, 0, 0.4)];
        
        UIView *viewback = [[UIView alloc] init];
        [viewback setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:viewback];
        [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_right);
            make.top.bottom.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.8);
        }];
        _viewback = viewback;
        
        UILabel *lbtitle = [[UILabel alloc] init];
        [lbtitle setTextColor:[UIColor blackColor]];
        [lbtitle setTextAlignment:NSTextAlignmentLeft];
        [lbtitle setFont:[UIFont systemFontOfSize:16]];
        [lbtitle setText:@"筛选条件"];
        [viewback addSubview:lbtitle];
        [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.top.offset(15);
        }];
        
        UILabel *lbguanli = [[UILabel alloc] init];
        [lbguanli setTextColor:[UIColor blackColor]];
        [lbguanli setTextAlignment:NSTextAlignmentLeft];
        [lbguanli setFont:[UIFont systemFontOfSize:14]];
        [lbguanli setText:@"管理区域"];
        [viewback addSubview:lbguanli];
        [lbguanli mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.top.equalTo(lbtitle.mas_bottom).offset(15);
        }];
        
        UIButton *btaddress = [[UIButton alloc] init];
        [viewback addSubview:btaddress];
        [btaddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.top.equalTo(lbguanli.mas_bottom);
            make.height.offset(50);
            make.right.equalTo(viewback).offset(-15);
        }];
        [btaddress addTarget:self action:@selector(addressAction) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lbaddress = [[UILabel alloc] init];
        [lbaddress setTextColor:[UIColor blackColor]];
        [lbaddress setTextAlignment:NSTextAlignmentLeft];
        [lbaddress setFont:[UIFont systemFontOfSize:14]];
        [lbaddress setText:@"重庆市"];
        [btaddress addSubview:lbaddress];
        [lbaddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.bottom.equalTo(btaddress);
        }];
        _lbaddress = lbaddress;
        
        UIImageView *imgvitem = [[UIImageView alloc] init];
        [imgvitem setImage:[UIImage imageNamed:@"dizhixuanzhitubiao"]];
        [btaddress addSubview:imgvitem];
        [imgvitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.offset(18);
            make.centerY.equalTo(btaddress);
            make.right.equalTo(btaddress).offset(-10);
        }];
        
        UIView *viewline = [[UIView alloc] init];
        [viewline setBackgroundColor:RGB(245, 245, 245)];
        [viewback addSubview:viewline];
        [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(btaddress);
            make.top.equalTo(btaddress.mas_bottom);
            make.height.offset(1);
        }];
        
        UILabel *lbguanjianc = [[UILabel alloc] init];
        [lbguanjianc setTextColor:[UIColor blackColor]];
        [lbguanjianc setTextAlignment:NSTextAlignmentLeft];
        [lbguanjianc setFont:[UIFont systemFontOfSize:14]];
        [lbguanjianc setText:@"关键字搜索"];
        [viewback addSubview:lbguanjianc];
        [lbguanjianc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.top.equalTo(btaddress.mas_bottom).offset(15);
        }];
        
        UITextField *fieldsearch  = [[UITextField alloc] init];
        [fieldsearch setTextColor:[UIColor blackColor]];
        [fieldsearch setTextAlignment:NSTextAlignmentLeft];
        [fieldsearch setFont:[UIFont systemFontOfSize:14]];
        [fieldsearch setPlaceholder:@"请输入关键字"];
        [viewback addSubview:fieldsearch];
        [fieldsearch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(25);
            make.top.equalTo(lbguanjianc.mas_bottom).offset(10);
            make.height.offset(40);
            make.right.equalTo(viewline);
        }];
        
        
        UIView *viewline1 =  [[UIView alloc] init];
        [viewline1 setBackgroundColor:RGB(245, 245, 245)];
        [viewback addSubview:viewline1];
        [viewline1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(btaddress);
            make.top.equalTo(fieldsearch.mas_bottom);
            make.height.offset(1);
        }];
        
        
        
        UIButton *btchongzhi = [[UIButton alloc] init];
        [btchongzhi setTitle:@"重置" forState:UIControlStateNormal];
        [btchongzhi setTitleColor:RGB(30, 30, 30) forState:UIControlStateNormal];
        [btchongzhi.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btchongzhi.layer setMasksToBounds:YES];
        [btchongzhi.layer setCornerRadius:3];
        [btchongzhi.layer setBorderColor:RGB(180, 180, 180).CGColor];
        [btchongzhi.layer setBorderWidth:1];
        [viewback addSubview:btchongzhi];
        [btchongzhi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.height.offset(40);
            make.bottom.offset(-kTabBarHeight+39);
            make.width.equalTo(viewback).multipliedBy(0.4);
        }];
        [btchongzhi setTag:0];
        [btchongzhi addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btok = [[UIButton alloc] init];
        [btok setTitle:@"确定" forState:UIControlStateNormal];
        [btok setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btok.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btok.layer setMasksToBounds:YES];
        [btok.layer setCornerRadius:3];
        [btok setBackgroundColor:MenuColor];
        [viewback addSubview:btok];
        [btok mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(viewback).offset(-15);
            make.top.bottom.width.equalTo(btchongzhi);
        }];
        [btok setTag:1];
        [btok addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [UIView animateWithDuration:0.5 animations:^{
        [self.viewback setRight:self.width];
    }];
    
    
}

///选择地址
-(void)addressAction
{
    [self endEditing:YES];
    
    
}

///0重置 1确定
-(void)bottomAction:(UIButton *)sender
{
    [self endEditing:YES];
    if(self.delegate)
    {
        [self.delegate serachValueText:self.fieldsearch.text andaddress:@""];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.viewback setLeft:self.width];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if(self.delegate)
        {
            [self.delegate dismisView];
        }
        
    }];
}

@end
