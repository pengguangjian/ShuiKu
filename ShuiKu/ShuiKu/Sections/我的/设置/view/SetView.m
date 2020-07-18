//
//  SetView.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "SetView.h"

@interface SetView ()

@property (nonatomic , strong) UILabel *lbhuancun ;

@end

@implementation SetView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        
        UIImageView *imgv = [[UIImageView alloc] init];
        [imgv setImage:[UIImage imageNamed:@"ic_icon"]];
        [imgv.layer setMasksToBounds:YES];
        [imgv.layer setCornerRadius:30];
        [self addSubview:imgv];
        [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.offset(60);
            make.centerX.equalTo(self);
            make.top.offset(30);
        }];
        
        UIButton *btqingc = [[UIButton alloc] init];
        [self addSubview:btqingc];
        [btqingc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.equalTo(imgv.mas_bottom).offset(40);
            make.right.equalTo(self).offset(-10);
            make.height.offset(50);
        }];
        [self drawItemBt:btqingc andtitle:@"清除缓存"];
        
        UILabel *lbhuancun = [[UILabel alloc] init];
        [lbhuancun setTextColor:RGB(30,30, 30)];
        [lbhuancun setTextAlignment:NSTextAlignmentRight];
        [lbhuancun setFont:[UIFont systemFontOfSize:14]];
        [lbhuancun setText:@"0.0Mb"];
        [btqingc addSubview:lbhuancun];
        [lbhuancun mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(btqingc);
            make.right.equalTo(btqingc).offset(-20);
        }];
        _lbhuancun = lbhuancun;
        
        
        UIButton *btlianxi = [[UIButton alloc] init];
        [self addSubview:btlianxi];
        [btlianxi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(btqingc);
            make.top.equalTo(btqingc.mas_bottom);
        }];
        [self drawItemBt:btlianxi andtitle:@"联系客服"];
        
        
        UIButton *btlogninout = [[UIButton alloc] init];
        [btlogninout setTitle:@"退出登录" forState:UIControlStateNormal];
        [btlogninout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btlogninout.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btlogninout setBackgroundColor:MenuColor];
        [btlogninout.layer setMasksToBounds:YES];
        [btlogninout.layer setCornerRadius:3];
        [self addSubview:btlogninout];
        [btlogninout mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.top.equalTo(btlianxi.mas_bottom).offset(20);
            make.right.equalTo(self).offset(-20);
            make.height.offset(45);
        }];
        [btlogninout addTarget:self action:@selector(loginoutAction) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}

-(void)drawItemBt:(UIButton *)btqingc andtitle:(NSString *)title
{
    UILabel *lbqingc = [[UILabel alloc] init];
    [lbqingc setTextColor:RGB(30,30, 30)];
    [lbqingc setTextAlignment:NSTextAlignmentLeft];
    [lbqingc setFont:[UIFont systemFontOfSize:14]];
    [lbqingc setText:title];
    [btqingc addSubview:lbqingc];
    [lbqingc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(btqingc);
    }];
    
    UIImageView *imgvnext = [[UIImageView alloc] init];
    [imgvnext setImage:[UIImage imageNamed:@"下一步"]];
    [imgvnext setContentMode:UIViewContentModeScaleAspectFit];
    [btqingc addSubview:imgvnext];
    [imgvnext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(18);
        make.right.equalTo(btqingc);
        make.centerY.equalTo(btqingc);
    }];
    
    UIView *viewline = [[UIView alloc] init];
    [viewline setBackgroundColor:RGB(245, 245, 245)];
    [btqingc addSubview:viewline];
    [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(btqingc);
        make.height.offset(1);
    }];
    
}


-(void)loginoutAction
{
    
    
}

@end
