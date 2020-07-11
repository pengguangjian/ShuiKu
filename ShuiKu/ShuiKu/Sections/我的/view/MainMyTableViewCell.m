//
//  MainMyTableViewCell.m
//  ShuiKu
//
//  Created by Mac on 2020/7/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MainMyTableViewCell.h"


@interface MainMyTableViewCell ()

@property (nonatomic , strong) UIImageView *imgvhd;

@property (nonatomic , strong) UILabel *lbtitle;

@end
@implementation MainMyTableViewCell

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
        
        
        UIImageView *imgvhd = [[UIImageView alloc] init];
        [imgvhd setContentMode:UIViewContentModeScaleAspectFit];
        [viewback addSubview:imgvhd];
        [imgvhd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.equalTo(viewback);
            make.width.height.offset(20);
        }];
        _imgvhd = imgvhd;
        
        UILabel *lbtitle = [[UILabel alloc] init];
        [lbtitle setTextColor:[UIColor blackColor]];
        [lbtitle setTextAlignment:NSTextAlignmentLeft];
        [lbtitle setFont:[UIFont systemFontOfSize:14]];
        [viewback addSubview:lbtitle];
        [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(viewback);
            make.left.equalTo(imgvhd.mas_right).offset(15);
        }];
        _lbtitle = lbtitle;
        
        
        UIImageView *imgvnext = [[UIImageView alloc] init];
        [imgvnext setContentMode:UIViewContentModeScaleAspectFit];
        [imgvnext setImage:[UIImage imageNamed:@"下一步"]];
        [viewback addSubview:imgvnext];
        [imgvnext mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(viewback).offset(-15);
            make.centerY.equalTo(viewback);
            make.width.height.offset(10);
        }];
        
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

-(void)setStrtitle:(NSString *)strtitle
{
    [_lbtitle setText:strtitle];
}

-(void)setImagehd:(UIImage *)imagehd
{
    [_imgvhd setImage:imagehd];
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
