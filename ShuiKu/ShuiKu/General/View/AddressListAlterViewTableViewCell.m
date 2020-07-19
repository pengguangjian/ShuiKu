//
//  AddressListAlterViewTableViewCell.m
//  ZHProperty
//
//  Created by Mac on 2020/7/16.
//  Copyright © 2020 yx. All rights reserved.
//

#import "AddressListAlterViewTableViewCell.h"

@interface AddressListAlterViewTableViewCell ()

@property (nonatomic , strong) UILabel *lbname;

@end

@implementation AddressListAlterViewTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UILabel *lbname = [[UILabel alloc] init];
        [lbname setTextColor:[UIColor blackColor]];
        [lbname setTextAlignment:NSTextAlignmentLeft];
        [lbname setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:lbname];
        [lbname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.bottom.equalTo(self);
        }];
        _lbname = lbname;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_lbname setText:_strvalue];
    if(self.isselect)
    {
        [_lbname setTextColor:[UIColor redColor]];
    }
    else
    {
        [_lbname setTextColor:[UIColor blackColor]];
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
