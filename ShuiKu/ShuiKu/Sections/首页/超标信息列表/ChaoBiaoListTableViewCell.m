

//
//  ChaoBiaoListTableViewCell.m
//  ShuiKu
//
//  Created by Mac on 2020/7/27.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ChaoBiaoListTableViewCell.h"


@interface ChaoBiaoListTableViewCell ()

@property (nonatomic , strong) UILabel *lbname;
@property (nonatomic , strong) UILabel *lbcode;
@property (nonatomic , strong) UILabel *lbchinumber;



@end

@implementation ChaoBiaoListTableViewCell

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
        
        UILabel *lbcode = [[UILabel alloc] init];
        [lbcode setTextColor:RGB(153, 153, 153)];
        [lbcode setTextAlignment:NSTextAlignmentLeft];
        [lbcode setFont:[UIFont systemFontOfSize:11]];
        [viewback addSubview:lbcode];
        [lbcode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(5);
            make.top.equalTo(lbname.mas_bottom).offset(10);
        }];
        _lbcode = lbcode;
        
        UILabel *lbchi = [[UILabel alloc] init];
        [lbchi setTextColor:RGB(30, 30, 30)];
        [lbchi setTextAlignment:NSTextAlignmentRight];
        [lbchi setFont:[UIFont systemFontOfSize:12]];
        [lbchi setText:@"次"];
        [viewback addSubview:lbchi];
        [lbchi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(viewback).offset(-10);
            make.centerY.equalTo(viewback);
        }];
        
        UILabel *lbchinumber = [[UILabel alloc] init];
        [lbchinumber setTextColor:RGB(30, 30, 30)];
        [lbchinumber setTextAlignment:NSTextAlignmentRight];
        [lbchinumber setFont:[UIFont systemFontOfSize:16]];
        [viewback addSubview:lbchinumber];
        [lbchinumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lbchi.mas_left).offset(-5);
            make.centerY.equalTo(viewback);
        }];
        _lbchinumber = lbchinumber;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.lbname setText:self.model.NAME];
    
    [self.lbcode setText:self.model.CODE];
    [self.lbchinumber setText:self.model.CBCS];
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
