

//
//  LiuLiangYJTableViewCell.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LiuLiangYJTableViewCell.h"


@interface LiuLiangYJTableViewCell ()

@property (nonatomic , strong) UILabel *lbname;
@property (nonatomic , strong) UILabel *lbaddress;
@property (nonatomic , strong) NSMutableArray *arrallLB;

@end
@implementation LiuLiangYJTableViewCell

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
        
        UILabel *lbaddress = [[UILabel alloc] init];
        [lbaddress setTextColor:RGB(130, 130, 130)];
        [lbaddress setTextAlignment:NSTextAlignmentLeft];
        [lbaddress setFont:[UIFont systemFontOfSize:11]];
        [viewback addSubview:lbaddress];
        [lbaddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbname);
            make.top.equalTo(lbname.mas_bottom).offset(5);
        }];
        _lbaddress = lbaddress;
        
        _arrallLB = [NSMutableArray new];
        NSArray *arrzhuang = @[@"预警类型",@"超标值",@"预警阀值",@"预警时间",@"预警等级",@"数据状态"];
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
    UILabel *lb4 = _arrallLB[4];
    [lb4 setTextColor:[UIColor whiteColor]];
    UIView *view4 = lb4.superview;
    
    
    NSString *strtype = @"";
    NSString *strchaobiao = @"";
    NSString *stryujinfz = @"";
    NSString *stryujintime = @"";
    NSString *stryujindengji = @"";
    NSString *strzhuangtai = @"";
    
    if(model.SWLEVEL.intValue == 1)
    {
        stryujindengji = @"蓝色预警";
        [view4 setBackgroundColor:[UIColor blueColor]];
    }
    else if(model.SWLEVEL.intValue == 2)
    {
        stryujindengji = @"黄色预警";
        [view4 setBackgroundColor:[UIColor yellowColor]];
    }
    else if(model.SWLEVEL.intValue == 3)
    {
        stryujindengji = @"橙色预警";
        [view4 setBackgroundColor:[UIColor orangeColor]];
    }
    else if(model.SWLEVEL.intValue == 4)
    {
        stryujindengji = @"红色预警";
        [view4 setBackgroundColor:[UIColor redColor]];
    }
    
    stryujintime = model.SWTM;
    
    ///1:流量 2:浊度 3:温度 4:pH值 5:余氯
    if([model.SWTYPE intValue] == 1)
    {
        strtype = @"流量";
        strchaobiao = [NSString stringWithFormat:@"%@m³/s",model.SWVALUE];
        stryujinfz = [NSString stringWithFormat:@"%@m³/s",model.SWINDEX];
        
        
    }
    else if([model.SWTYPE intValue] == 2)
    {
        strtype = @"浊度";
        strchaobiao = [NSString stringWithFormat:@"%@NTU",model.SWVALUE];
        stryujinfz = [NSString stringWithFormat:@"%@NTU",model.SWINDEX];
    }
    else if([model.SWTYPE intValue] == 3)
    {
        strtype = @"温度";
        strchaobiao = [NSString stringWithFormat:@"%@℃",model.SWVALUE];
        stryujinfz = [NSString stringWithFormat:@"%@℃",model.SWINDEX];
    }
    else if([model.SWTYPE intValue] == 4)
    {
        strtype = @"pH值";
        strchaobiao = [NSString stringWithFormat:@"%@ph",model.SWVALUE];
        stryujinfz = [NSString stringWithFormat:@"%@ph",model.SWINDEX];
    }
    else if([model.SWTYPE intValue] == 5)
    {
        strtype = @"余氯";
        strchaobiao = [NSString stringWithFormat:@"%@mg/L",model.SWVALUE];
        stryujinfz = [NSString stringWithFormat:@"%@mg/L",model.SWINDEX];
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
    
    NSArray *arrrvalue = @[strtype,strchaobiao,stryujinfz,stryujintime,stryujindengji,strzhuangtai];
    int i = 0;
    for(UILabel *lb in self.arrallLB)
    {
        [lb setText:arrrvalue[i]];
        i++;
    }
    
    [_lbname setText:[NSString stringWithFormat:@"%@(%@)",model.SWSTNM,model.SWSTCD]];
    [_lbaddress setText:model.NAME];
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
