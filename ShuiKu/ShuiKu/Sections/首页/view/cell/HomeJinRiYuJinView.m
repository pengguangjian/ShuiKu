//
//  HomeJinRiYuJinView.m
//  ShuiKu
//
//  Created by Mac on 2020/7/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "HomeJinRiYuJinView.h"
#import "LiuLiangYJViewController.h"
#import "ChaoBiaoListViewController.h"
@interface HomeJinRiYuJinView  ()

@property (nonatomic , strong) NSMutableArray *arrnumberLB;

@end

@implementation HomeJinRiYuJinView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UILabel *lbtitle = [[UILabel alloc] init];
        [lbtitle setText:@"今日预警"];
        [lbtitle setTextAlignment:NSTextAlignmentLeft];
        [lbtitle setFont:[UIFont systemFontOfSize:16]];
        [lbtitle setTextColor:MenuColor];
        [self addSubview:lbtitle];
        [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(30);
            make.top.offset(0);
            make.height.offset(40);
        }];
        
        UIButton *btmore = [[UIButton alloc] init];
        [btmore setTitle:@"查看更多" forState:UIControlStateNormal];
        [btmore setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
        [btmore.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btmore.layer setMasksToBounds:YES];
        [btmore.layer setCornerRadius:3];
        [btmore.layer setBorderColor:RGB(100, 100, 100).CGColor];
        [btmore.layer setBorderWidth:1];
        [self addSubview:btmore];
        [btmore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.sizeOffset(CGSizeMake(70, 25));
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(lbtitle);
        }];
        [btmore addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
        
        _arrnumberLB = [NSMutableArray new];
        NSArray *arrtille = @[@"流量超标",@"浊度超标",@"超标余氯",@"PH值超标",@"温度超标"];
        for(int i = 0; i < 3; i++)
        {
            for(int j = 0 ; j <2; j++)
            {
                if(i*2+j>=arrtille.count)break;
                UIView *viewitem = [[UIView alloc] init];
                [viewitem setBackgroundColor:RGB(245, 245, 245)];
                [self addSubview:viewitem];
                [viewitem mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(((kMainScreenW-1)/2+1)*j);
                    make.top.equalTo(lbtitle.mas_bottom).offset(41*i);
                    make.height.offset(40);
                    make.width.offset((kMainScreenW-1)/2);
                }];
                UILabel *lbitem = [[UILabel alloc] init];
                [lbitem setText:arrtille[j+i*2]];
                [lbitem setTextAlignment:NSTextAlignmentLeft];
                [lbitem setFont:[UIFont systemFontOfSize:14]];
                [lbitem setTextColor:RGB(51, 51, 51)];
                [viewitem addSubview:lbitem];
                [lbitem mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(viewitem);
                    make.left.offset(10);
                }];
                
                UILabel *lbzuo = [[UILabel alloc] init];
                [lbzuo setText:@"座"];
                [lbzuo setTextAlignment:NSTextAlignmentRight];
                [lbzuo setFont:[UIFont systemFontOfSize:14]];
                [lbzuo setTextColor:RGB(51, 51, 51)];
                [viewitem addSubview:lbzuo];
                [lbzuo mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(viewitem);
                    make.right.equalTo(viewitem).offset(-10);
                }];
                
                UILabel *lbnumber = [[UILabel alloc] init];
                [lbnumber setText:@"0"];
                [lbnumber setTextAlignment:NSTextAlignmentRight];
                [lbnumber setFont:[UIFont systemFontOfSize:18]];
                [lbnumber setTextColor:RGB(31, 31, 31)];
                [viewitem addSubview:lbnumber];
                [lbnumber mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(viewitem);
                    make.right.equalTo(lbzuo.mas_left).offset(-20);
                }];
                [_arrnumberLB addObject:lbnumber];
                
                
                [viewitem setUserInteractionEnabled:YES];
                [viewitem setTag:j+i*2];
                UITapGestureRecognizer *tapitem = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemActioni:)];
                [viewitem addGestureRecognizer:tapitem];
            }
        }
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(165);
        }];
        
        
    }
    return self;
}

-(void)itemActioni:(UIGestureRecognizer *)gesture
{
    NSArray *arrtille = @[@"流量超标",@"浊度超标",@"超标余氯",@"PH值超标",@"温度超标"];
    NSInteger tag = gesture.view.tag;
    
    ChaoBiaoListViewController *vc = [[ChaoBiaoListViewController alloc] init];
    vc.title = arrtille[tag];
    switch (tag) {
        case 0:
        {
            vc.arrData = self.arrliuliang;
        }
            break;
        case 1:
        {
            vc.arrData = self.arrzhuodu;
        }
            break;
        case 2:
        {
            vc.arrData = self.arryulv;
        }
            break;
        case 3:
        {
            vc.arrData = self.arrPHZhi;
        }
            break;
        case 4:
        {
            vc.arrData = self.arrwendu;
        }
            break;
        default:
            break;
    }
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
}
///查看更多
-(void)moreAction
{
    LiuLiangYJViewController *vc = [[LiuLiangYJViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

-(void)setArrliuliang:(NSMutableArray *)arrliuliang
{
    _arrliuliang = arrliuliang;
    UILabel *lb = _arrnumberLB[0];
    [lb setText:[NSString stringWithFormat:@"%ld",arrliuliang.count]];
    
}
-(void)setArrzhuodu:(NSMutableArray *)arrzhuodu
{
    _arrzhuodu = arrzhuodu;
    UILabel *lb = _arrnumberLB[1];
    [lb setText:[NSString stringWithFormat:@"%ld",arrzhuodu.count]];
}
-(void)setArryulv:(NSMutableArray *)arryulv
{
    _arryulv = arryulv;
    UILabel *lb = _arrnumberLB[2];
    [lb setText:[NSString stringWithFormat:@"%ld",arryulv.count]];
}
-(void)setArrPHZhi:(NSMutableArray *)arrPHZhi
{
    _arrPHZhi = arrPHZhi;
    UILabel *lb = _arrnumberLB[3];
    [lb setText:[NSString stringWithFormat:@"%ld",arrPHZhi.count]];
}
-(void)setArrwendu:(NSMutableArray *)arrwendu
{
    _arrwendu = arrwendu;
    UILabel *lb = _arrnumberLB[4];
    [lb setText:[NSString stringWithFormat:@"%ld",arrwendu.count]];
}


@end
