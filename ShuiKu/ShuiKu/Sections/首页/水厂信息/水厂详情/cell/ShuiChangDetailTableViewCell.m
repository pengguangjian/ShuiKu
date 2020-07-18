//
//  ShuiChangDetailTableViewCell.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ShuiChangDetailTableViewCell.h"



@interface ShuiChangDetailTableViewCell ()



@end

@implementation ShuiChangDetailTableViewCell

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
        
        
        UILabel *lbname = [[UILabel alloc] init];
        [lbname setTextColor:RGB(30, 30, 30)];
        [lbname setTextAlignment:NSTextAlignmentRight];
        [lbname setFont:[UIFont systemFontOfSize:13]];
        [viewback addSubview:lbname];
        [lbname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.offset(0);
            make.bottom.equalTo(viewback).offset(-5);
            make.width.equalTo(viewback).multipliedBy(0.5).offset(-10);
        }];
        self.lbname = lbname;
        
        UIView *viewright = [[UIView alloc] init];
        [viewright setBackgroundColor:RGB(214, 213, 220)];
        [viewback addSubview:viewright];
        [viewright mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(lbname);
            make.left.equalTo(lbname.mas_right).offset(10);
            make.right.equalTo(viewback).offset(-15);
        }];
        
        UILabel *lbvalue = [[UILabel alloc] init];
        [lbvalue setTextColor:RGB(30, 30, 30)];
        [lbvalue setTextAlignment:NSTextAlignmentLeft];
        [lbvalue setFont:[UIFont systemFontOfSize:13]];
        [viewright addSubview:lbvalue];
        [lbvalue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.bottom.equalTo(viewright);
            make.right.equalTo(viewright);
        }];
        self.lbvalue = lbvalue;
        
        
        UIView *viewline = [[UIView alloc] init];
        [viewline setBackgroundColor:RGB(245, 245, 245)];
        [viewback addSubview:viewline];
        [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(viewback);
            make.height.offset(0.5);
        }];
        
        
        UIView *viewline1 = [[UIView alloc] init];
        [viewline1 setBackgroundColor:RGB(245, 245, 245)];
        [viewback addSubview:viewline1];
        [viewline1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(viewback);
            make.height.offset(0.5);
            make.top.equalTo(lbname.mas_bottom);
        }];
        
        
        
    }
    return self;
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
