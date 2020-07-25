//
//  CeZhanJianCeTongJiListViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CeZhanJianCeTongJiListViewController.h"
#import "CeZhanJianCeTongJiListTableViewCell.h"
#import "TongJiFenXiDataController.h"
#import "CeDianFenXiModel.h"
#import "GetAreaModel.h"
@interface CeZhanJianCeTongJiListViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,AlterListViewDelegate,AddressListAlterViewDelegate>

@property (nonatomic , strong) UITableView *tabview;

@property (nonatomic , strong) UIButton *btselecttopitem;

@property (nonatomic , assign) NSInteger type;
@property (nonatomic , assign) NSString *strstcid;

///从时间~最小出水
@property (nonatomic , strong) NSMutableArray *arr0;
@property (nonatomic , strong) NSMutableArray *arr1;
@property (nonatomic , strong) NSMutableArray *arr2;
@property (nonatomic , strong) NSMutableArray *arr3;
@property (nonatomic , strong) NSMutableArray *arr4;
@property (nonatomic , strong) NSMutableArray *arr5;
@property (nonatomic , strong) NSMutableArray *arr6;

@end

@implementation CeZhanJianCeTongJiListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测点统计";
    self.strstcid = @"";
    self.type = 0;
    [self drawUI];
    [self getdata];
    
}
-(void)drawUI
{
    UIView *viewheader = [[UIView alloc] init];
    [viewheader setBackgroundColor:RGB(245, 245, 245)];
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
    
    UITableView *tabview = [[UITableView alloc] init];
    [tabview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tabview setBackgroundColor:[UIColor whiteColor]];
    [tabview setDelegate:self];
    [tabview setDataSource:self];
    [self.view addSubview:tabview];
    [tabview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(viewheader.mas_bottom);
    }];
    _tabview = tabview;
    
}

-(void)drawHeaderView:(UIView *)view
{
    NSArray *arrname = @[@"日统计",@"所有水厂"];
    float fitemw = (self.view.width-45)/2.0;
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


#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr0.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"CeZhanJianCeTongJiListTableViewCell";
    CeZhanJianCeTongJiListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[CeZhanJianCeTongJiListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.arrvalue = @[self.arr0[indexPath.row],
    self.arr1[indexPath.row],
    self.arr2[indexPath.row],
    self.arr3[indexPath.row],
    self.arr4[indexPath.row],
    self.arr5[indexPath.row],
    self.arr6[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 60)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    NSArray *arrname = @[@"水厂",@"流量通畅率%",@"流量在线率%",@"流量异常率%",@"水质畅通率%",@"水质在线率%",@"水质异常率%"];
    
    float fitemw = (kMainScreenW-80)/arrname.count;
    for(int i = 0; i < arrname.count; i++)
    {
        UILabel *lbtitle = [[UILabel alloc] init];
        [lbtitle setTextColor:RGB(30, 30, 30)];
        [lbtitle setTextAlignment:NSTextAlignmentLeft];
        [lbtitle setFont:[UIFont systemFontOfSize:11]];
        [lbtitle setNumberOfLines:3];
        [view addSubview:lbtitle];
        [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(view);
            make.left.offset(10+(10+fitemw)*i);
            make.width.offset(fitemw);
        }];
        [lbtitle setText:arrname[i]];
    }
    
    return view;;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
            
            NSMutableArray *arr0 = [NSMutableArray new];
            NSMutableArray *arr1 = [NSMutableArray new];
            NSMutableArray *arr2 = [NSMutableArray new];
            NSMutableArray *arr3 = [NSMutableArray new];
            NSMutableArray *arr4 = [NSMutableArray new];
            NSMutableArray *arr5 = [NSMutableArray new];
            NSMutableArray *arr6 = [NSMutableArray new];
            
            for(CeDianFenXiModel *model in value)
            {
                [arr0 addObject:model.NAME];
                [arr1 addObject:model.flow_zxl];
                [arr2 addObject:model.flow_ctl];
                [arr3 addObject:model.flow_ycl];
                [arr4 addObject:model.wq_zxl];
                [arr5 addObject:model.wq_ctl];
                [arr6 addObject:model.wq_ycl];
                
            }
            self.arr0 = arr0;
            self.arr1 = arr1;
            self.arr2 = arr2;
            self.arr3 = arr3;
            self.arr4 = arr4;
            self.arr5 = arr5;
            self.arr6 = arr6;
            [self.tabview reloadData];
            
        }
    }];
}

@end
