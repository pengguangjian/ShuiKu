//
//  ShuiChangDetailViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ShuiChangDetailViewController.h"
#import "ShuiChangDetailTableViewCell.h"
@interface ShuiChangDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tabview;


@property (nonatomic , strong) NSMutableArray *arrTitles;

@end

@implementation ShuiChangDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _strtitle;
    [self gettitleData];
    
    [self drawUI];
    
}
-(void)gettitleData
{
    NSMutableArray *arrtitle = [NSMutableArray new];
    NSArray *arritem0 = @[@"水厂名称",@"水厂编码"];
    NSDictionary *dicitem0 = @{@"基本信息":arritem0};
    [arrtitle addObject:dicitem0];
    
    
    NSArray *arritem1 = @[@"经度",@"纬度",@"行政区划代码",@"行政区划名称"];
    NSDictionary *dicitem1 = @{@"位置信息":arritem1};
    [arrtitle addObject:dicitem1];
    
    NSArray *arritem2 = @[@"负责人",@"联系人",@"联系电话",@"邮政编码"];
    NSDictionary *dicitem2 = @{@"位置信息":arritem2};
    [arrtitle addObject:dicitem2];
    
    self.arrTitles = arrtitle;
}

-(void)drawUI
{
    UITableView *tabview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.edges.equalTo(self.view).insets(kPaddingNav);
        }
    }];
    _tabview = tabview;
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrTitles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dicitem = self.arrTitles[section];
    NSArray *arrtemp = [dicitem allValues];
    NSArray *arritem = arrtemp[0];
    return arritem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"ShuiChangDetailTableViewCell";
    ShuiChangDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[ShuiChangDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSDictionary *dicitem = self.arrTitles[indexPath.section];
    NSArray *arrtemp = [dicitem allValues];
    NSArray *arritem = arrtemp[0];
    [cell.lbname setText:arritem[indexPath.row]];
    [cell.lbvalue setText:arritem[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 45)];
    [view setBackgroundColor:RGB(133, 174, 226)];
    
    UILabel *lbtitle = [[UILabel alloc] init];
    [lbtitle setTextColor:RGB(255, 255, 255)];
    [lbtitle setTextAlignment:NSTextAlignmentLeft];
    [lbtitle setFont:[UIFont systemFontOfSize:16]];
    [view addSubview:lbtitle];
    [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.bottom.equalTo(view);
    }];
    NSDictionary *dicitem = self.arrTitles[section];
    NSArray *arrtemp = [dicitem allKeys];
    [lbtitle setText:arrtemp[0]];
    
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
