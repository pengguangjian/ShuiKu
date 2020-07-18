
//
//  YuLvTJListTableViewCell.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "YuLvTJListTableViewCell.h"


@interface YuLvTJListTableViewCell ()
@property (nonatomic , strong) NSMutableArray *arrallLB;
@end

@implementation YuLvTJListTableViewCell


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
            make.left.offset(2);
            make.top.offset(0);
            make.right.equalTo(self).offset(-2);
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
        
        self.arrallLB = [NSMutableArray new];
        float fitemw = (kMainScreenW-44)/3;
        for(int i = 0; i < 3; i++)
        {
            UILabel *lbtitle = [[UILabel alloc] init];
            [lbtitle setTextColor:RGB(30, 30, 30)];
            [lbtitle setTextAlignment:NSTextAlignmentLeft];
            [lbtitle setFont:[UIFont systemFontOfSize:11]];
            [lbtitle setNumberOfLines:3];
            [viewback addSubview:lbtitle];
            [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(viewback);
                make.left.offset(10+(10+fitemw)*i);
                make.width.offset(fitemw);
            }];
            [self.arrallLB addObject:lbtitle];
        }
        
    }
    return self;
}

-(void)setStrvalue:(NSString *)strvalue
{
    UILabel *lb0 = _arrallLB[0];
    [lb0 setText:@"2020-07-18"];
    
    UILabel *lb1 = _arrallLB[1];
    [lb1 setText:@"7433.0"];
    
    UILabel *lb2 = _arrallLB[2];
    [lb2 setText:@"7433.0"];
    
    
    
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
