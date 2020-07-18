//
//  ShuiZhiJCDetailDetailViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ShuiZhiJCDetailDetailViewController.h"
#import "ShuiZhiJCDetailDetailTableViewCell.h"
@interface ShuiZhiJCDetailDetailViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tabview;

@end

@implementation ShuiZhiJCDetailDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self drawUI];
    
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
    
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"ShuiZhiJCDetailDetailTableViewCell";
    ShuiZhiJCDetailDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[ShuiZhiJCDetailDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setStrvalue:@""];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
