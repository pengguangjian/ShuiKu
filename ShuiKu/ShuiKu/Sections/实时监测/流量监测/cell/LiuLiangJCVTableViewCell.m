//
//  LiuLiangJCVTableViewCell.m
//  ShuiKu
//
//  Created by Mac on 2020/7/13.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LiuLiangJCVTableViewCell.h"


@interface LiuLiangJCVTableViewCell ()

@property (nonatomic , strong) UILabel *lbname;

@property (nonatomic , strong) NSMutableArray *arrallLB;
@property (nonatomic , strong) UIImageView *imgvset;

@property (nonatomic , assign) float fsing;
@end

@implementation LiuLiangJCVTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        UIView *viewback = [[UIView alloc] init];
        [viewback setBackgroundColor:[UIColor whiteColor]];
        [viewback.layer setMasksToBounds:NO];
        [viewback.layer setCornerRadius:4];
        [viewback.layer setBorderWidth:1];
        [viewback.layer setBorderColor:RGB(240, 240, 240).CGColor];
        [self.contentView addSubview:viewback];
        [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(5);
            make.top.offset(0);
            make.right.equalTo(self).offset(-5);
            make.bottom.equalTo(self).offset(-10);
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
        
        UIImageView *imgvset = [[UIImageView alloc] init];
        [imgvset setImage:[UIImage imageNamed:@"ic_state_blue"]];
        [viewback addSubview:imgvset];
        [imgvset mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.offset(20);
            make.top.offset(10);
            make.right.equalTo(viewback).offset(-10);
        }];
        _imgvset = imgvset;
        
        _arrallLB = [NSMutableArray new];
        NSArray *arrzhuang = @[@"状态",@"进水瞬间流量",@"进水累计水量",@"出水瞬间流量",@"出水累计水量",@"监测时间"];
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
        }
        
        
        
    }
    return self;
}

-(void)startAnimation0
{
    NSString *strtemp = [[NSUserDefaults standardUserDefaults] objectForKey:@"xuanzhuandonghuaxinxi"];
    if(strtemp.intValue>0)
    {
        CGAffineTransform endAngle = CGAffineTransformMakeRotation(self.fsing * (M_PI / 180.0f));
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.imgvset.transform = endAngle;
        } completion:^(BOOL finished) {
            self.fsing+=10;
            [self startAnimation0];
        }];
    }
    
}
-(void)setModel:(LiuLiangJCListModel *)model
{
    
    [_lbname setText:model.NAME];
    UILabel *lb0 = self.arrallLB[0];
    if([model.STATUS intValue] == 1)
    {/// 0：离线；1:在线
        [lb0 setText:@"在线"];
    }
    else
    {
        [lb0 setText:@"离线"];
    }
    
    NSArray *arrvalue = @[[NSString stringWithFormat:@"%@m³/S", model.Q0],[NSString stringWithFormat:@"%@t",model.W0],[NSString stringWithFormat:@"%@m³/S",model.Q1],[NSString stringWithFormat:@"%@t",model.W1],model.TM];
    for(int i = 1; i < self.arrallLB.count; i++)
    {
        UILabel *lb = self.arrallLB[i];
        [lb setText:[NSString stringWithFormat:@"%@",arrvalue[i-1]]];
    }
    if(model.STATUS.intValue == 1)
    {
        [self.imgvset setImage:[UIImage imageNamed:@"ic_state_blue"]];
        [self startAnimation0];
    }
    else
    {
        [self.imgvset setImage:[UIImage imageNamed:@"ic_state_gray"]];
    }
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
