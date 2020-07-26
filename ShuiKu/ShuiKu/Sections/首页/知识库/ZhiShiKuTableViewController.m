//
//  ZhiShiKuTableViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ZhiShiKuTableViewController.h"
#import "ZhiShiKuListTableViewCell.h"
#import "ZhiShiKuDataController.h"
#import "WkWebviewViewController.h"

@interface ZhiShiKuTableViewController ()
{
    int ipage;
    
    NSMutableArray *arrdata;
}

@end

@implementation ZhiShiKuTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->ipage=1;
        [self getData];
    }];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        self->ipage+=1;
        [self getData];
    }];
    
}
-(void)getData
{
    if(ipage==0)ipage=1;
    
    [ZhiShiKuDataController requestTongZhiGongLieBiaoData:self.view infotype:self.ID pageNumber:ipage Callback:^(NSError *error, BOOL state, NSString *describle, NSArray *value) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if(state)
        {
            if(self->arrdata == nil||self->ipage==1)
            {
                self->arrdata = [NSMutableArray new];
            }
            [self->arrdata addObjectsFromArray:value];
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
    static NSString *strcell = @"ZhiShiKuListTableViewCell";
    ZhiShiKuListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[ZhiShiKuListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
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
    WkWebviewViewController *vc = [[WkWebviewViewController alloc] init];
    NSString *strtitle = [NSString stringWithFormat:@"<p>%@</p>",[dicitem objectForKey:@"KBTITLE"]];
    NSString *strtime = [NSString stringWithFormat:@"<p>%@  %@</p>",[dicitem objectForKey:@"KBAUTHOR"],[dicitem objectForKey:@"CREATEDTIME"]];
    
    NSString *strcontent = [NSString stringWithFormat:@"<p>%@</p>",[dicitem objectForKey:@"KBCONTENT"]];
    
    vc.strcontnt = [NSString stringWithFormat:@"%@%@%@",strtitle,strtime,strcontent];
    vc.title = @"详情";
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

@end
