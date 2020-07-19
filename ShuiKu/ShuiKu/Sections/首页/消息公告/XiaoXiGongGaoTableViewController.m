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
@interface XiaoXiGongGaoTableViewController ()

@end

@implementation XiaoXiGongGaoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
}

#pragma mark - Table view data source
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WkWebviewViewController *vc = [[WkWebviewViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
