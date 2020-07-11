//
//  RiLiZhouCollectionViewCell.m
//  WuYeYuanGongDuan
//
//  Created by Mac on 2020/6/29.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "RiLiZhouCollectionViewCell.h"


@interface RiLiZhouCollectionViewCell ()
@property (nonatomic , retain) UILabel *lbValue;
@end


@implementation RiLiZhouCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _lbValue = [[UILabel alloc] init];
        [_lbValue setTextColor:RGB(150, 150, 150)];
        [_lbValue setTextAlignment:NSTextAlignmentCenter];
        [_lbValue setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:_lbValue];
        [_lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [_lbValue setText:_valueday==nil?@"":_valueday];
    
}

@end
