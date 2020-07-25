//
//  CeZhanJianCeTJViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/12.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CeZhanJianCeTJViewController.h"
#import "CeZhanJianCeTJView.h"
#import "CeZhanJianCeTongJiListViewController.h"
//#import "CeZhanJianCeTJViewtwo.h"

#import "CeDianFenXiModel.h"
#import "TongJiFenXiDataController.h"
#import "GetAreaModel.h"

@interface CeZhanJianCeTJViewController ()<AlterListViewDelegate,AddressListAlterViewDelegate>
@property (nonatomic , strong) UIButton *btselecttopitem;

@property (nonatomic , strong) CeZhanJianCeTJView *zview;
@property (nonatomic , assign) NSInteger type;
@property (nonatomic , assign) NSString *strstcid;

@end

@implementation CeZhanJianCeTJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.strstcid = @"";
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
    
    
    CeZhanJianCeTJView *view = [[CeZhanJianCeTJView alloc] initWithFrame:CGRectMake(0, 70, kMainScreenW, kMainScreenH-kTopHeight-120)];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(viewheader.mas_bottom).offset(10);
    }];
    view.strYValue = @"百分百%";
    view.strXValue = @"水厂";
    view.strtitle = @"日统计 所有水厂";
    view.strtitle1 = @"测点统计";
    _zview = view;
    
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
            CeZhanJianCeTongJiListViewController *vc = [[CeZhanJianCeTongJiListViewController alloc] init];
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
    NSArray *arrtitle = @[@"日统计",@"月统计",@"年统计"];
    for(int i = 0 ; i < arrtitle.count; i++)
    {
        if([value isEqualToString:arrtitle[i]])
        {
            self.type = i;
        }
    }
    
    [_btselecttopitem setTitle:value forState:UIControlStateNormal];
    [self getdata];
}

///水厂地址返回选中的数组
-(void)backAddressListAlterViewArr:(NSMutableArray *)arrvalue
{
    GetAreaModel *model = arrvalue[0];
    [_btselecttopitem setTitle:model.NAME forState:UIControlStateNormal];
    self.strstcid = model.ID;
    [self getdata];
}

-(void)getdata
{
    
    NSString *strdate = [WYTools dateChangeStringWith:[NSDate date] andformat:@"yyyy-MM"];
    if(self.type == 1)
    {
        strdate = [WYTools dateChangeStringWith:[NSDate date] andformat:@"yyyy"];
    }
    
    [TongJiFenXiDataController requestCeDianFenXiData:self.view date:strdate type:(int)self.type stcd:self.strstcid Callback:^(NSError *error, BOOL state, NSString *describle, NSMutableArray *value) {
        if(state)
        {
            NSMutableArray *arrname = [NSMutableArray new];
            
            NSMutableArray *arr0 = [NSMutableArray new];
            
            for(CeDianFenXiModel *model in value)
            {
                for(int i = 0 ; i<6; i++)
                {
                    [arrname addObject:model.NAME];
                }
                
                [arr0 addObject:model.flow_zxl];
                [arr0 addObject:model.flow_ctl];
                [arr0 addObject:model.flow_ycl];
                [arr0 addObject:model.wq_zxl];
                [arr0 addObject:model.wq_ctl];
                [arr0 addObject:model.wq_ycl];
                
            }
            [self.zview setXzhouValue:arrname andKeyValue:arr0];
            
        }
    }];
}

@end
