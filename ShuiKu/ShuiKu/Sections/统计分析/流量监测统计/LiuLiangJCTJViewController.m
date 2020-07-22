//
//  LiuLiangJCTJViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/12.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LiuLiangJCTJViewController.h"
#import "ZheXianTuItemView.h"
#import "LiuLiangTongJiListViewController.h"
#import "TongJiFenXiDataController.h"
#import "LiuLiangFenXiModel.h"
@interface LiuLiangJCTJViewController ()<AlterListViewDelegate,AddressListAlterViewDelegate>

@property (nonatomic , strong) UIButton *btselecttopitem;
@property (nonatomic , strong) ZheXianTuItemView *zview;
@end

@implementation LiuLiangJCTJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self drawUI];
    
    [self getdata];
    
}

-(void)drawUI
{
    UIView *viewheader = [[UIView alloc] init];
    [viewheader setBackgroundColor:RGB(245, 245, 245)];
    [self.view addSubview:viewheader];
    [viewheader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.offset(50);
    }];
    [self drawHeaderView:viewheader];
    
    
    ZheXianTuItemView *view = [[ZheXianTuItemView alloc] initWithFrame:CGRectMake(0, 70, kMainScreenW, kMainScreenH-kTopHeight-120)];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(viewheader.mas_bottom).offset(10);
    }];
    view.strYValue = @"平流量m³/s";
    view.strXValue = @"时间";
    view.strtitle = @"日统计 所有水厂";
    view.strtitle1 = @"瞬时流量统计";
    view.arrXArr = (NSMutableArray *)@[@"1日",@"2日",@"3日",@"4日"];
    self.zview = view;
    
}

-(void)drawHeaderView:(UIView *)view
{
    NSArray *arrname = @[@"日统计",@"所有水厂",@"数据列表"];
    float fitemw = (self.view.width-60)/3.0;
    for(int i = 0 ; i < arrname.count; i++)
    {
        UIButton *btitem = [[UIButton alloc] init];
        [btitem setTitle:arrname[i] forState:UIControlStateNormal];
        [btitem setTitleColor:MenuColor forState:UIControlStateNormal];
        [btitem.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btitem setBackgroundColor:[UIColor whiteColor]];
        [view addSubview:btitem];
        [btitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15+(15+fitemw)*i);
            make.centerY.equalTo(view);
            make.height.offset(35);
            make.width.offset(fitemw);
        }];
        if(i==2)
        {
            [btitem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btitem setBackgroundColor:MenuColor];
        }
        [btitem setTag:i];
        [btitem addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}

-(void)itemAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {///日统计
            _btselecttopitem = sender;
            AlterListView *view = [[AlterListView alloc] init];
            view.strtitle = @"统计选择";
            view.arrdata = @[@"日统计",@"月统计",@"年统计"];
            [view setDelegate:self];
            [self.view.window addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.offset(0);
                make.width.offset(kMainScreenW);
                make.height.offset(kMainScreenH);
            }];
        }
            break;
        case 1:
        {///所有水厂
            _btselecttopitem = sender;
            AddressListAlterView *view = [[AddressListAlterView alloc] init];
            [view setDelegate:self];
            [self.view.window addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.offset(0);
                make.width.offset(kMainScreenW);
                make.height.offset(kMainScreenH);
            }];
        }
            break;
        case 2:
        {
            LiuLiangTongJiListViewController *vc = [[LiuLiangTongJiListViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}
///日统计数据返回
-(void)ListAlterViewItemSelect:(id)value andviewtag:(NSInteger)tag
{
    [_btselecttopitem setTitle:value forState:UIControlStateNormal];
}

///水厂地址返回选中的数组
-(void)backAddressListAlterViewArr:(NSMutableArray *)arrvalue
{
    [_btselecttopitem setTitle:arrvalue.lastObject forState:UIControlStateNormal];
}

-(void)getdata
{
    [TongJiFenXiDataController requestLiuLiangFenXiData:self.view date:@"2020-07" type:0 Callback:^(NSError *error, BOOL state, NSString *describle, NSMutableArray *value) {
        if(state)
        {
            NSMutableArray *arrlinedata = [NSMutableArray new];
            NSMutableArray *arrtemp0 = [NSMutableArray new];
            NSMutableArray *arrtemp1 = [NSMutableArray new];
            
            NSMutableArray *arrxArr = [NSMutableArray new];
            int i = 0;
            for(LiuLiangFenXiModel *model in value)
            {
                if(i==0 || i==value.count/2 || i==value.count-1)
                {
                    [arrxArr addObject:model.s_time];
                }
                else
                {
                    [arrxArr addObject:@""];
                }
                [arrtemp0 addObject:[NSString nullToString:model.max_Q]];
                [arrtemp1 addObject:[NSString nullToString:model.min_Q]];
                i++;
            }
            [arrlinedata addObject:arrtemp0];
            [arrlinedata addObject:arrtemp1];
            
            NSMutableArray *arrlinecolor = [[NSMutableArray alloc] initWithObjects:[UIColor redColor],[UIColor blueColor], nil];
            self.zview.arrXArr = arrxArr;
            self.zview.arrLineData = arrlinedata;
            self.zview.arrLineColor = arrlinecolor;
            [self.zview addLine];
        }
    }];
}

@end
