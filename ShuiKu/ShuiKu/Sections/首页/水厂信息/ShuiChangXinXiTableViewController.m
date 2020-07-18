//
//  ShuiChangXinXiTableViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ShuiChangXinXiTableViewController.h"
#import "ShuiChangXinXiTableViewCell.h"
#import "RightBtnSXView.h"
#import "ShuiChangDetailViewController.h"

@interface ShuiChangXinXiTableViewController ()<UITableViewDelegate,UITableViewDataSource,RightBtnSXViewDelegate>

@property (nonatomic , strong) UITableView *tabview;

@property (nonatomic , strong) RightBtnSXView *rightview;

@end

@implementation ShuiChangXinXiTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"水厂信息";
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
    _tabview = tabview;
    
    [self drawHeaderView];
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
    [lbbcnum setText:@"本次共查询出22条数据！"];
    [viewtop addSubview:lbbcnum];
    [_tabview setTableHeaderView:viewtop];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"ShuiChangXinXiTableViewCell";
    ShuiChangXinXiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[ShuiChangXinXiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
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
    ShuiChangDetailViewController *vc = [[ShuiChangDetailViewController alloc] init];
    vc.strtitle = @"水厂详情";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
