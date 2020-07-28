
//
//  LiuLiangYJChuZhiDetailViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LiuLiangYJChuZhiDetailViewController.h"
#import "LiuLiangYJChuZhiDetailTableViewCell.h"
#import "LiuLiangYJChuZhiDetailCZViewController.h"
#import "LiuLiangYJDataController.h"
#import "LiuLiangYJDataController.h"
@interface LiuLiangYJChuZhiDetailViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tabview;
@property (nonatomic , strong) NSMutableArray *arrdata;

@end

@implementation LiuLiangYJChuZhiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看任务流程";
    
    [self drawUI];
    [self getdata];
}

-(void)drawUI
{
    UITableView *tabview = [[UITableView alloc] init];
    [tabview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tabview setBackgroundColor:[UIColor whiteColor]];
    [tabview setDelegate:self];
    [tabview setDataSource:self];
    [self.view addSubview:tabview];
    [tabview mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            
        }else{
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).inset(64);
        }
        
        make.bottom.equalTo(self.view).offset(-kTabBarHeight);
    }];
    tabview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getdata];
    }];
    _tabview = tabview;
    
    NSArray *arrtitle = @[@"关闭预警",@"预警处置"];
    for(int i = 0; i < 2; i++)
    {
        UIButton *btitem = [[UIButton alloc] init];
        [btitem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btitem setTitle:arrtitle[i] forState:UIControlStateNormal];
        [btitem.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btitem setBackgroundColor:RGB(255, 30, 30)];
        if (i==1) {
            [btitem setBackgroundColor:MenuColor];
        }
        [self.view addSubview:btitem];
        [btitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15+(kMainScreenW-30)/2.0*i);
            make.top.equalTo(tabview.mas_bottom).offset(2);
            make.height.offset(45);
            make.width.offset((kMainScreenW-30)/2.0);
        }];
        [btitem setTag:i];
        [btitem addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)bottomAction:(UIButton *)sender
{
    if(sender.tag==0)
    {///关闭预警
        
        UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否要办结此任务吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [LiuLiangYJDataController requestYuJingRengWuChuZhiBanJieData:self.view ID:self.ID Callback:^(NSError *error, BOOL state, NSString *describle, id value) {
                if(state)
                {
                    [WYTools showNotifyHUDwithtext:@"办结成功" inView:self.view.window];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [WYTools showNotifyHUDwithtext:describle inView:self.view];
                }
            }];
        }];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alter addAction:action];
        [alter addAction:action1];
        
        [self presentViewController:alter animated:YES completion:nil];
        
    }
    else
    {//预警处置
        LiuLiangYJChuZhiDetailCZViewController *vc = [[LiuLiangYJChuZhiDetailCZViewController alloc] init];
        vc.ID = self.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"LiuLiangYJChuZhiDetailTableViewCell";
    LiuLiangYJChuZhiDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[LiuLiangYJChuZhiDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setModel:self.arrdata[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 195;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(void)getdata
{
    [LiuLiangYJDataController requestYuJingRengWuChuZhiJiLuData:self.view ID:self.ID Callback:^(NSError *error, BOOL state, NSString *describle, NSMutableArray *value) {
        [self.tabview.mj_header endRefreshing];
        if(state)
        {
            self.arrdata = value;
        }
        else
        {
            [WYTools showNotifyHUDwithtext:describle inView:self.view];
        }
        [self.tabview reloadData];
    }];
    
}

@end
