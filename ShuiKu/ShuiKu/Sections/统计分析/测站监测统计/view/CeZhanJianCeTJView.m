//
//  CeZhanJianCeTJView.m
//  ShuiKu
//
//  Created by Mac on 2020/7/12.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CeZhanJianCeTJView.h"

#import <PGBarChart.h>
#import "AppDelegate.h"

@interface CeZhanJianCeTJView () <PGBarChartDelegate, PGBarChartDataSource>

@property (nonatomic , strong) UIView *viewquanping;

@property (nonatomic , strong) UILabel *lbY;

@property (nonatomic , strong) UILabel *lbX;

@property (nonatomic , strong) PGBarChart *barChart;

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) PGBox *box;

@end


@implementation CeZhanJianCeTJView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self data];
        [self tempData];
        ///必须先有值才可以绘制柱状图
        PGBarChart *barChart = [[PGBarChart alloc]initWithFrame:self.frame];
        barChart.barNormalColor = RGB(58, 137, 217);
        barChart.barWidth = 10;
        barChart.bottomLabelFontSize = 12;
        barChart.bottomLabelFontColor = RGB(150, 150, 150);
        barChart.verticalFontColor = RGB(150, 150, 150);
        barChart.verticalFontSize = 12;
        barChart.bottomLineHeight = 1;
        barChart.bottomLineColor = RGB(225, 225 ,225);
        barChart.leftLineWidth = 1;
        barChart.leftBackgroundColor = RGB(230, 230, 230);
        barChart.horizontalLineHeight = 1;
        barChart.horizontalLineBackgroundColor = RGB(230, 230, 230);
        [barChart setDelegate:self];
        [barChart setDataSource:self];
        [self addSubview:barChart];
        _barChart = barChart;
        [barChart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.bottom.equalTo(self).offset(-20);
        }];
        
        
        UIView *viewtop = [[UIView alloc] init];
        [self addSubview:viewtop];
        [viewtop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).offset(30);
            make.height.offset(30);
            make.top.equalTo(self);
        }];
        [viewtop setClipsToBounds:YES];
        [self drawtopView:viewtop andarrline:@[@"最大进水流量",@"最小进水流量",@"最大出水流量",@"最小出水流量",]];
        
        
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
            make.bottom.equalTo(barChart.mas_bottom).offset(-25);
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


#pragma mark - 全屏
-(void)quanPingAction
{
    UIView *viewback = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenH, kMainScreenW)];
    [viewback setBackgroundColor:[UIColor whiteColor]];
    [self.viewController.view.window addSubview:viewback];
    _viewquanping = viewback;
    
    ///必须先有值才可以绘制柱状图
    PGBarChart *view = [[PGBarChart alloc]initWithFrame:CGRectMake(0, 10, kMainScreenH, kMainScreenW-60)];
    view.barNormalColor = RGB(58, 137, 217);
    view.barWidth = 10;
    view.bottomLabelFontSize = 12;
    view.bottomLabelFontColor = RGB(150, 150, 150);
    view.verticalFontColor = RGB(150, 150, 150);
    view.verticalFontSize = 12;
    view.bottomLineHeight = 1;
    view.bottomLineColor = RGB(225, 225 ,225);
    view.leftLineWidth = 1;
    view.leftBackgroundColor = RGB(230, 230, 230);
    view.horizontalLineHeight = 1;
    view.horizontalLineBackgroundColor = RGB(230, 230, 230);
    [view setDelegate:self];
    [view setDataSource:self];
    [viewback addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(viewback);
//        make.bottom.equalTo(viewback);
//    }];
    
    
    UIView *viewtop = [[UIView alloc] init];
    [viewback addSubview:viewtop];
    [viewtop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewback).offset(30);
        make.height.offset(30);
        make.top.equalTo(view.mas_bottom).offset(10);
    }];
    [viewtop setClipsToBounds:YES];
    [self drawtopView:viewtop andarrline:@[@"最大进水流量",@"最小进水流量",@"最大出水流量",@"最小出水流量",]];
    
    
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
        make.right.equalTo(self).offset(-10);
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

- (NSMutableArray *)data {
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (void)updateTempData {
    [self.data enumerateObjectsUsingBlock:^(PGBarChartDataModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat value = 10 + arc4random() % 30;
        obj.value = value;
    }];
}

- (void)tempData {
    [self.data removeAllObjects];
    NSArray *data = @[@"王\n大\n雷", @"张\n军", @"高\n雄", @"张\n小\n林", @"张\n松",
                      @"李\n伟", @"王\n伟", @"张\n勇", @"张\n宇", @"张\n盛"];
    
    for (int i = 0; i < 10; i++) {
        int value = 10 + arc4random() % 30;
        PGBarChartDataModel *dataModel = [[PGBarChartDataModel alloc] initWithLabel:data[i] value:value index:i unit:@"台次"];
        dataModel.zcolor = RGB(255, arc4random()%255, arc4random()%255);///设置柱状图颜色
        [self.data addObject:dataModel];
    }
}

#pragma mark PGBarChartDataSource

- (NSArray *)charDataModels {
    return self.data;
}

#pragma mark PGBarChartDelegate

- (void) barChart:(PGBarChart *)barChart didSelectBar:(PGBar *)bar {
    NSLog(@"Index: %ld  Value: %f", (long)bar.barChartDataModel.index, bar.barChartDataModel.value);
    CGFloat eFloatBoxX = bar.frame.origin.x - 10;
    CGFloat eFloatBoxY = bar.frame.origin.y + bar.frame.size.height * (1 - bar.grade);
    
    if (_box) {
        [_box removeFromSuperview];
        _box.frame = CGRectMake(eFloatBoxX, eFloatBoxY, _box.frame.size.width, _box.frame.size.height);
        [_box setValue:bar.barChartDataModel.value];
        [barChart addSubview:_box];
    }
    else {
        _box = [[PGBox alloc] initWithPosition:CGPointMake(eFloatBoxX, eFloatBoxY) value:bar.barChartDataModel.value unit:@"台次" title:nil];
        _box.alpha = 0.0;
        [barChart addSubview:_box];
    }
    eFloatBoxY -= (_box.frame.size.height + bar.frame.size.width * 0.25);
    _box.frame = CGRectMake(eFloatBoxX, eFloatBoxY, 50, 30);
    __block CeZhanJianCeTJView *tempself = self;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        tempself.box.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        if (tempself.box) {
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                tempself.box.alpha = 0.0;
                tempself.box.frame = CGRectMake(tempself.box.frame.origin.x, tempself.box.frame.origin.y + tempself.box.frame.size.height, tempself.box.frame.size.width, tempself.box.frame.size.height);
            } completion:^(BOOL finished) {
                [tempself.box removeFromSuperview];
                tempself.box = nil;
            }];
        }
    }];

}



@end
