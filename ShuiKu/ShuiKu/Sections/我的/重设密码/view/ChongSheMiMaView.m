
//
//  ChongSheMiMaView.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ChongSheMiMaView.h"

@interface ChongSheMiMaView ()

@property (nonatomic , strong) UITextField *fieldoldpass;
@property (nonatomic , strong) UITextField *fieldnewpass;
@property (nonatomic , strong) UITextField *fieldokpass;

@end


@implementation ChongSheMiMaView
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        
        [self setBackgroundColor:RGB(245, 245, 245)];
        
        UIView *viewback = [[UIView alloc] init];
        [viewback setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:viewback];
        [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(10);
            make.right.equalTo(self).offset(-10);
        }];
        
        UITextField *fieldoldpass = [[UITextField alloc] init];
        [fieldoldpass setTextColor:RGB(30,30, 30)];
        [fieldoldpass setTextAlignment:NSTextAlignmentLeft];
        [fieldoldpass setFont:[UIFont systemFontOfSize:14]];
        [fieldoldpass setPlaceholder:@"旧密码"];
        [viewback addSubview:fieldoldpass];
        [fieldoldpass mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.offset(0);
            make.right.equalTo(viewback).offset(-10);
            make.height.offset(45);
        }];
        _fieldoldpass = fieldoldpass;
        UIView *viewline = [[UIView alloc] init];
        [viewline setBackgroundColor:RGB(245, 245, 245)];
        [viewback addSubview:viewline];
        [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(viewback);
            make.top.equalTo(fieldoldpass.mas_bottom);
            make.height.offset(1);
        }];
        
        
        UITextField *fieldnewpass = [[UITextField alloc] init];
        [fieldnewpass setTextColor:RGB(30,30, 30)];
        [fieldnewpass setTextAlignment:NSTextAlignmentLeft];
        [fieldnewpass setFont:[UIFont systemFontOfSize:14]];
        [fieldnewpass setPlaceholder:@"新密码"];
        [viewback addSubview:fieldnewpass];
        [fieldnewpass mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(fieldoldpass);
            make.top.equalTo(viewline.mas_bottom);
        }];
        _fieldnewpass = fieldnewpass;
        UIView *viewline1 = [[UIView alloc] init];
        [viewline1 setBackgroundColor:RGB(245, 245, 245)];
        [viewback addSubview:viewline1];
        [viewline1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(viewback);
            make.top.equalTo(fieldnewpass.mas_bottom);
            make.height.offset(1);
        }];
        
        
        UITextField *fieldokpass = [[UITextField alloc] init];
        [fieldokpass setTextColor:RGB(30,30, 30)];
        [fieldokpass setTextAlignment:NSTextAlignmentLeft];
        [fieldokpass setFont:[UIFont systemFontOfSize:14]];
        [fieldokpass setPlaceholder:@"确认密码"];
        [viewback addSubview:fieldokpass];
        [fieldokpass mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(fieldoldpass);
            make.top.equalTo(viewline1.mas_bottom);
        }];
        _fieldokpass = fieldokpass;
        [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(fieldokpass.mas_bottom);
        }];
        
        
        UIButton *btok = [[UIButton alloc] init];
        [btok setTitle:@"确认" forState:UIControlStateNormal];
        [btok setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btok.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btok setBackgroundColor:MenuColor];
        [btok.layer setMasksToBounds:YES];
        [btok.layer setCornerRadius:3];
        [self addSubview:btok];
        [btok mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.top.equalTo(viewback.mas_bottom).offset(25);
            make.right.equalTo(self).offset(-20);
            make.height.offset(45);
        }];
        [btok addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(void)okAction
{
    
    
}

@end
