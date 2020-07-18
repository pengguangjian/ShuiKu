
//
//  RenYuanXinXiTableViewCell.m
//  ShuiKu
//
//  Created by Mac on 2020/7/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "RenYuanXinXiTableViewCell.h"


@interface RenYuanXinXiTableViewCell ()
@property (nonatomic , strong) UILabel *lbname;

@property (nonatomic , strong) UILabel *lbphone;

@property (nonatomic , strong) UIImageView *imgvselect;

@end

@implementation RenYuanXinXiTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        UIView *viewback = [[UIView alloc] init];
        [viewback setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:viewback];
        [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UIImageView *imgvselect = [[UIImageView alloc] init];
        [imgvselect setImage:[UIImage imageNamed:@"选择框"]];
        [viewback addSubview:imgvselect];
        [imgvselect mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.width.height.offset(18);
            make.centerY.equalTo(viewback);
        }];
        _imgvselect = imgvselect;
        
        
        UILabel *lbname = [[UILabel alloc] init];
        [lbname setTextColor:RGB(30, 30, 30)];
        [lbname setTextAlignment:NSTextAlignmentLeft];
        [lbname setFont:[UIFont systemFontOfSize:13]];
        [viewback addSubview:lbname];
        [lbname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgvselect.mas_right).offset(15);
            make.top.bottom.equalTo(viewback);
        }];
        _lbname = lbname;
        
        UILabel *lbphone = [[UILabel alloc] init];
        [lbphone setTextColor:RGB(30, 30, 30)];
        [lbphone setTextAlignment:NSTextAlignmentRight];
        [lbphone setFont:[UIFont systemFontOfSize:13]];
        [viewback addSubview:lbphone];
        [lbphone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(viewback);
            make.right.equalTo(viewback).offset(-10);
        }];
        _lbphone = lbphone;
        
        UIView *viewline = [[UIView alloc] init];
        [viewline setBackgroundColor:RGB(245, 245, 245)];
        [viewback addSubview:viewline];
        [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(viewback);
            make.height.offset(1);
        }];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.isedit)
    {
        [_imgvselect setHidden:NO];
        
    }
    else
    {
        [_imgvselect setHidden:YES];
        [_lbname mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgvselect);
        }];
        
    }
    [_imgvselect setImage:[UIImage imageNamed:@"选择框"]];
    if(self.model.isselect)
    {
        [_imgvselect setImage:[UIImage imageNamed:@"选择"]];
    }
    [_lbname setText:@"系统管理员"];
    
    [_lbphone setText:@"18733742384"];
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
