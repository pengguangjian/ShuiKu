//
//  LiuLiangJCViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/13.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LiuLiangJCViewController.h"
#import "LiuLiangJCVTableViewCell.h"
#import "LiuLiangJCDetailViewController.h"
#import "LiuLiangJCDataController.h"

@interface LiuLiangJCViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    int ipage;
}
@property (nonatomic , strong) UITableView *tabview;

@property (nonatomic , strong) NSMutableArray *arrData;

@property (nonatomic , strong) UITextField *fieldSearch;

@property (nonatomic , strong) UILabel *lbbcnum;

@end

@implementation LiuLiangJCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"流量监测";
    self.arrData = [NSMutableArray new];
    ipage = 1;
    
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
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.edges.equalTo(self.view).insets(kPaddingNav);
        }
    }];
    tabview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->ipage = 1;
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
    [lbbcnum setText:@"本次共查询出0条数据！"];
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


-(void)getdata
{
    [LiuLiangJCDataController requestLiuLiangJianCheListData:self.view key:_fieldSearch.text pageNumber:ipage Callback:^(NSError *error, BOOL state, NSString *describle, NSMutableArray *value) {
        [self.tabview.mj_header endRefreshing];
        if(state)
        {
            if(self->ipage == 1)
            {
                [self.arrData removeAllObjects];
            }
            [self.arrData addObjectsFromArray:value];
        }
        [self.lbbcnum setText:[NSString stringWithFormat:@"本次共查询出%lu条数据！",(unsigned long)self.arrData.count]];
        [self.tabview reloadData];
    }];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"LiuLiangJCVTableViewCell";
    LiuLiangJCVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[LiuLiangJCVTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.model = self.arrData[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 215;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiuLiangJCListModel *model = self.arrData[indexPath.row];
    LiuLiangJCDetailViewController *vc = [[LiuLiangJCDetailViewController alloc] init];
    vc.strtitle = model.NAME;
    vc.stcd = model.STCD;
    [self.navigationController pushViewController:vc animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
