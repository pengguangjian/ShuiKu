//
//  WenDuTJSonViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/14.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "WenDuTJSonViewController.h"
#import "WenDuTJSonView.h"
#import "WenDuTJListViewController.h"
#import "WenDuFenXiModel.h"
#import "TongJiFenXiDataController.h"
#import "GetAreaModel.h"

@interface WenDuTJSonViewController ()<AlterListViewDelegate,AddressListAlterViewDelegate>
@property (nonatomic , strong) UIButton *btselecttopitem;

@property (nonatomic , strong) WenDuTJSonView *zview;
@property (nonatomic , assign) NSInteger type;
@property (nonatomic , assign) NSString *strstcid;

@end

@implementation WenDuTJSonViewController

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
    
    
    WenDuTJSonView *view = [[WenDuTJSonView alloc] initWithFrame:CGRectMake(0, 70, kMainScreenW, kMainScreenH-kTopHeight-120)];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(viewheader.mas_bottom).offset(10);
    }];
    view.strYValue = @"温度°C";
    view.strXValue = @"时间";
    view.strtitle = @"日统计 所有水厂";
    view.strtitle1 = @"温度统计";
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
            WenDuTJListViewController *vc = [[WenDuTJListViewController alloc] init];
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
    
    [TongJiFenXiDataController requestWenDuFenXiData:self.view date:strdate type:(int)self.type stcd:self.strstcid Callback:^(NSError *error, BOOL state, NSString *describle, NSMutableArray *value) {
        if(state)
        {
            NSMutableArray *arrtime = [NSMutableArray new];
            ///进水
            NSMutableArray *arrzuidajs = [NSMutableArray new];
            NSMutableArray *arrzuixiaojs = [NSMutableArray new];
            ///出水
            NSMutableArray *arrzuidacs = [NSMutableArray new];
            NSMutableArray *arrzuixiaocs = [NSMutableArray new];
            
            for(WenDuFenXiModel *model in value)
            {
                if([model.s_type isEqualToString:@"04"])
                {///进水
                    [arrtime addObject:model.s_time];
                    [arrzuidajs addObject:model.max_WT];
                    [arrzuixiaojs addObject:model.min_WT];
                    
                }
                else if([model.s_type isEqualToString:@"14"])
                {///出水
                    
                    [arrzuidacs addObject:model.max_WT];
                    [arrzuixiaocs addObject:model.min_WT];
                }
                
            }
            
            NSMutableArray *arrlinedata = [NSMutableArray new];
            [arrlinedata addObject:@{@"value":[[arrzuidajs reverseObjectEnumerator] allObjects],@"color":MenuColor1}];
            [arrlinedata addObject:@{@"value":[[arrzuixiaojs reverseObjectEnumerator] allObjects],@"color":MenuColor1}];
            [arrlinedata addObject:@{@"value":[[arrzuidacs reverseObjectEnumerator] allObjects],@"color":MenuColor}];
            [arrlinedata addObject:@{@"value":[[arrzuixiaocs reverseObjectEnumerator] allObjects],@"color":MenuColor}];
            
            NSMutableArray *arrtemptime = (NSMutableArray *)[[arrtime reverseObjectEnumerator] allObjects];
            arrtime = arrtemptime;
            self.zview.arrtime = arrtime;
            self.zview.arrlinedata = arrlinedata;
            [self.zview.xianview setXzhouValue:arrtime andKeyValue:arrlinedata];
        }
    }];
}


@end
