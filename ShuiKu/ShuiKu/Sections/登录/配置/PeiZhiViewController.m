//
//  PeiZhiViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "PeiZhiViewController.h"

@interface PeiZhiViewController ()

@property (nonatomic , strong) UITextField *fieldurl;

@end

@implementation PeiZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"配置";
    
    [self drawUI];
    
}

-(void)drawUI
{
    UIView *viewback = [[UIView alloc] init];
    [self.view addSubview:viewback];
    [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.edges.equalTo(self.view).insets(kPaddingNav);
        }
    }];
    
    
    UILabel *lbfwq = [[UILabel alloc] init];
    [lbfwq setText:@"服务器地址"];
    [lbfwq setTextColor:RGB(50, 50, 50)];
    [lbfwq setTextAlignment:NSTextAlignmentCenter];
    [lbfwq setFont:[UIFont systemFontOfSize:14]];
    [lbfwq setBackgroundColor:RGB(230, 230, 230)];
    [viewback addSubview:lbfwq];
    [lbfwq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.offset(15);
        make.height.offset(40);
        make.width.offset(90);
    }];
    
    UITextField *fieldurl = [[UITextField alloc] init];
    [fieldurl setPlaceholder:@"服务器地址"];
    [fieldurl setTextColor:RGB(50, 50, 50)];
    [fieldurl setTextAlignment:NSTextAlignmentLeft];
    [fieldurl setFont:[UIFont systemFontOfSize:14]];
    [fieldurl setBackgroundColor:RGB(245, 245, 245)];
    
    [viewback addSubview:fieldurl];
    [fieldurl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbfwq);
        make.left.equalTo(lbfwq.mas_right);
        make.right.equalTo(viewback).offset(-15);
    }];
    _fieldurl = fieldurl;
    
    UIButton *btok = [[UIButton alloc] init];
    [btok setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [btok setBackgroundColor:MenuColor];
    [btok setTitle:@"确认" forState:UIControlStateNormal];
    [btok.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btok.layer setMasksToBounds:YES];
    [btok.layer setCornerRadius:3];
    [viewback addSubview:btok];
    [btok mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.equalTo(viewback).offset(-15);
        make.top.equalTo(lbfwq.mas_bottom).offset(20);
        make.height.offset(40);
    }];
    [btok addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)okAction
{
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
