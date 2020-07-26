//
//  CeZhanXinXiDetailViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CeZhanXinXiDetailViewController.h"
#import "ShuiChangDetailTableViewCell.h"
#import "CeZhanListModel.h"
@interface CeZhanXinXiDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tabview;


@property (nonatomic , strong) NSMutableArray *arrTitles;

@property (nonatomic , strong) NSMutableArray *arrValues;

@end

@implementation CeZhanXinXiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self gettitleData];
    
    [self drawUI];
    
}
-(void)gettitleData
{
    NSMutableArray *arrtitle = [NSMutableArray new];
    NSArray *arritem0 = @[@"测站名称",@"测站编码",@"测站类型",@"测站地址"];
    NSDictionary *dicitem0 = @{@"基本信息":arritem0};
    [arrtitle addObject:dicitem0];
    
    NSArray *arrtype = @[@"河道水位站",@"水库水位站",@"雨量站",@"水质站",@"生态流量站",@"取用水量站",@"图像站",@"视频站"];
    NSString *strtype = @"";
    @try {
        strtype = arrtype[self.model.STTYPE.intValue-1];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    NSArray *arrvalue0 = @[[NSString stringWithFormat:@"%@",self.model.NAME],
                           [NSString stringWithFormat:@"%@",self.model.STCD],
                           strtype,
                           [NSString stringWithFormat:@"%@",self.model.STLC]];
    
    NSArray *arritem1 = @[@"经度",@"纬度",@"行政区划代码",@"行政区划名称"];
    NSDictionary *dicitem1 = @{@"位置信息":arritem1};
    [arrtitle addObject:dicitem1];
    
    NSArray *arrvalue1 = @[[NSString stringWithFormat:@"%@",self.model.LGTD],
                           [NSString stringWithFormat:@"%@",self.model.LTTD],
                           [NSString stringWithFormat:@"%@",self.model.ADDVCD],
                           [NSString stringWithFormat:@"%@",self.model.ADDVNM]];
    
    NSArray *arritem2 = @[@"自动/人工",@"原水出水",@"建站年月",@"始报年月",@"数据来源",@"所属对象",@"状态",@"备注信息"];
    NSDictionary *dicitem2 = @{@"测站信息":arritem2};
    [arrtitle addObject:dicitem2];
    
    NSString *strzidong = @"自动";
    if(self.model.AUTO.intValue != 1)
    {
        strzidong = @"手动";
    }
    
    NSString *stryscs = @"进水";
    if(self.model.WSTYPE.intValue == 1)
    {
        stryscs = @"出水";
    }
    
    NSString *strsczt = @"离线";
    ///
    if([self.model.STATUS isEqualToString:@"1"])
    {
        strsczt = @"在线";
    }
    
    NSArray *arrvalue2 = @[strzidong,
                           stryscs,
    [NSString stringWithFormat:@"%@",self.model.ESSTYM],
    [NSString stringWithFormat:@"%@",self.model.BGFRYM],
    [NSString stringWithFormat:@"%@",self.model.SOURCE],
    [NSString stringWithFormat:@"%@",self.model.OWNER_NM],
                           strsczt,
    [NSString stringWithFormat:@"%@",self.model.REMARK]];
    
    self.arrTitles = arrtitle;
    self.arrValues = [NSMutableArray new];
    [self.arrValues addObject:arrvalue0];
    [self.arrValues addObject:arrvalue1];
    [self.arrValues addObject:arrvalue2];
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
    
    NSArray *arrvalue = self.arrValues[indexPath.section];
    if([arrvalue[indexPath.row] isEqualToString:@"(null)"])
    {
        [cell.lbvalue setText:[NSString stringWithFormat:@"-"]];
    }
    else
    {
        [cell.lbvalue setText:[NSString stringWithFormat:@"%@",arrvalue[indexPath.row]]];
    }
    
    
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
