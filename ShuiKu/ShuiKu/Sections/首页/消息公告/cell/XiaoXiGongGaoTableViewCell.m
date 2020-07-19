//
//  XiaoXiGongGaoTableViewCell.m
//  ShuiKu
//
//  Created by Mac on 2020/7/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "XiaoXiGongGaoTableViewCell.h"

@interface XiaoXiGongGaoTableViewCell ()
@property (nonatomic , strong) UILabel *lbname;
@property (nonatomic , strong) UILabel *lbcontent;
@property (nonatomic , strong) UILabel *lbtime;
@end

@implementation XiaoXiGongGaoTableViewCell

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
        [lbname setFont:[UIFont systemFontOfSize:14]];
        [viewback addSubview:lbname];
        [lbname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(5);
            make.top.offset(15);
            make.right.equalTo(viewback).offset(-90);
        }];
        _lbname =lbname;
        
        UILabel *lbcontent = [[UILabel alloc] init];
        [lbcontent setTextColor:RGB(130, 130, 130)];
        [lbcontent setTextAlignment:NSTextAlignmentLeft];
        [lbcontent setFont:[UIFont systemFontOfSize:13]];
        [viewback addSubview:lbcontent];
        [lbcontent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(5);
            make.top.equalTo(lbname.mas_bottom).offset(10);
            make.right.equalTo(viewback).offset(-90);
        }];
        _lbcontent = lbcontent;
        
        UILabel *lbtime = [[UILabel alloc] init];
        [lbtime setTextColor:RGB(130, 130, 130)];
        [lbtime setTextAlignment:NSTextAlignmentRight];
        [lbtime setFont:[UIFont systemFontOfSize:13]];
        [viewback addSubview:lbtime];
        [lbtime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbname.mas_bottom).offset(10);
            make.right.equalTo(viewback).offset(-30);
        }];
        _lbtime = lbtime;
        
        
        UIImageView *imgvnext = [[UIImageView alloc] init];
        [imgvnext setContentMode:UIViewContentModeScaleAspectFit];
        [imgvnext setImage:[UIImage imageNamed:@"下一步"]];
        [viewback addSubview:imgvnext];
        [imgvnext mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(viewback).offset(-10);
            make.centerY.equalTo(viewback);
            make.width.height.offset(16);
        }];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_lbname setText:@"测试"];
    
    [_lbcontent setText:@"测试内容测试内容测试内容测试内容测试内容"];
    
    [_lbtime setText:@"47天前"];
    
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
