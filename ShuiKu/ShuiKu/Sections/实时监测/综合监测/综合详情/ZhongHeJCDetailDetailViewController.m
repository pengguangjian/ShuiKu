
//
//  ZhongHeJCDetailDetailViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ZhongHeJCDetailDetailViewController.h"
#import "ZongHeJianCeMainListModel.h"
@interface ZhongHeJCDetailDetailViewController ()

@property (nonatomic , strong) UILabel *lbname;
@property (nonatomic , strong) UILabel *lbaddress;
@property (nonatomic , strong) NSMutableArray *arrallLB;

@end

@implementation ZhongHeJCDetailDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawUI];
    
}

-(void)drawUI
{
    UIView *viewback = [[UIView alloc] init];
    [viewback setBackgroundColor:[UIColor whiteColor]];
    [viewback.layer setMasksToBounds:NO];
    [viewback.layer setCornerRadius:4];
    [viewback.layer setBorderWidth:1];
    [viewback.layer setBorderColor:RGB(240, 240, 240).CGColor];
    [self.view addSubview:viewback];
    [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(8);
        make.right.equalTo(self.view).offset(-10);
    }];
    // 阴影颜色
    viewback.layer.shadowColor = RGBAlpha(0, 0, 0, 0.7).CGColor;
    // 阴影偏移，默认(0, -3)
    viewback.layer.shadowOffset = CGSizeMake(0,2);
    // 阴影透明度，默认0
    viewback.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    viewback.layer.shadowRadius = 3;
    
    
    UILabel *lbname = [[UILabel alloc] init];
    [lbname setTextColor:RGB(30, 30, 30)];
    [lbname setTextAlignment:NSTextAlignmentLeft];
    [lbname setFont:[UIFont systemFontOfSize:13]];
    [viewback addSubview:lbname];
    [lbname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.top.offset(15);
    }];
    _lbname = lbname;
    [_lbname setText:[NSString stringWithFormat:@"%@(%@)",self.model.NAME,self.model.CODE]];
    
    UILabel *lbaddress = [[UILabel alloc] init];
    [lbaddress setTextColor:RGB(130, 130, 130)];
    [lbaddress setTextAlignment:NSTextAlignmentLeft];
    [lbaddress setFont:[UIFont systemFontOfSize:11]];
    [viewback addSubview:lbaddress];
    [lbaddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbname);
        make.top.equalTo(lbname.mas_bottom).offset(5);
    }];
    _lbaddress = lbaddress;
    [_lbaddress setText:self.model.ADDR];
    
    _arrallLB = [NSMutableArray new];
    NSArray *arrzhuang = @[@"状态",@"进水浊度",@"出水浊度",@"进水温度",@"出水温度",@"进水PH值",@"出水PH值",@"出水余氯",@"进水瞬时流量",@"出水瞬时流量",@"负责人",@"联系电话"];
    UIView *viewlast = nil;
    for(int i = 0; i < arrzhuang.count; i++)
    {
        UIView *viewitem = [[UIView alloc] init];
        [viewback addSubview:viewitem];
        [viewitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(viewback);
            make.top.equalTo(lbname.mas_bottom).offset(20+25*i);
            make.height.offset(20);
        }];
        UILabel *lbvalue = [WYTools drawitemView:viewitem andtitle:arrzhuang[i]];
        [_arrallLB addObject:lbvalue];
        
        viewlast = viewitem;
    }
    
    
    [self setallLbValue];
    
    
    
    [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewlast.mas_bottom).offset(5);
    }];
}

-(void)setallLbValue
{
    UILabel *lb0 = self.arrallLB[0];
    [lb0 setText:@"离线"];
    if(self.model.STATUS.intValue == 1)
    {
        [lb0 setText:@"在线"];
    }
    
    UILabel *lb1 = self.arrallLB[1];
    [lb1 setText:[NSString stringWithFormat:@"%.2lf NTU",self.model.YSZD.floatValue]];
    
    UILabel *lb2 = self.arrallLB[2];
    [lb2 setText:[NSString stringWithFormat:@"%.2lf NTU",self.model.CSZD.floatValue]];
    
    UILabel *lb3 = self.arrallLB[3];
    [lb3 setText:[NSString stringWithFormat:@"%@ ℃",self.model.YSWD]];
    
    UILabel *lb4 = self.arrallLB[4];
    [lb4 setText:[NSString stringWithFormat:@"%@ ℃",self.model.CSWD]];
    
    UILabel *lb5 = self.arrallLB[5];
    [lb5 setText:[NSString stringWithFormat:@"%.2lf",self.model.YSPH.floatValue]];
    
    UILabel *lb6 = self.arrallLB[6];
    [lb6 setText:[NSString stringWithFormat:@"%.2lf",self.model.CSPH.floatValue]];
    
    UILabel *lb7 = self.arrallLB[7];
    [lb7 setText:[NSString stringWithFormat:@"%.2lf mg/L",self.model.CSYL.floatValue]];
    
    UILabel *lb8 = self.arrallLB[8];
    [lb8 setText:[NSString stringWithFormat:@"%.2lf m³/s",self.model.YSQ.floatValue]];
    
    UILabel *lb9 = self.arrallLB[9];
    [lb9 setText:[NSString stringWithFormat:@"%.2lf m³/s",self.model.CSQ.floatValue]];
    
    UILabel *lb10 = self.arrallLB[10];
    [lb10 setText:[NSString stringWithFormat:@"%@",[NSString nullToString:self.model.FZR]]];
    
    UILabel *lb11 = self.arrallLB[11];
    [lb11 setText:[NSString stringWithFormat:@"%@",[NSString nullToString:self.model.LXDH]]];
}

@end
