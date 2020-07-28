
//
//  CeZhanXinXiViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CeZhanXinXiViewController.h"
#import "CeZhanXinXiViewTableViewCell.h"
#import "RightBtnSXView.h"
#import "CeZhanXinXiDetailViewController.h"
#import "MainHomeDataController.h"

@interface CeZhanXinXiViewController ()<UITableViewDelegate,UITableViewDataSource,RightBtnSXViewDelegate>

@property (nonatomic , strong) UITableView *tabview;

@property (nonatomic , strong) RightBtnSXView *rightview;

@property (nonatomic , strong) UILabel *lbbcnum;

@property (nonatomic , assign) int ipage;

@property (nonatomic , strong) NSString *strkey;

@property (nonatomic , strong) NSString *xzqhbm;

@property (nonatomic , strong) NSMutableArray *arrdata;

@end

@implementation CeZhanXinXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ipage = 1;
    self.strkey = @"";
    self.xzqhbm = @"";
    
    self.title = @"监测点信息";
    [self setnavbt];
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
    
    [self drawHeaderView];
    [self getdata];
}
-(void)setnavbt
{
    UIButton* btnright = [[UIButton alloc] init];//btnLeft.backgroundColor=[UIColor redColor]
    [btnright setImage:[UIImage imageNamed:@"地图筛选"] forState:UIControlStateNormal];
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnright];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    [btnright addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)rightAction
{
    if(_rightview)
    {
        [UIView animateWithDuration:0.5 animations:^{
            [self.rightview setLeft:kMainScreenW];
        } completion:^(BOOL finished) {
            [self.rightview removeFromSuperview];
            self.rightview = nil;
        }];
        
    }
    else
    {
        RightBtnSXView *view = [[RightBtnSXView alloc] init];
        [view setDelegate:self];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        _rightview = view;
    }
    
}
#pragma mark - RightBtnSXViewDelegate
///搜索
-(void)serachValueText:(NSString *)strzi andaddress:(NSString *)address
{
    self.strkey = strzi;
    self.xzqhbm = address;
    [self getdata];
}
///页面消失
-(void)dismisView
{
    self.rightview = nil;
}


-(void)drawHeaderView
{
    
    UIView *viewtop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, 30)];
    [viewtop setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lbbcnum = [[UILabel alloc] initWithFrame:CGRectMake(10,0, viewtop.width-20, viewtop.height)];
    [lbbcnum setTextColor:RGB(30, 30, 30)];
    [lbbcnum setTextAlignment:NSTextAlignmentLeft];
    [lbbcnum setFont:[UIFont systemFontOfSize:13]];
    [lbbcnum setText:@"本次共查询出0条数据！"];
    [viewtop addSubview:lbbcnum];
    [_tabview setTableHeaderView:viewtop];
    _lbbcnum = lbbcnum;
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"CeZhanXinXiViewTableViewCell";
    CeZhanXinXiViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[CeZhanXinXiViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setModel:self.arrdata[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CeZhanXinXiDetailViewController *vc = [[CeZhanXinXiDetailViewController alloc] init];
    vc.title = @"测站信息详情";
    vc.model = self.arrdata[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)getdata
{
    [MainHomeDataController requestCeDianListData:self.view xzqhbm:self.xzqhbm key:self.strkey pageNumber:self.ipage Callback:^(NSError *error, BOOL state, NSString *describle, NSMutableArray *value) {
        [self.tabview.mj_header endRefreshing];
        if(state)
        {
            self.arrdata = value;
        }
        [self.lbbcnum setText:[NSString stringWithFormat:@"本次共查询出%lu条数据！",(unsigned long)self.arrdata.count]];
        [self.tabview reloadData];
    }];
}

@end
