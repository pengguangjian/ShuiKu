//
//  HomeCollectionViewCell.m
//  WuYeYuanGongDuan
//
//  Created by Mac on 2020/6/24.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@interface HomeCollectionViewCell ()
{
    UIImageView *imgvHead;
    UILabel *lbname;
}
@end

@implementation HomeCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UIView *viewback = [[UIView alloc] init];
        [viewback setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:viewback];
        [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UIImageView *imgv = [[UIImageView alloc] init];
        [imgv setContentMode:UIViewContentModeScaleAspectFit];
        [viewback addSubview:imgv];
        [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(viewback);
            make.height.width.equalTo(viewback.mas_height).multipliedBy(0.35);
            make.top.offset(15);
        }];
        imgvHead = imgv;
        
        
        UILabel *lb = [[UILabel alloc] init];
        [lb setTextColor:RGB(30, 30, 30)];
        [lb setTextAlignment:NSTextAlignmentCenter];
        [lb setFont:[UIFont systemFontOfSize:12]];
        [viewback addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(viewback);
            make.top.equalTo(imgv.mas_bottom).offset(4);
        }];
        lbname = lb;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

-(void)setImage:(UIImage *)image
{
    [imgvHead setImage:image];
}

-(void)setStrname:(NSString *)strname
{
    [lbname setText:strname];
}


@end
