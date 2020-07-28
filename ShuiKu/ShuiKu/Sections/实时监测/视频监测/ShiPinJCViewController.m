//
//  ShiPinJCViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ShiPinJCViewController.h"
#import "ShiPinJCTableViewCell.h"
#import "ShiPinShuiChangJCViewController.h"

#import "ShiPinJCDataController.h"
#import "ShiPinJcShuiChangListModel.h"

@interface ShiPinJCViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tabview;

@property (nonatomic , strong) NSMutableArray *arrdata;

@property (nonatomic , assign) int ipage;

@property (nonatomic , strong) UITextField *fieldSearch;

@property (nonatomic , strong) UILabel *lbbcnum;

@end

@implementation ShiPinJCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频监测";
    
    [self drawUI];
    self.ipage = 1;
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
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.edges.equalTo(self.view).insets(kPaddingNav);
        }
    }];
    tabview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.ipage = 1;
        [self getdata];
    }];
    _tabview = tabview;
    [self drawHeaderview];
}

-(void)drawHeaderview
{
    UIView *viewtop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, 100)];
    [viewtop setBackgroundColor:[UIColor whiteColor]];
    
    
    UIView *viewsearch = [[UIView alloc] initWithFrame:CGRectMake(30, 10, kMainScreenW-60, 35)];
    [viewsearch setBackgroundColor:RGB(245, 245, 245)];
    [viewtop addSubview:viewsearch];
    [viewsearch.layer setMasksToBounds:NO];
    [viewsearch.layer setCornerRadius:viewsearch.height/2.0];
    
    UITextField *fieldSearch = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, viewsearch.width-75, viewsearch.height)];;
    [fieldSearch setTextColor:RGB(30, 30, 30)];
    [fieldSearch setTextAlignment:NSTextAlignmentLeft];
    [fieldSearch setFont:[UIFont systemFontOfSize:14]];
    [fieldSearch setPlaceholder:@"搜索"];
    [fieldSearch setReturnKeyType:UIReturnKeySearch];
    [fieldSearch setDelegate:self];
    [viewsearch addSubview:fieldSearch];
    _fieldSearch = fieldSearch;
    
    UIButton *btsearch = [[UIButton alloc] initWithFrame:CGRectMake(viewsearch.width-viewsearch.height, 0, viewsearch.height, viewsearch.height)];
    [btsearch setImage:[UIImage imageNamed:@"ic_query_blue"] forState:UIControlStateNormal];
    [viewsearch addSubview:btsearch];
    
    
    UILabel *lbbcnum = [[UILabel alloc] initWithFrame:CGRectMake(10, viewsearch.bottom+20, viewsearch.width, 20)];
    [lbbcnum setTextColor:RGB(30, 30, 30)];
    [lbbcnum setTextAlignment:NSTextAlignmentLeft];
    [lbbcnum setFont:[UIFont systemFontOfSize:13]];
    [lbbcnum setText:@"本次共查询出22条数据！"];
    [viewtop addSubview:lbbcnum];
    _lbbcnum = lbbcnum;
    [viewtop setHeight:lbbcnum.bottom+20];
    
    [_tabview setTableHeaderView:viewtop];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"])
    {
        //搜索
        [textField resignFirstResponder];
        [self getdata];
        return NO;
    }
    return YES;
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"ShiPinJCTableViewCell";
    ShiPinJCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[ShiPinJCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setModel:self.arrdata[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShiPinJcShuiChangListModel *model = self.arrdata[indexPath.row];
    ShiPinShuiChangJCViewController *vc = [[ShiPinShuiChangJCViewController alloc] init];
    vc.indexCode = model.indexCode;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)getdata
{
    
    [ShiPinJCDataController requestShuiChangListData:self.view name:self.fieldSearch.text pageNumber:self.ipage Callback:^(NSError *error, BOOL state, NSString *describle, id value) {
        [self.tabview.mj_header endRefreshing];
        if(state)
        {
            self.arrdata = value;
        }
        else
        {
            [WYTools showNotifyHUDwithtext:describle inView:self.view];
        }
        [self.lbbcnum setText:[NSString stringWithFormat: @"本次共查询出%ld条数据！",self.arrdata.count]];
        [self.tabview reloadData];
    }];
}

@end
