//
//  LoginView.m
//  ShuiKu
//
//  Created by Mac on 2020/7/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LoginView.h"

#import "TabBarControllerConfig.h"

#import "LoginDataController.h"

@interface LoginView ()

@property (nonatomic , strong) UIButton *btselect;

@property (nonatomic , strong) UIButton *btcode;

@property (nonatomic , strong) UITextField *fieldphone;
///密码和验证码
@property (nonatomic , strong) UITextField *fieldcode;




@end

@implementation LoginView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UIImageView *imgvhd = [[UIImageView alloc] init];
        [imgvhd setImage:[UIImage imageNamed:@"applogtemp"]];
        [self addSubview:imgvhd];
        [imgvhd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.offset(50);
            make.width.height.offset(70);
        }];
        
        UILabel *lbtitle = [[UILabel alloc] init];
        [lbtitle setText:@"丰都智慧供水"];
        [lbtitle setTextColor:[UIColor blackColor]];
        [lbtitle setTextAlignment:NSTextAlignmentCenter];
        [lbtitle setFont:[UIFont systemFontOfSize:18]];
        [self addSubview:lbtitle];
        [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(imgvhd.mas_bottom).offset(15);
        }];
        
        UIButton *btzhlogin = [[UIButton alloc] init];
        [btzhlogin setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
        [btzhlogin setTitleColor:RGB(255, 255, 255) forState:UIControlStateSelected];
        [btzhlogin setTitle:@"账号登录" forState:UIControlStateNormal];
        [btzhlogin.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btzhlogin.layer setMasksToBounds:YES];
        [btzhlogin.layer setCornerRadius:3];
        [btzhlogin.layer setBorderColor:RGB(200, 200, 200).CGColor];
        [btzhlogin.layer setBorderWidth:1];
        [self addSubview:btzhlogin];
        [btzhlogin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(30);
            make.height.offset(35);
            make.width.offset((kMainScreenW-80)/2.0);
            make.top.equalTo(lbtitle.mas_bottom).offset(35);
        }];
        [btzhlogin.layer setBorderWidth:0];
        [btzhlogin setBackgroundColor:MenuColor];
        [btzhlogin setSelected:YES];
        [btzhlogin setTag:0];
        [btzhlogin addTarget:self action:@selector(topAction:) forControlEvents:UIControlEventTouchUpInside];
        _btselect = btzhlogin;
        
        
        UIButton *btyzmlogin = [[UIButton alloc] init];
        [btyzmlogin setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
        [btyzmlogin setTitleColor:RGB(255, 255, 255) forState:UIControlStateSelected];
        [btyzmlogin setTitle:@"手机验证登录" forState:UIControlStateNormal];
        [btyzmlogin.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btyzmlogin.layer setMasksToBounds:YES];
        [btyzmlogin.layer setCornerRadius:3];
        [btyzmlogin.layer setBorderColor:RGB(200, 200, 200).CGColor];
        [btyzmlogin.layer setBorderWidth:1];
        [self addSubview:btyzmlogin];
        [btyzmlogin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(btzhlogin.mas_right).offset(20);
            make.height.offset(35);
            make.width.offset((kMainScreenW-80)/2.0);
            make.top.equalTo(lbtitle.mas_bottom).offset(35);
        }];
        [btyzmlogin setTag:1];
        [btyzmlogin addTarget:self action:@selector(topAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *viewphone = [[UIView alloc] init];
        [self addSubview:viewphone];
        [viewphone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(30);
            make.right.equalTo(self).offset(-30);
            make.top.equalTo(btzhlogin.mas_bottom).offset(20);
            make.height.offset(40);
        }];
        _fieldphone = [self drawitemView:viewphone andplatch:@"手机号码"];
        [_fieldphone setText:@"admin"];
        
        UIView *viewcode = [[UIView alloc] init];
        [self addSubview:viewcode];
        [viewcode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(viewphone.mas_bottom).offset(15);
            make.left.right.height.equalTo(viewphone);
        }];
        _fieldcode =  [self drawitemView:viewcode andplatch:@"密码"];
        [_fieldcode setText:@"8678"];
        [_fieldcode setSecureTextEntry:YES];
        
        UIButton *btcode = [[UIButton alloc] init];
        [btcode setTitleColor:MenuColor forState:UIControlStateNormal];
        [btcode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [btcode.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [viewcode addSubview:btcode];
        [btcode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(viewcode);
            make.right.equalTo(viewcode).offset(-10);
        }];
        _btcode = btcode;
        [_btcode setHidden:YES];
        [btcode addTarget:self action:@selector(codeAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btlogin = [[UIButton alloc] init];
        [btlogin setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        [btlogin setBackgroundColor:MenuColor];
        [btlogin setTitle:@"登录" forState:UIControlStateNormal];
        [btlogin.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btlogin.layer setMasksToBounds:YES];
        [btlogin.layer setCornerRadius:3];
        [self addSubview:btlogin];
        [btlogin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(viewphone);
            make.top.equalTo(viewcode.mas_bottom).offset(20);
            make.height.offset(40);
        }];
        [btlogin addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lbbottom = [[UILabel alloc] init];
        [lbbottom setText:@"重庆博通水利信息网络有限公司"];
        [lbbottom setTextColor:RGB(100, 100, 100)];
        [lbbottom setTextAlignment:NSTextAlignmentCenter];
        [lbbottom setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:lbbottom];
        [lbbottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self.mas_bottom).offset(-40);
        }];
        
        UILabel *lbbottom1 = [[UILabel alloc] init];
        [lbbottom1 setText:@"Copyright@2018-2019,cc-bt.All Rights Reserved"];
        [lbbottom1 setTextColor:RGB(100, 100, 100)];
        [lbbottom1 setTextAlignment:NSTextAlignmentCenter];
        [lbbottom1 setFont:[UIFont systemFontOfSize:13]];
        [self addSubview:lbbottom1];
        [lbbottom1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(lbbottom.mas_bottom).offset(5);
        }];
        
    }
    return self;
}


-(UITextField *)drawitemView:(UIView *)view andplatch:(NSString *)platch
{
    [view setBackgroundColor:RGB(245, 245, 245)];
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:3];
    
    UITextField *field = [[UITextField alloc] init];
    [field setPlaceholder:platch];
    [field setTextColor:[UIColor blackColor]];
    [field setTextAlignment:NSTextAlignmentLeft];
    [field setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.bottom.equalTo(view);
        make.right.equalTo(view).offset(-10);
    }];
    
    return field;
    
}

-(void)topAction:(UIButton *)sender
{
    if(_btselect.tag == sender.tag)return;
    
    [_btselect.layer setBorderWidth:1];
    [_btselect setSelected:NO];
    [_btselect setBackgroundColor:[UIColor clearColor]];
    _btselect = sender;
    [_btselect.layer setBorderWidth:0];
    [_btselect setBackgroundColor:MenuColor];
    [_btselect setSelected:YES];
    
    if(sender.tag==0)
    {
        [_fieldcode setPlaceholder:@"密码"];
        [_btcode setHidden:YES];
        [_fieldcode setSecureTextEntry:YES];
    }
    else
    {
        [_fieldcode setPlaceholder:@"验证码"];
        [_btcode setHidden:NO];
        [_fieldcode setSecureTextEntry:NO];
        
    }
    
    
    
    
}

-(void)codeAction
{
    
    
}

-(void)loginAction
{
    if(self.btselect.tag == 0)
    {
        if(self.fieldphone.text.length<1)
        {
            [WYTools showNotifyHUDwithtext:@"请输入账号" inView:self];
            return;
        }
        if(self.fieldcode.text.length<1)
        {
            [WYTools showNotifyHUDwithtext:@"请输入密码" inView:self];
            return;
        }
        
        [LoginDataController requestLoginData:self.fieldphone.text password:_fieldcode.text showview:self Callback:^(NSError *error, BOOL state, NSString *describle, NSDictionary *value) {
            if(state)
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"userislogin"];
                [[UserInfoModel sharedUserInfo] setuserinfo:value];
                
                TabBarControllerConfig *vc  = [[TabBarControllerConfig alloc] init];
                [self.viewController.view.window setRootViewController:vc.tabBarController];
            }
            else
            {
                [WYTools showNotifyHUDwithtext:describle inView:self];
            }
        }];
    }
    
    
    
    
}


@end
