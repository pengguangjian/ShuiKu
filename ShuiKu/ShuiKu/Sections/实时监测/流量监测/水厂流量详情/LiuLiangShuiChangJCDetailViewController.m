//
//  LiuLiangShuiChangJCDetailViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LiuLiangShuiChangJCDetailViewController.h"
#import "LiuLiangShuiChangJCDetailTableViewCell.h"
#import "LiuLiangJCDataController.h"
@interface LiuLiangShuiChangJCDetailViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,TimeClectAlterViewDelegate>

@property (nonatomic , strong) UITableView *tabview;
@property (nonatomic , strong) UIButton *bttime;
@property (nonatomic , strong) NSString *strstarttime;
@property (nonatomic , strong) NSString *strendtime;
@property (nonatomic , strong) NSMutableArray *arrdata;

@end

@implementation LiuLiangShuiChangJCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.strstarttime = [WYTools dateChangeStringWith:[NSDate date] andformat:@"yyyy-MM-dd"];
    self.strendtime = [WYTools dateChangeStringWith:[NSDate date] andformat:@"yyyy-MM-dd"];
    
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
    [tabview setBackgroundColor:RGB(245, 245, 245)];
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
        NSArray *arrtime = [strvalue componentsSeparatedByString:@"&"];
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

-(void)getdata
{
    
    [LiuLiangJCDataController requestLiuLiangJianCheXiangQingData:self.view sTime:self.strstarttime eTime:self.strendtime stcd:self.stcd Callback:^(NSError *error, BOOL state, NSString *describle, NSMutableArray *value) {
        if(state)
        {
            self.arrdata = value;
        }
        [self.tabview reloadData];
    }];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"LiuLiangShuiChangJCDetailTableViewCell";
    LiuLiangShuiChangJCDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[LiuLiangShuiChangJCDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.model = self.arrdata[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
