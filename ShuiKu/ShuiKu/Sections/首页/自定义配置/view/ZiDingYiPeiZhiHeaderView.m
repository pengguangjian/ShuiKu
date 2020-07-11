
//
//  ZiDingYiPeiZhiHeaderView.m
//  ShuiKu
//
//  Created by Mac on 2020/7/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ZiDingYiPeiZhiHeaderView.h"

@implementation ZiDingYiPeiZhiHeaderView
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *lbname = [[UILabel alloc] init];
        [lbname setTextColor:RGB(50, 50, 50)];
        [lbname setTextAlignment:NSTextAlignmentLeft];
        [lbname setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:lbname];
        [lbname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.top.bottom.equalTo(self);
        }];
        _lbname = lbname;
        
        UILabel *lbcontent = [[UILabel alloc] init];
        [lbcontent setTextColor:RGB(150, 150, 150)];
        [lbcontent setTextAlignment:NSTextAlignmentLeft];
        [lbcontent setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:lbcontent];
        [lbcontent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbname.mas_right).offset(15);
            make.top.bottom.equalTo(self);
        }];
        _lbcontent = lbcontent;
        
        
    }
    return self;
}

@end
