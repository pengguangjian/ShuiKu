//
//  XiaoXiGongGaoTableViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "XiaoXiGongGaoTableViewController.h"
#import "XiaoXiGongGaoTableViewCell.h"
#import "WkWebviewViewController.h"
#import "XiaoXiGongGaoDataController.h"
@interface XiaoXiGongGaoTableViewController ()
{
    int ipage;
    
    NSMutableArray *arrdata;
}


@end

@implementation XiaoXiGongGaoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        self->ipage=1;
        [self getData];
    }];
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        self->ipage+=1;
        [self getData];
    }];
    
}
-(void)getData
{
    if(ipage==0)ipage=1;
    
    [XiaoXiGongGaoDataController requestTongZhiGongLieBiaoData:self.view NewType:_newtype pageNumber:ipage Callback:^(NSError *error, BOOL state, NSString *describle, NSDictionary *value) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if(state)
        {
            NSArray *arrrows = [value objectForKey:@"rows"];
            if(self->arrdata == nil||self->ipage==1)
            {
                self->arrdata = [NSMutableArray new];
            }
            [self->arrdata addObjectsFromArray:arrrows];
        }
        [self.tableView reloadData];
        
    }];
    
}
#pragma mark - Table view data source
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"XiaoXiGongGaoTableViewCell";
    XiaoXiGongGaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[XiaoXiGongGaoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.dicvalue = arrdata[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dicitem = arrdata[indexPath.row];
    [XiaoXiGongGaoDataController requestTongZhiGongXiangQingData:self.view gid:[NSString nullToString:[dicitem objectForKey:@"ID"]] Callback:^(NSError *error, BOOL state, NSString *describle, NSDictionary *value) {
        if(state)
        {
            WkWebviewViewController *vc = [[WkWebviewViewController alloc] init];
            vc.strcontnt = [NSString nullToString:[value objectForKey:@"NICONTENT"]];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            [WYTools showNotifyHUDwithtext:describle inView:self.view];
        }
    }];
    
    
}

@end
