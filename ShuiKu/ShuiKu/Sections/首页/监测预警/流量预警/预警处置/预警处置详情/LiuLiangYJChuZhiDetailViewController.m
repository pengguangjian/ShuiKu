
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

@interface LiuLiangYJChuZhiDetailViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tabview;

@end

@implementation LiuLiangYJChuZhiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看任务流程";
    
    [self drawUI];
    
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
        
    }
    else
    {//预警处置
        LiuLiangYJChuZhiDetailCZViewController *vc = [[LiuLiangYJChuZhiDetailCZViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
    [cell setStrvalue:@""];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 195;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiuLiangYJChuZhiDetailCZViewController *vc = [[LiuLiangYJChuZhiDetailCZViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
