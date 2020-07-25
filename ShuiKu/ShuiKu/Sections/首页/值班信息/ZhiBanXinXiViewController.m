
//
//  ZhiBanXinXiViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ZhiBanXinXiViewController.h"

#import "HomeZhiBanTongJiView.h"
#import "ZhiBanInfoModel.h"
#import "MainHomeDataController.h"
#import "ZhiBanXiangQingModel.h"

@interface ZhiBanXinXiViewController ()<HomeZhiBanTongJiViewDelegate>

@property (nonatomic , strong)  UIView *viewinfo;
@property (nonatomic , assign) BOOL isshouinfo;
@end

@implementation ZhiBanXinXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"未值班信息";
    
    
    [self drawUI];
}

-(void)drawUI
{
    [self.view setBackgroundColor:RGB(245, 245, 245)];
    UIView *viewback = [[UIView alloc] init];
    [viewback setBackgroundColor:[UIColor whiteColor]];
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
    UIScrollView *scvback = [[UIScrollView alloc] init];
    [viewback addSubview:scvback];
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(viewback);
    }];
    ///值班统计
    HomeZhiBanTongJiView *tongjiview = [[HomeZhiBanTongJiView alloc] init];
    [scvback addSubview:tongjiview];
    [tongjiview setDelegate:self];
    [tongjiview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewback);
        make.top.offset(5);
    }];
    
    UIView *viewinfo = [[UIView alloc] init];
    [scvback addSubview:viewinfo];
    [viewinfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewback);
        make.top.equalTo(tongjiview.mas_bottom).offset(10);
    }];
    [viewinfo setHidden:YES];
    _viewinfo = viewinfo;
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewinfo.mas_bottom).offset(30);
    }];
    
}

///返回值班信息model
-(void)selectZhiBanInfoModel:(id)model
{
    if(model==nil)
    {
        [_viewinfo removeAllSubviews];
        return;
    }
    ZhiBanInfoModel *modelz = model;
    
    NSArray *arrtime = [modelz.DUTYTIME componentsSeparatedByString:@" "];
    [MainHomeDataController requestZhiBanXiangqingData:self.view DUTYTIME:arrtime[0] Callback:^(NSError *error, BOOL state, NSString *describle, NSMutableArray *value) {
        if(state)
        {
            [self.viewinfo setHidden:NO];
            [self drawInfoxiangqing:modelz andlist:value];
        }
        else
        {
            [WYTools showNotifyHUDwithtext:describle inView:self.view];
        }
    }];
}

-(void)drawInfoxiangqing:(ZhiBanInfoModel *)zmodel andlist:(NSMutableArray *)arrmodel
{
    [self.viewinfo removeAllSubviews];
    
    NSArray *arrtime = [zmodel.DUTYTIME componentsSeparatedByString:@" "];
    UILabel *lbtongjiriqi = [[UILabel alloc] init];
    [lbtongjiriqi setText:[NSString stringWithFormat:@"统计日期：%@",arrtime[0]]];
    [lbtongjiriqi setTextColor:RGB(30, 30, 30)];
    [lbtongjiriqi setTextAlignment:NSTextAlignmentLeft];
    [lbtongjiriqi setFont:[UIFont systemFontOfSize:14]];
    [self.viewinfo addSubview:lbtongjiriqi];
    [lbtongjiriqi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(0);
    }];
    
    UILabel *lbzhiban = [[UILabel alloc] init];
    [lbzhiban setText:[NSString stringWithFormat:@"值    班：%@座",zmodel.OnDuty]];
    [lbzhiban setTextColor:RGB(30, 30, 30)];
    [lbzhiban setTextAlignment:NSTextAlignmentLeft];
    [lbzhiban setFont:[UIFont systemFontOfSize:14]];
    [self.viewinfo addSubview:lbzhiban];
    [lbzhiban mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(lbtongjiriqi.mas_bottom).offset(8);
    }];
    
    UILabel *lbwzhiban = [[UILabel alloc] init];
    [lbwzhiban setText:[NSString stringWithFormat:@"未 值 班：%@座",zmodel.NoDuty]];
    [lbwzhiban setTextColor:RGB(255, 30, 30)];
    [lbwzhiban setTextAlignment:NSTextAlignmentLeft];
    [lbwzhiban setFont:[UIFont systemFontOfSize:14]];
    [self.viewinfo addSubview:lbwzhiban];
    [lbwzhiban mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(lbzhiban.mas_bottom).offset(8);
    }];
    
    UIView *viewlast = nil;
    ///
    for(int i = 0 ; i < arrmodel.count; i++)
    {
        ZhiBanXiangQingModel *model = arrmodel[i];
        UIView *viewitem = [[UIView alloc] init];
        [viewitem setBackgroundColor:[UIColor whiteColor]];
        [viewitem.layer setMasksToBounds:NO];
        [viewitem.layer setCornerRadius:5];
        [self.viewinfo addSubview:viewitem];
        [viewitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.equalTo(self.viewinfo).offset(-10);
            make.top.equalTo(lbwzhiban.mas_bottom).offset(20+160*i);
            make.height.offset(150);
        }];
        // 阴影颜色
        viewitem.layer.shadowColor = RGBAlpha(0, 0, 0, 0.7).CGColor;
        // 阴影偏移，默认(0, -3)
        viewitem.layer.shadowOffset = CGSizeMake(0,2);
        // 阴影透明度，默认0
        viewitem.layer.shadowOpacity = 0.5;
        // 阴影半径，默认3
        viewitem.layer.shadowRadius = 3;
        
        UILabel *lbname = [[UILabel alloc] init];
        [lbname setText:[NSString stringWithFormat:@"%@",model.SCNAME]];
        [lbname setTextColor:RGB(30, 30, 30)];
        [lbname setTextAlignment:NSTextAlignmentLeft];
        [lbname setFont:[UIFont systemFontOfSize:12]];
        [viewitem addSubview:lbname];
        [lbname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.offset(10);
        }];
        
        UILabel *lbtime = [[UILabel alloc] init];
        [lbtime setText:[NSString stringWithFormat:@"%@",model.DUTYTIME]];
        [lbtime setTextColor:RGB(153, 153, 153)];
        [lbtime setTextAlignment:NSTextAlignmentLeft];
        [lbtime setFont:[UIFont systemFontOfSize:12]];
        [viewitem addSubview:lbtime];
        [lbtime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.equalTo(lbname.mas_bottom).offset(5);
        }];
        
        NSArray *arrzhuang = @[@"填写人",@"填写时间",@"值班记录",@"备注"];
        NSArray *arrvalue = @[[NSString nullToString:model.CREATEDUSERNAME],[NSString nullToString:model.CREATEDTIME],[NSString nullToString:model.DUTYRECORD],[NSString nullToString:model.REMARK]];
        for(int j = 0; j < arrzhuang.count; j++)
        {
            UIView *viewitem1 = [[UIView alloc] init];
            [viewitem addSubview:viewitem1];
            [viewitem1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(viewitem);
                make.top.equalTo(lbtime.mas_bottom).offset(5+25*j);
                make.height.offset(20);
            }];
            UILabel *lbvalue = [WYTools drawitemView:viewitem1 andtitle:arrzhuang[j]];
            [lbvalue setText:arrvalue[j]];
        }
        
        
        viewlast = viewitem;
    }
    if(self.isshouinfo==NO)
    {
        self.isshouinfo = YES;
        [self.viewinfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(viewlast.mas_bottom);
        }];
    }
    else
    {
        [self.viewinfo mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(viewlast.mas_bottom);
        }];
    }
    
}

@end
