//
//  LiuLiangYJDetailView.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LiuLiangYJDetailView.h"
#import "LiuLiangYJChuZhiDetailCZViewController.h"
#import "LiShiYuJingViewController.h"

#import "YuJingNewListModel.h"
#import "LiuLiangYJDataController.h"
#import "YuJingXiangQingYuJingChuZhiViewController.h"


@interface LiuLiangYJDetailView ()
@property (nonatomic , strong) UILabel *lbname;
@property (nonatomic , strong) UILabel *lbaddress;
@property (nonatomic , strong) NSMutableArray *arrallLB;
@property (nonatomic , strong) UIView *viewbottom;
@end

@implementation LiuLiangYJDetailView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UIView *viewback = [[UIView alloc] init];
        [viewback setBackgroundColor:[UIColor whiteColor]];
        [viewback.layer setMasksToBounds:NO];
        [viewback.layer setCornerRadius:4];
        [viewback.layer setBorderWidth:1];
        [viewback.layer setBorderColor:RGB(240, 240, 240).CGColor];
        [self addSubview:viewback];
        [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.offset(8);
            make.right.equalTo(self).offset(-10);
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
        [_lbname setText:@"标题标题标题标题标题"];
        
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
        [_lbaddress setText:@"水厂名"];
        
        _arrallLB = [NSMutableArray new];
        NSArray *arrzhuang = @[@"预警类型",@"超标值",@"预警阀值",@"是否自动填报",@"预警时间",@"预警等级",@"负责人",@"联系电话",@"数据状态",@"预警纬度",@"创建人",@"创建时间"];
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
        
        [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(viewlast.mas_bottom).offset(5);
        }];
        
        UIButton *btlishi = [[UIButton alloc] init];
        [btlishi setBackgroundColor:RGB(133, 174, 226)];
        [btlishi addTarget:self action:@selector(lishiAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btlishi];
        [btlishi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(viewback.mas_bottom).offset(15);
            make.height.offset(40);
        }];
        UILabel *lblishi = [[UILabel alloc] init];
        [lblishi setText:@"历史预警"];
        [lblishi setTextColor:RGB(50, 50, 50)];
        [lblishi setTextAlignment:NSTextAlignmentLeft];
        [lblishi setFont:[UIFont systemFontOfSize:14]];
        [btlishi addSubview:lblishi];
        [lblishi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.top.bottom.equalTo(btlishi);
        }];
        UIImageView *imgvlishi = [[UIImageView alloc] init];
        [imgvlishi setContentMode:UIViewContentModeScaleAspectFit];
        [imgvlishi setImage:[UIImage imageNamed:@"下一步"]];
        [btlishi addSubview:imgvlishi];
        [imgvlishi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.offset(16);
            make.centerY.equalTo(btlishi);
            make.right.equalTo(btlishi).offset(-20);
        }];
        
        UIView *viewbottom = [[UIView alloc] init];
        [self addSubview:viewbottom];
        [viewbottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(btlishi.mas_bottom).offset(20);
            make.height.offset(45);
        }];
        _viewbottom = viewbottom;
        
        
        
    }
    return self;
}

-(void)drawbottom
{
    ///1：新产生；2：已发布；3：响应中；4：已关闭； 5 已忽略；
    if(self.model.FLAG.intValue == 1)
    {
        ///新增
        NSArray *arrtitle = @[@"预警处置",@"短信通知"];
        for(int i = 0; i < 2; i++)
        {
            UIButton *btitem = [[UIButton alloc] init];
            [btitem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btitem setTitle:arrtitle[i] forState:UIControlStateNormal];
            [btitem.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [btitem setBackgroundColor:MenuColor];
            if (i==1) {
                [btitem setBackgroundColor:RGB(35, 190, 255)];
            }
            [self.viewbottom addSubview:btitem];
            [btitem mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self.viewbottom);
                make.width.equalTo(self.viewbottom).multipliedBy(0.5);
                make.left.offset((kMainScreenW-30)/2*i);
            }];
            [btitem setTag:i];
            [btitem addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    else if(self.model.FLAG.intValue == 3)
    {
        ///处置中
        UIButton *btguanbi = [[UIButton alloc] init];
        [btguanbi setTitle:@"关闭预警" forState:UIControlStateNormal];
        [btguanbi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btguanbi.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btguanbi setBackgroundColor:RGB(255, 30, 30)];
        [_viewbottom addSubview:btguanbi];
        [btguanbi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.viewbottom);
        }];
        [btguanbi addTarget:self action:@selector(guanbiAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}
///@"预警处置",@"短信通知"
-(void)bottomAction:(UIButton *)sender
{
    if(sender.tag==0)
    {
        YuJingXiangQingYuJingChuZhiViewController *vc = [[YuJingXiangQingYuJingChuZhiViewController alloc] init];
        vc.WARNING_ID = self.model.ID;
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        [WYTools showNotifyHUDwithtext:@"开发中" inView:self];
    }
}
///关闭预警
-(void)guanbiAction
{
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否关闭该预警" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [LiuLiangYJDataController requestGuanBiYuJinGGData:self.viewController.view did:self.model.ID Callback:^(NSError *error, BOOL state, NSString *describle, id value) {
            if(state)
            {
                [WYTools showNotifyHUDwithtext:@"关闭成功" inView:self.viewController.view.window];
                [self.viewController.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [WYTools showNotifyHUDwithtext:describle inView:self.viewController.view];
            }
        }];
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alter addAction:action];
    [alter addAction:action1];
    
    [self.viewController presentViewController:alter animated:YES completion:nil];
    
    
}

///历史
-(void)lishiAction
{
    LiShiYuJingViewController *vc = [[LiShiYuJingViewController alloc] init];
    vc.title = [NSString stringWithFormat:@"%@历史预警",self.model.SWSTNM];
    vc.strSWSTCD = self.model.SWSTCD;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

-(void)setModel:(YuJingNewListModel *)model
{
    _model = model;
    [self drawbottom];
    [_lbname setText:[NSString stringWithFormat:@"%@(%@)",model.SWSTNM,model.SWSTCD]];
    [_lbaddress setText:model.NAME];
    
    
    UILabel *lb5 = _arrallLB[5];
    [lb5 setTextColor:[UIColor whiteColor]];
    UIView *view5 = lb5.superview;
    
    
    NSString *strtype = @"";
    NSString *strchaobiao = @"";
    NSString *stryujinfz = @"";
    NSString *stryujintime = @"";
    NSString *stryujindengji = @"";
    NSString *strzhuangtai = @"";
    
    if(model.SWLEVEL.intValue == 1)
    {
        stryujindengji = @"蓝色预警";
        [view5 setBackgroundColor:[UIColor blueColor]];
    }
    else if(model.SWLEVEL.intValue == 2)
    {
        stryujindengji = @"黄色预警";
        [view5 setBackgroundColor:[UIColor yellowColor]];
    }
    else if(model.SWLEVEL.intValue == 3)
    {
        stryujindengji = @"橙色预警";
        [view5 setBackgroundColor:[UIColor orangeColor]];
    }
    else if(model.SWLEVEL.intValue == 4)
    {
        stryujindengji = @"红色预警";
        [view5 setBackgroundColor:[UIColor redColor]];
    }
    
    stryujintime = model.SWTM;
    
    ///1:流量 2:浊度 3:温度 4:pH值 5:余氯
    if([model.SWTYPE intValue] == 1)
    {
        strtype = @"流量";
        strchaobiao = [NSString stringWithFormat:@"%@m³/s",model.SWVALUE];
        stryujinfz = [NSString stringWithFormat:@"%@m³/s",model.SWINDEX];
        
        
    }
    else if([model.SWTYPE intValue] == 2)
    {
        strtype = @"浊度";
        strchaobiao = [NSString stringWithFormat:@"%@NTU",model.SWVALUE];
        stryujinfz = [NSString stringWithFormat:@"%@NTU",model.SWINDEX];
    }
    else if([model.SWTYPE intValue] == 3)
    {
        strtype = @"温度";
        strchaobiao = [NSString stringWithFormat:@"%@℃",model.SWVALUE];
        stryujinfz = [NSString stringWithFormat:@"%@℃",model.SWINDEX];
    }
    else if([model.SWTYPE intValue] == 4)
    {
        strtype = @"pH值";
        strchaobiao = [NSString stringWithFormat:@"%@ph",model.SWVALUE];
        stryujinfz = [NSString stringWithFormat:@"%@ph",model.SWINDEX];
    }
    else if([model.SWTYPE intValue] == 5)
    {
        strtype = @"余氯";
        strchaobiao = [NSString stringWithFormat:@"%@mg/L",model.SWVALUE];
        stryujinfz = [NSString stringWithFormat:@"%@mg/L",model.SWINDEX];
    }
    //1：新产生；2：已发布；3：响应中；4：已关闭； 5 已忽略；
    if(model.FLAG.intValue == 1)
    {
        strzhuangtai = @"新产生";
    }
    else if(model.FLAG.intValue == 2)
    {
        strzhuangtai = @"已发布";
    }
    else if(model.FLAG.intValue == 3)
    {
        strzhuangtai = @"响应中";
    }
    else if(model.FLAG.intValue == 4)
    {
        strzhuangtai = @"已关闭";
    }
    else if(model.FLAG.intValue == 5)
    {
        strzhuangtai = @"已忽略";
    }
    
    NSMutableArray *arrvalue = [NSMutableArray new];
    [arrvalue addObject:strtype];
    [arrvalue addObject:strchaobiao];
    [arrvalue addObject:stryujinfz];
    if(model.AUTO.intValue == 1)
    {
        [arrvalue addObject:@"是"];
    }
    else
    {
        [arrvalue addObject:@"否"];
    }
    [arrvalue addObject:stryujintime];
    [arrvalue addObject:stryujindengji];
    [arrvalue addObject:[NSString nullToString:model.FZR]];
    [arrvalue addObject:[NSString nullToString:model.LXDH]];
    [arrvalue addObject:strzhuangtai];
    if(model.SYMBOL.intValue==1)
    {
        [arrvalue addObject:@"超最大值"];
    }
    else
    {
        [arrvalue addObject:@"低最小值"];
    }
    [arrvalue addObject:[NSString nullToString:model.CREATEDBY]];
    [arrvalue addObject:[NSString nullToString:model.CREATEDTIME]];
    
    int i = 0;
    for(UILabel *lb in self.arrallLB)
    {
        if([arrvalue[i] length]==0)
        {
            [lb setText:@"-"];
        }
        else
        {
            [lb setText:arrvalue[i]];
        }
        
        i++;
    }
}

@end
