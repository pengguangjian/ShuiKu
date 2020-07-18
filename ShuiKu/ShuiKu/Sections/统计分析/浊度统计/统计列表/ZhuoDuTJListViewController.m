

//
//  ZhuoDuTJListViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ZhuoDuTJListViewController.h"
#import "ZhuoDuTJListTableViewCell.h"


@interface ZhuoDuTJListViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tabview;

@end

@implementation ZhuoDuTJListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"浊度统计";
    
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
    
    
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"ZhuoDuTJListTableViewCell";
    ZhuoDuTJListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[ZhuoDuTJListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setStrvalue:@""];
    
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
    
    NSArray *arrname = @[@"时间",@"最大进水NTU",@"最小进水NTU",@"最大出水NTU",@"最小出水NTU"];
    
    float fitemw = (kMainScreenW-60)/arrname.count;
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


@end
