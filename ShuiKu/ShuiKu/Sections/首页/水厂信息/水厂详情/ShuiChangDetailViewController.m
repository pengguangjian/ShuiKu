//
//  ShuiChangDetailViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ShuiChangDetailViewController.h"
#import "ShuiChangDetailTableViewCell.h"

#import "ShuiChangListModel.h"

@interface ShuiChangDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tabview;


@property (nonatomic , strong) NSMutableArray *arrTitles;


@property (nonatomic , strong) NSMutableArray *arrValues;

@end

@implementation ShuiChangDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self gettitleData];
    
    [self drawUI];
    
}
-(void)gettitleData
{
    NSMutableArray *arrtitle = [NSMutableArray new];
    NSArray *arritem0 = @[@"水厂名称",@"水厂编码"];
    NSDictionary *dicitem0 = @{@"基本信息":arritem0};
    [arrtitle addObject:dicitem0];
    
    NSArray *arrvalue0 = @[self.model.NAME,self.model.CODE];
    
    
    
    NSArray *arritem1 = @[@"经度",@"纬度",@"行政区划代码",@"行政区划名称"];
    NSDictionary *dicitem1 = @{@"位置信息":arritem1};
    [arrtitle addObject:dicitem1];
    
    NSArray *arrvalue1 = @[self.model.LGTD,self.model.LTTD,self.model.ADDVCD,self.model.ADDVNM];
    
    
    NSArray *arritem2 = @[@"负责人",@"联系人",@"联系电话",@"邮政编码"];
    NSDictionary *dicitem2 = @{@"相关人员":arritem2};
    [arrtitle addObject:dicitem2];
    
    NSArray *arrvalue2 = @[[NSString stringWithFormat:@"%@",self.model.FZR],
                           [NSString stringWithFormat:@"%@",self.model.LXR],
                           [NSString stringWithFormat:@"%@",self.model.LXDH],
                           [NSString stringWithFormat:@"%@",self.model.YZBM]];
    
    
    NSArray *arritem3 = @[@"水厂地址",@"供水能力",@"水源地",@"服务片区",@"水源地类型",@"水源地所属流域",@"应急水源名称",@"应急水源净水措施",@"供水站总投资",@"设计生产能力",@"实际生产能力",@"年供水总量",@"平均日生产水量",@"水厂设计压力",@"出厂水压类型",@"取水口地址",@"取水管道总长度",@"建成区面积",@"供水面积",@"用水户数",@"状态",@"备注信息"];
    NSDictionary *dicitem3 = @{@"水厂信息":arritem3};
    [arrtitle addObject:dicitem3];
    NSString *strsylx = @"重力流供水";
    if(self.model.CCSYLX.intValue == 2)
    {
       strsylx = @"加压供水";
    }
    NSString *strsczt = @"离线";
    ///
    if([self.model.STATUS isEqualToString:@"1"])
    {
        strsczt = @"在线";
    }
   
    
    NSArray *arrvalue3 = @[[NSString stringWithFormat:@"%@",self.model.ADDR],
                           [NSString stringWithFormat:@"%@",self.model.GSNL],
                           [NSString stringWithFormat:@"%@",self.model.SYD],
                           [NSString stringWithFormat:@"%@",self.model.FUPQ],
                           [NSString stringWithFormat:@"%@",self.model.SYDLX],
                           [NSString stringWithFormat:@"%@",self.model.SYDSSLY],
                           [NSString stringWithFormat:@"%@",self.model.YJSYMC],
                           [NSString stringWithFormat:@"%@",self.model.YJSYJSCS],
                           [NSString stringWithFormat:@"%@",self.model.ZTZ],
                           [NSString stringWithFormat:@"%@",self.model.SJSCNL],
                           [NSString stringWithFormat:@"%@",self.model.SCNL],
                           [NSString stringWithFormat:@"%@",self.model.NGSZL],
                           [NSString stringWithFormat:@"%@",self.model.PJRSCSL],
                           [NSString stringWithFormat:@"%@",self.model.SCSJYL],
                           strsylx,
                           [NSString stringWithFormat:@"%@",self.model.QSkDZ],
                           [NSString stringWithFormat:@"%@",self.model.YSGDZCD],
                           [NSString stringWithFormat:@"%@",self.model.JCMJ],
                           [NSString stringWithFormat:@"%@",self.model.GSMJ],
                           [NSString stringWithFormat:@"%@",self.model.YSHS],
                           strsczt,
                           [NSString stringWithFormat:@"%@",self.model.REMARK]];
    
    self.arrTitles = arrtitle;
    self.arrValues = [NSMutableArray new];
    [self.arrValues addObject:arrvalue0];
    [self.arrValues addObject:arrvalue1];
    [self.arrValues addObject:arrvalue2];
    [self.arrValues addObject:arrvalue3];
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
    
    NSString *strtemp = @"";
    if(indexPath.section == 3)
    {
        if(indexPath.row == 1)
        {
            strtemp = @"m³/d";
        }
        else if (indexPath.row == 8)
        {
            strtemp = @"万元";
        }
        else if (indexPath.row == 9||indexPath.row == 10)
        {
            strtemp = @"万立方米/日";
        }
        else if (indexPath.row == 11||indexPath.row == 12)
        {
            strtemp = @"万立方米";
        }
        else if (indexPath.row == 13)
        {
            strtemp = @"兆帕";
        }
        else if (indexPath.row == 15||indexPath.row == 16)
        {
            strtemp = @"公里";
        }
        else if (indexPath.row == 17||indexPath.row == 18)
        {
            strtemp = @"平方公里";
        }
    }
    
    if([arrvalue[indexPath.row] isEqualToString:@"(null)"])
    {
        [cell.lbvalue setText:[NSString stringWithFormat:@"-%@",strtemp]];
    }
    else
    {
        [cell.lbvalue setText:[NSString stringWithFormat:@"%@%@",arrvalue[indexPath.row],strtemp]];
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
