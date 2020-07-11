//
//  ZiDingYiPeiZhiCollectionViewCell.m
//  ShuiKu
//
//  Created by Mac on 2020/7/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ZiDingYiPeiZhiCollectionViewCell.h"

@interface ZiDingYiPeiZhiCollectionViewCell ()

@property (nonatomic , strong) UIButton *btItem;

@end


@implementation ZiDingYiPeiZhiCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UIButton *btItem = [[UIButton alloc] init];
        [btItem setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self addSubview:btItem];
        [btItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self);
            make.height.width.offset(25);
        }];
        _btItem = btItem;
        [btItem addTarget:self action:@selector(btitemAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}
///状态 0无 1+ 2- 3勾
-(void)setType:(NSInteger)type
{
    _type = type;
    
    if(_type==1)
    {
        [_btItem setImage:[UIImage imageNamed:@"menu_add"] forState:UIControlStateNormal];
    }
    else if(_type==2)
    {
        [_btItem setImage:[UIImage imageNamed:@"menu_del"] forState:UIControlStateNormal];
    }
    else if(_type==3)
    {
        [_btItem setImage:[UIImage imageNamed:@"menu_select"] forState:UIControlStateNormal];
    }
    else
    {
        [_btItem setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    
    
}
///状态 0无 1+ 2- 3勾
-(void)btitemAction
{
    if(_type==1||_type==2)
    {
        self.btaction();
    }
}

@end
