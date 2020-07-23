
//
//  JianCeAllZheXianTuTuViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "JianCeAllZheXianTuTuViewController.h"
#import "LineZuoBiaoView.h"

#import "AppDelegate.h"
#import "LiuLiangJCDataController.h"

#import "LiuLiangJCXiangQingModel.h"

@interface JianCeAllZheXianTuTuViewController ()<TimeClectAlterViewDelegate>
@property (nonatomic , strong) UIButton *bttime;

@property (nonatomic , strong) LineZuoBiaoView *xianview;

@property (nonatomic , strong) UIView *viewquanping;

@property (nonatomic , strong) UILabel *lbY;

@property (nonatomic , strong) UILabel *lbX;

@property (nonatomic , strong) NSString *strstarttime;
@property (nonatomic , strong) NSString *strendtime;
@property (nonatomic , strong) NSMutableArray *arrdata;
@property (nonatomic , strong) NSMutableArray *arrallline;
@end

@implementation JianCeAllZheXianTuTuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.strstarttime = [WYTools dateChangeStringWith:[NSDate date] andformat:@"yyyy-MM-dd"];
    self.strendtime = [WYTools dateChangeStringWith:[NSDate date] andformat:@"yyyy-MM-dd"];
    
    UIView *viewheader = [[UIView alloc] init];
    [viewheader setBackgroundColor:RGB(245, 245, 245)];
    [viewheader setClipsToBounds:YES];
    [self.view addSubview:viewheader];
    [viewheader mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        }else{
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).inset(64);
        }
        make.height.offset(50);
    }];
    [self drawHeaderView:viewheader];
    
    ///折线图
    UIView *viewtu = [[UIView alloc] init];
    [self.view addSubview:viewtu];
    [viewtu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(viewheader.mas_bottom);
    }];
    [self drawTuView:viewtu];
    
    [self getdata];
    
}

-(void)drawHeaderView:(UIView *)view
{
    NSString *strtime = [WYTools dateChangeStringWith:[NSDate date] andformat:@"yyyy-MM-dd"];
    UIButton *bttime = [[UIButton alloc] init];
    [bttime setTitle:[NSString stringWithFormat:@"%@至%@",strtime,strtime] forState:UIControlStateNormal];
    [bttime setTitleColor:MenuColor forState:UIControlStateNormal];
    [bttime.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [bttime setBackgroundColor:[UIColor whiteColor]];
    [view addSubview:bttime];
    [bttime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.equalTo(view);
        make.height.offset(35);
        make.width.offset(kMainScreenW-100);
    }];
    [bttime addTarget:self action:@selector(timeAction) forControlEvents:UIControlEventTouchUpInside];
    _bttime = bttime;
    
    UIButton *btsearch = [[UIButton alloc] init];
    [btsearch setTitle:@"查询" forState:UIControlStateNormal];
    [btsearch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btsearch.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btsearch setBackgroundColor:MenuColor];
    [view addSubview:btsearch];
    [btsearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bttime);
        make.left.equalTo(bttime.mas_right).offset(10);
        make.right.equalTo(view).offset(-15);
    }];
    [btsearch addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
}
///选择时间
-(void)timeAction
{
    TimeClectAlterView *view = [[TimeClectAlterView alloc] init];
    [view setDeletate:self];
    [self.view.window addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.width.offset(kMainScreenW);
        make.height.offset(kMainScreenH);
    }];
}
///开始时间-结束时间
-(void)changetimeValue:(NSString *)strvalue
{
    @try {
        NSArray *arrtime = [strvalue componentsSeparatedByString:@"-"];
        self.strstarttime = arrtime[0];
        self.strendtime = arrtime[1];
        NSString *strtemp = [NSString stringWithFormat:@"%@至%@",arrtime[0],arrtime[1]];
        strtemp = [strtemp stringByReplacingOccurrencesOfString:@"." withString:@"-"];
        [_bttime setTitle:strtemp forState:UIControlStateNormal];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

///搜索
-(void)searchAction
{
    
    [self getdata];
}

-(void)drawLine
{
    NSMutableArray *arrxArr = [NSMutableArray new];
    NSInteger ifirst = self.arrinfo.count/2;
    NSMutableArray *arrtemp = [NSMutableArray new];
    NSMutableArray *arrtemp1 = [NSMutableArray new];
    NSMutableArray *arrtemp2 = [NSMutableArray new];
    NSMutableArray *arrtemp3 = [NSMutableArray new];
    
    
    
    int i = 0;
    for(LiuLiangJCXiangQingModel *model in self.arrdata)
    {
        if(i==0 || i==self.arrdata.count/2 || i==self.arrdata.count-1)
        {
            [arrxArr addObject:model.TM];
        }
        [arrtemp addObject:model.Q0];
        [arrtemp1 addObject:model.W0];
        [arrtemp2 addObject:model.Q1];
        [arrtemp3 addObject:model.W1];
        i++;
    }
//    [_xianview uploadxArr:arrxArr];
    ///添加线的信息
//    NSMutableArray *arrallline = [NSMutableArray new];
//    NSArray *arrvalue = @[arrtemp,arrtemp1,arrtemp2,arrtemp3];
//    for(int i = 0 ; i < arrvalue.count; i++)
//    {
//        if(i<ifirst)
//        {
//            [arrallline addObject:[self.xianview addLine:arrvalue[i] andlinecolor:RGB(254, 106, 55)]];
//        }
//        else
//        {
//            [arrallline addObject:[self.xianview addLine:arrvalue[i] andlinecolor:RGB(35, 78, 152)]];
//        }
//        
//    }
//    self.arrallline = arrallline;
//    [self.xianview showValue:arrallline];
}

-(void)drawTuView:(UIView *)viewself
{
    LineZuoBiaoView *view = [[LineZuoBiaoView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, kMainScreenH-kTopHeight-120)];
    [view setBackgroundColor:[UIColor whiteColor]];
    [viewself addSubview:view];
    _xianview  = view;
    
    UIView *viewtop = [[UIView alloc] init];
    [viewself addSubview:viewtop];
    [viewtop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewself).offset(30);
        make.height.offset(30);
        make.top.equalTo(viewself);
    }];
    [viewtop setClipsToBounds:YES];
    [self drawtopView:viewtop andarrline:self.arrinfo];
    
    
    UIButton *btquanping = [[UIButton alloc] init];
    [btquanping setImage:[UIImage imageNamed:@"ic_fulll"] forState:UIControlStateNormal];
    [viewself addSubview:btquanping];
    [btquanping mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewself).offset(-10);
        make.top.offset(10);
        make.width.height.offset(30);
    }];
    [btquanping addTarget:self action:@selector(quanPingAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *lbY = [[UILabel alloc] init];
    [lbY setTextColor:RGB(30, 30, 30)];
    [lbY setTextAlignment:NSTextAlignmentLeft];
    [lbY setFont:[UIFont systemFontOfSize:12]];
    [viewself addSubview:lbY];
    [lbY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(10);
    }];
    _lbY = lbY;
    [_lbY setText:_strYValue];
    
    UILabel *lbX = [[UILabel alloc] init];
    [lbX setTextColor:RGB(30, 30, 30)];
    [lbX setTextAlignment:NSTextAlignmentRight];
    [lbX setFont:[UIFont systemFontOfSize:12]];
    [viewself addSubview:lbX];
    [lbX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewself).offset(-10);
        make.bottom.equalTo(viewself).offset(-50);
    }];
    _lbX = lbX;
    [_lbX setText:_strXValue];
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
    [self.view.window addSubview:viewback];
    _viewquanping = viewback;
    
    LineZuoBiaoView *view = [[LineZuoBiaoView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenH, kMainScreenW-60)];
    [view setBackgroundColor:[UIColor whiteColor]];
    [viewback addSubview:view];

    
    UIView *viewtop = [[UIView alloc] init];
    [viewback addSubview:viewtop];
    [viewtop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewback).offset(30);
        make.height.offset(30);
        make.top.equalTo(view.mas_bottom).offset(10);
    }];
    [viewtop setClipsToBounds:YES];
    [self drawtopView:viewtop andarrline:self.arrinfo];
    
    
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
    self.navigationController.navigationBarHidden = YES;
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
    self.navigationController.navigationBarHidden = NO;
    
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


-(void)getdata
{
    
    [LiuLiangJCDataController requestLiuLiangJianCheXiangQingData:self.view sTime:self.strstarttime eTime:self.strendtime stcd:self.stcd Callback:^(NSError *error, BOOL state, NSString *describle, NSMutableArray *value) {
        if(state)
        {
            self.arrdata = value;
        }
//        [self drawLine];
    }];
}

@end
