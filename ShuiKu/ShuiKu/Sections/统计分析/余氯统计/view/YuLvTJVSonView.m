//
//  YuLvTJVSonView.m
//  ShuiKu
//
//  Created by Mac on 2020/7/14.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "YuLvTJVSonView.h"
#import "AppDelegate.h"

@interface YuLvTJVSonView ()

@property (nonatomic , strong) UIView *viewquanping;

@property (nonatomic , strong) UILabel *lbY;

@property (nonatomic , strong) UILabel *lbX;

@end
@implementation YuLvTJVSonView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        LineZuoBiaoView *view = [[LineZuoBiaoView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [view setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:view];
        _xianview  = view;
        
        
        UIView *viewtop = [[UIView alloc] init];
        [self addSubview:viewtop];
        [viewtop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).offset(30);
            make.height.offset(30);
            make.top.equalTo(self);
        }];
        [viewtop setClipsToBounds:YES];
        [self drawtopView:viewtop andarrline:@[@"最大进水余氯",@"最小进水余氯",@"最大出水余氯",@"最小出水余氯"]];
        
        
        UIButton *btquanping = [[UIButton alloc] init];
        [btquanping setImage:[UIImage imageNamed:@"ic_fulll"] forState:UIControlStateNormal];
        [self addSubview:btquanping];
        [btquanping mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.top.offset(10);
            make.width.height.offset(30);
        }];
        [btquanping addTarget:self action:@selector(quanPingAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *lbY = [[UILabel alloc] init];
        [lbY setTextColor:RGB(30, 30, 30)];
        [lbY setTextAlignment:NSTextAlignmentLeft];
        [lbY setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:lbY];
        [lbY mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.offset(10);
        }];
        _lbY = lbY;
        
        
        UILabel *lbX = [[UILabel alloc] init];
        [lbX setTextColor:RGB(30, 30, 30)];
        [lbX setTextAlignment:NSTextAlignmentRight];
        [lbX setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:lbX];
        [lbX mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.bottom.equalTo(self).offset(-10);
        }];
        _lbX = lbX;
        
    }
    return self;
}

-(void)setStrYValue:(NSString *)strYValue
{
    _strYValue = strYValue;
    
    [_lbY setText:strYValue];
    
}

-(void)setStrXValue:(NSString *)strXValue
{
    _strXValue = strXValue;
    [_lbX setText:strXValue];
}


-(NSMutableArray *)backSuiJiShu
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        [array addObject:[NSNumber numberWithInteger:arc4random() % 100]];
    }
    return array;
}

-(void)drawtopView:(UIView *)view andarrline:(NSArray *)arrtitle
{
    UIView *viewlsat = nil;
    for(int i = 0 ; i < arrtitle.count; i++)
    {
        UIView *viewline = [[UIView alloc] init];
        [viewline setBackgroundColor:RGB(254, 106, 55)];
        [view addSubview:viewline];
        [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
            if(viewlsat == nil)
            {
                make.left.offset(0);
            }
            else
            {
                make.left.equalTo(viewlsat.mas_right).offset(10);
            }
            make.size.sizeOffset(CGSizeMake(15, 3));
            make.centerY.equalTo(view);
        }];
        
        UILabel *lbtext = [[UILabel alloc] init];
        [lbtext setText:arrtitle[i]];
        [lbtext setTextColor:RGB(30, 30, 30)];
        [lbtext setTextAlignment:NSTextAlignmentLeft];
        [lbtext setFont:[UIFont systemFontOfSize:12]];
        [view addSubview:lbtext];
        [lbtext mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(viewline.mas_right).offset(5);
            make.centerY.equalTo(view);
            
        }];
        viewlsat = lbtext;
        if(i>=arrtitle.count/2)
        {
            [viewline setBackgroundColor:RGB(35, 78, 152)];
        }
    }
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewlsat.mas_right);
    }];
    
    
    
}

-(void)quanPingAction
{
    
    UIView *viewback = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenH, kMainScreenW)];
    [viewback setBackgroundColor:[UIColor whiteColor]];
    [self.viewController.view.window addSubview:viewback];
    _viewquanping = viewback;
    
    LineZuoBiaoView *view = [[LineZuoBiaoView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenH, kMainScreenW-60)];
    [view setBackgroundColor:[UIColor whiteColor]];
    [viewback addSubview:view];
    [view setXzhouValue:self.arrtime andKeyValue:self.arrlinedata];
    
    
    UIView *viewtop = [[UIView alloc] init];
    [viewback addSubview:viewtop];
    [viewtop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewback).offset(30);
        make.height.offset(30);
        make.top.equalTo(view.mas_bottom).offset(10);
    }];
    [viewtop setClipsToBounds:YES];
    [self drawtopView:viewtop andarrline:@[@"最大进水余氯",@"最小进水余氯",@"最大出水余氯",@"最小出水余氯"]];
    
    
    UIButton *btquanping = [[UIButton alloc] init];
    [btquanping setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
    [viewback addSubview:btquanping];
    [btquanping mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewback).offset(10);
        make.top.equalTo(view.mas_bottom).offset(10);
        make.width.height.offset(30);
    }];
    [btquanping addTarget:self action:@selector(quanPingCancleAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *lbY = [[UILabel alloc] init];
    [lbY setTextColor:RGB(30, 30, 30)];
    [lbY setTextAlignment:NSTextAlignmentLeft];
    [lbY setFont:[UIFont systemFontOfSize:12]];
    [viewback addSubview:lbY];
    [lbY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(10);
    }];
    [lbY setText:_strYValue];
    
    
    UILabel *lbX = [[UILabel alloc] init];
    [lbX setTextColor:RGB(30, 30, 30)];
    [lbX setTextAlignment:NSTextAlignmentRight];
    [lbX setFont:[UIFont systemFontOfSize:12]];
    [viewback addSubview:lbX];
    [lbX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewback).offset(-10);
        make.bottom.equalTo(view.mas_bottom).offset(-10);
    }];
    [lbX setText:_strXValue];
    
    UILabel *lbtitle = [[UILabel alloc] init];
    [lbtitle setTextColor:RGB(153, 153, 153)];
    [lbtitle setTextAlignment:NSTextAlignmentRight];
    [lbtitle setFont:[UIFont systemFontOfSize:12]];
    [viewback addSubview:lbtitle];
    [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewback).offset(-10);
        make.top.equalTo(viewback).offset(10);
    }];
    [lbtitle setText:_strtitle];
    
    UILabel *lbtitle1 = [[UILabel alloc] init];
    [lbtitle1 setTextColor:RGB(30, 30, 30)];
    [lbtitle1 setTextAlignment:NSTextAlignmentLeft];
    [lbtitle1 setFont:[UIFont systemFontOfSize:12]];
    [viewback addSubview:lbtitle1];
    [lbtitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewback).offset(10);
        make.top.equalTo(view.mas_bottom);
    }];
    [lbtitle1 setText:_strtitle1];
    
    
    
    
    
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.allowRotate = 1;
    self.viewController.navigationController.navigationBarHidden = YES;
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {

            SEL selector = NSSelectorFromString(@"setOrientation:");

            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];

            [invocation setSelector:selector];

            [invocation setTarget:[UIDevice currentDevice]];

            int val = UIInterfaceOrientationLandscapeRight;

            [invocation setArgument:&val atIndex:2];

            [invocation invoke];
    }
    
}


-(void)quanPingCancleAction:(UIButton *)sender
{
    [_viewquanping removeFromSuperview];
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.allowRotate = 0;
    self.viewController.navigationController.navigationBarHidden = NO;
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {

            SEL selector = NSSelectorFromString(@"setOrientation:");

            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];

            [invocation setSelector:selector];

            [invocation setTarget:[UIDevice currentDevice]];

            int val = UIInterfaceOrientationPortrait;

            [invocation setArgument:&val atIndex:2];

            [invocation invoke];
    }
    
}

@end
