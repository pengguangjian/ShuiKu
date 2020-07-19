//
//  MapPointShowAlterView.m
//  ShuiKu
//
//  Created by Mac on 2020/7/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MapPointShowAlterView.h"
#import "ShuiChangDetailViewController.h"
#import "ZhongHeJCDetailViewController.h"
#import "ShiPinShuiChangJCViewController.h"

@interface MapPointShowAlterView ()

@property (nonatomic , strong) NSMutableArray *arrlbvalue;

@end

@implementation MapPointShowAlterView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:RGBAlpha(0, 0, 0, 0.4)];
        self.arrlbvalue = [NSMutableArray new];
        NSArray *arrtitle = @[@"",@"测站地址：",@"状        态：",@"供水能力：",@"水  源  地：",@"服务片区：",@"水厂状态："];
        UIView *viewlast = nil;
        for(int i = 0 ; i <arrtitle.count; i++)
        {
            UIView *viewitem = [[UIView alloc] init];
            [self addSubview:viewitem];
            [viewitem mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.height.offset(20);
                if(viewlast == nil)
                {
                    make.top.offset(0);
                }
                else
                {
                    make.top.equalTo(viewlast.mas_bottom);
                }
                
            }];
            UILabel *lbitem = [self drawitemview:viewitem andtitle:arrtitle[i]];
            [self.arrlbvalue addObject:lbitem];
            viewlast = viewitem;
        }
        
        NSArray *arbtname = @[@"查看水厂详情",@"查看实时数据",@"查看视频数据"];
        for(int i = 0 ; i < arbtname.count; i++)
        {
            UIButton *btitem = [[UIButton alloc] init];
            [btitem setTitle:arbtname[i] forState:UIControlStateNormal];
            [btitem setTitleColor:MenuColor forState:UIControlStateNormal];
            [btitem.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [self addSubview:btitem];
            [btitem mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(kMainScreenW/3.0*i);
                make.top.equalTo(viewlast.mas_bottom).offset(10);
                make.width.offset(kMainScreenW/3.0);
                make.height.offset(40);
            }];
            [btitem setTag:i];
            [btitem addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        
        UIButton *btguanbi = [[UIButton alloc] init];
        [btguanbi setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btguanbi setTitle:@"点击关闭" forState:UIControlStateNormal];
        [btguanbi.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [self addSubview:btguanbi];
        [btguanbi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.right.equalTo(self).offset(-20);
            make.height.offset(20);
        }];
        [btguanbi addTarget:self action:@selector(guanbiAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(UILabel *)drawitemview:(UIView *)view andtitle:(NSString *)title
{
    UILabel *lbtitle = [[UILabel alloc] init];
    [lbtitle setText:title];
    [lbtitle setTextAlignment:NSTextAlignmentLeft];
    [lbtitle setTextColor:[UIColor blackColor]];
    [lbtitle setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:lbtitle];
    [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.centerY.equalTo(view);
    }];
    
    UILabel *lbvalue = [[UILabel alloc] init];
    [lbvalue setTextAlignment:NSTextAlignmentLeft];
    [lbvalue setTextColor:[UIColor blackColor]];
    [lbvalue setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:lbvalue];
    [lbvalue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbtitle.mas_right);
        make.centerY.equalTo(view);
    }];
    
    return lbvalue;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    UILabel *lbvalue0 = self.arrlbvalue[0];
    [lbvalue0 setText:@"水厂名"];
    
    UILabel *lbvalue1 = self.arrlbvalue[1];
    [lbvalue1 setText:@"水厂地址"];
    
    
    UILabel *lbvalue2 = self.arrlbvalue[2];
    [lbvalue2 setText:@"离线"];
    
    UILabel *lbvalue3 = self.arrlbvalue[3];
    [lbvalue3 setText:@"800m³/d"];
    
    
    UILabel *lbvalue4 = self.arrlbvalue[4];
    [lbvalue4 setText:@"水源地"];
    
    UILabel *lbvalue5 = self.arrlbvalue[5];
    [lbvalue5 setText:@"服务片区"];
    
    UILabel *lbvalue6 = self.arrlbvalue[6];
    [lbvalue6 setText:@"正常"];
    
}

///关闭
-(void)guanbiAction
{
    [self removeFromSuperview];
}

-(void)bottomAction:(UIButton *)sender
{
    if(sender.tag==0)
    {
        ShuiChangDetailViewController *vc = [[ShuiChangDetailViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
    else if(sender.tag==1)
    {
        ZhongHeJCDetailViewController *vc = [[ZhongHeJCDetailViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
    else if(sender.tag==2)
    {
        ShiPinShuiChangJCViewController *vc = [[ShiPinShuiChangJCViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
}

@end
