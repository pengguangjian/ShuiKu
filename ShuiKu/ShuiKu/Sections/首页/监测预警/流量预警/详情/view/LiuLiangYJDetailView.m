//
//  LiuLiangYJDetailView.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LiuLiangYJDetailView.h"
#import "LiuLiangYJChuZhiDetailCZViewController.h"

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
        [self drawbottom];
        
        
        
    }
    return self;
}

-(void)drawbottom
{
    ///处置中
//    UIButton *btguanbi = [[UIButton alloc] init];
//    [btguanbi setTitle:@"关闭预警" forState:UIControlStateNormal];
//    [btguanbi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btguanbi.titleLabel setFont:[UIFont systemFontOfSize:14]];
//    [btguanbi setBackgroundColor:RGB(255, 30, 30)];
//    [_viewbottom addSubview:btguanbi];
//    [btguanbi mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.viewbottom);
//    }];
//    [btguanbi addTarget:self action:@selector(guanbiAction) forControlEvents:UIControlEventTouchUpInside];
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
///@"预警处置",@"短信通知"
-(void)bottomAction:(UIButton *)sender
{
    if(sender.tag==0)
    {
        LiuLiangYJChuZhiDetailCZViewController *vc = [[LiuLiangYJChuZhiDetailCZViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        
    }
}
///关闭预警
-(void)guanbiAction
{
    
}

@end
