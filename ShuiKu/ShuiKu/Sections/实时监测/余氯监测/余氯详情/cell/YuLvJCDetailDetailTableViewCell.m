//
//  YuLvJCDetailDetailTableViewCell.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "YuLvJCDetailDetailTableViewCell.h"

@interface YuLvJCDetailDetailTableViewCell ()

@property (nonatomic , strong) UILabel *lbtime;

@property (nonatomic , strong) NSMutableArray *arrallLB;

@end

@implementation YuLvJCDetailDetailTableViewCell

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
            make.left.offset(2);
            make.top.offset(0);
            make.right.equalTo(self).offset(-2);
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
        
        
        UILabel *lbtime = [[UILabel alloc] init];
        [lbtime setTextColor:RGB(30, 30, 30)];
        [lbtime setTextAlignment:NSTextAlignmentLeft];
        [lbtime setFont:[UIFont systemFontOfSize:13]];
        [viewback addSubview:lbtime];
        [lbtime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(5);
            make.top.offset(15);
        }];
        _lbtime = lbtime;
        
        
        UILabel *lbjinshui = [[UILabel alloc] init];
        [lbjinshui setTextColor:RGB(30, 30, 30)];
        [lbjinshui setTextAlignment:NSTextAlignmentLeft];
        [lbjinshui setFont:[UIFont systemFontOfSize:13]];
        [lbjinshui setText:@"出水"];
        [viewback addSubview:lbjinshui];
        [lbjinshui mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(5);
            make.top.equalTo(lbtime.mas_bottom).offset(10);
        }];
        
        
        _arrallLB = [NSMutableArray new];
        NSArray *arrzhuang = @[@"出水余氯"];
        for(int i = 0; i < arrzhuang.count; i++)
        {
            UIView *viewitem = [[UIView alloc] init];
            [viewback addSubview:viewitem];
            [viewitem mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(0);
                make.width.equalTo(viewback);
                make.top.equalTo(lbjinshui.mas_bottom).offset(10+25*i);
                make.height.offset(20);
            }];
            UILabel *lbvalue = [self drawItemView:viewitem andtitle:arrzhuang[i]];
            [_arrallLB addObject:lbvalue];
        }
        
    }
    return self;
}

-(UILabel *)drawItemView:(UIView *)view andtitle:(NSString *)title
{
    UILabel *lbname = [[UILabel alloc] init];
    [lbname setTextColor:RGB(30, 30, 30)];
    [lbname setTextAlignment:NSTextAlignmentLeft];
    [lbname setFont:[UIFont systemFontOfSize:13]];
    [lbname setText:title];
    [view addSubview:lbname];
    [lbname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(3);
        make.top.bottom.equalTo(view);
        make.width.offset(60);
    }];
    
    UIView *viewbck = [[UIView alloc] init];
    [viewbck.layer setMasksToBounds:YES];
    [viewbck.layer setCornerRadius:9];
    [viewbck setBackgroundColor:RGB(245, 245, 245)];
    [view addSubview:viewbck];
    [viewbck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbname.mas_right);
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-10);
        make.height.offset(18);
    }];
    
    UILabel *lbvalue = [[UILabel alloc] init];
    [lbvalue setTextColor:RGB(30, 30, 30)];
    [lbvalue setTextAlignment:NSTextAlignmentLeft];
    [lbvalue setFont:[UIFont systemFontOfSize:13]];
    [lbvalue setText:title];
    [viewbck addSubview:lbvalue];
    [lbvalue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.bottom.equalTo(viewbck);
        make.right.equalTo(viewbck).offset(-5);
    }];
    
    
    return lbvalue;
}


-(void)setModel:(JianCeMainListModel *)model
{
    [_lbtime setText:model.TM];
    
    UILabel *lb0 = self.arrallLB[0];
    [lb0 setText:[NSString stringWithFormat:@"%@ mg/L", model.CL]];
    
    
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
