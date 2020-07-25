
//
//  LiShiYuJingTableViewCell.m
//  ShuiKu
//
//  Created by Mac on 2020/7/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LiShiYuJingTableViewCell.h"


@interface LiShiYuJingTableViewCell ()

@property (nonatomic , strong) UILabel *lbname;

@property (nonatomic , strong) NSMutableArray *arrallLB;

@end

@implementation LiShiYuJingTableViewCell



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
        
        _arrallLB = [NSMutableArray new];
        NSArray *arrzhuang = @[@"预警类型",@"超标值",@"预警时间",@"预警等级",@"数据状态"];
        for(int i = 0; i < arrzhuang.count; i++)
        {
            UIView *viewitem = [[UIView alloc] init];
            [viewback addSubview:viewitem];
            [viewitem mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(viewback);
                make.top.equalTo(lbname.mas_bottom).offset(20+25*i);
                make.height.offset(20);
            }];
            UILabel *lbvalue = [WYTools drawitemView:viewitem andtitle:arrzhuang[i]];
            [_arrallLB addObject:lbvalue];
        }
        
        
        
    }
    return self;
}


-(void)setModel:(YuJingNewListModel *)model
{
    [_lbname setText:[NSString stringWithFormat:@"%@(%@)",model.SWSTNM,model.SWSTCD]];
    
    UILabel *lb3 = self.arrallLB[3];
    [lb3 setTextColor:[UIColor whiteColor]];
    UIView *view3 = lb3.superview;
    
    NSString *strtype = @"";
    NSString *strchaobiao = @"";
    NSString *stryujintime = @"";
    NSString *stryujindengji = @"";
    NSString *strzhuangtai = @"";
    
    if(model.SWLEVEL.intValue == 1)
    {
        stryujindengji = @"蓝色预警";
        [view3 setBackgroundColor:[UIColor blueColor]];
    }
    else if(model.SWLEVEL.intValue == 2)
    {
        stryujindengji = @"黄色预警";
        [view3 setBackgroundColor:[UIColor yellowColor]];
    }
    else if(model.SWLEVEL.intValue == 3)
    {
        stryujindengji = @"橙色预警";
        [view3 setBackgroundColor:[UIColor orangeColor]];
    }
    else if(model.SWLEVEL.intValue == 4)
    {
        stryujindengji = @"红色预警";
        [view3 setBackgroundColor:[UIColor redColor]];
    }
    
    stryujintime = model.SWTM;
    
    ///1:流量 2:浊度 3:温度 4:pH值 5:余氯
    if([model.SWTYPE intValue] == 1)
    {
        strtype = @"流量";
        strchaobiao = [NSString stringWithFormat:@"%@m³/s",model.SWVALUE];
        
        
        
    }
    else if([model.SWTYPE intValue] == 2)
    {
        strtype = @"浊度";
        strchaobiao = [NSString stringWithFormat:@"%@NTU",model.SWVALUE];
        
    }
    else if([model.SWTYPE intValue] == 3)
    {
        strtype = @"温度";
        strchaobiao = [NSString stringWithFormat:@"%@℃",model.SWVALUE];
        
    }
    else if([model.SWTYPE intValue] == 4)
    {
        strtype = @"pH值";
        strchaobiao = [NSString stringWithFormat:@"%@ph",model.SWVALUE];
        
    }
    else if([model.SWTYPE intValue] == 5)
    {
        strtype = @"余氯";
        strchaobiao = [NSString stringWithFormat:@"%@mg/L",model.SWVALUE];
        
    }
    //1：新产生；2：已发布；3：响应中；4：已关闭； 5 已忽略；
    if(model.FLAG.intValue == 1)
    {
        strzhuangtai = @"新产生";
    }
    else if(model.FLAG.intValue == 2)
    {
        strzhuangtai = @"已发布";
    }
    else if(model.FLAG.intValue == 3)
    {
        strzhuangtai = @"响应中";
    }
    else if(model.FLAG.intValue == 4)
    {
        strzhuangtai = @"已关闭";
    }
    else if(model.FLAG.intValue == 5)
    {
        strzhuangtai = @"已忽略";
    }
    
    NSArray *arrrvalue = @[strtype,strchaobiao,stryujintime,stryujindengji,strzhuangtai];
    int i = 0;
    for(UILabel *lb in self.arrallLB)
    {
        [lb setText:arrrvalue[i]];
        i++;
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
