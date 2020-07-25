

//
//  LiuLiangYJChuZhiTableViewCell.m
//  ShuiKu
//
//  Created by Mac on 2020/7/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LiuLiangYJChuZhiTableViewCell.h"


@interface LiuLiangYJChuZhiTableViewCell ()

@property (nonatomic , strong) UILabel *lbname;
@property (nonatomic , strong) UILabel *lbaddress;
@property (nonatomic , strong) NSMutableArray *arrallLB;

@end


@implementation LiuLiangYJChuZhiTableViewCell


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
        NSArray *arrzhuang = @[@"任务等级",@"任务描述",@"处理建议",@"处理人",@"任务创建时间",@"任务状态"];
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


-(void)setModel:(YuJingRengWuListModel *)model
{
    ///1 一般任务，2  事件处置，3 预警处置
    if(model.TASK_TYPE.intValue == 1)
    {
        [_lbname setText:[NSString stringWithFormat:@"一般任务(%@)",model.ID]];
    }
    else if(model.TASK_TYPE.intValue == 2)
    {
        [_lbname setText:[NSString stringWithFormat:@"事件处置(%@)",model.ID]];
    }
    else if(model.TASK_TYPE.intValue == 3)
    {
        [_lbname setText:[NSString stringWithFormat:@"预警处置(%@)",model.ID]];
    }
    
    [_lbaddress setText:model.CREATOR];
    
    
    
    UILabel *lb0 = _arrallLB[0];
    UIView *view0 = lb0.superview;
    [view0 setBackgroundColor:RGB(21, 81, 211)];
    ///TASK_LEVEL  1 一般; 2 较急; 3 紧急; 4 特急
    if(model.TASK_TYPE.intValue==1)
    {
        [lb0 setText:@"一般"];
        [view0 setBackgroundColor:MenuColor];
    }
    else if(model.TASK_TYPE.intValue==2)
    {
        [lb0 setText:@"较急"];
        [view0 setBackgroundColor:[UIColor brownColor]];
    }
    else if(model.TASK_TYPE.intValue==3)
    {
        [lb0 setText:@"紧急"];
        [view0 setBackgroundColor:[UIColor yellowColor]];
    }
    else if(model.TASK_TYPE.intValue==4)
    {
        [lb0 setText:@"特急"];
        [view0 setBackgroundColor:[UIColor redColor]];
    }
    
    UILabel *lb1 = _arrallLB[1];
    [lb1 setText:model.DESCRIPTION];
    
    UILabel *lb2 = _arrallLB[2];
    [lb2 setText:model.SUGGEST];
    
    
    UILabel *lb3 = _arrallLB[3];
    [lb3 setText:model.HANDLER];
    
    UILabel *lb4 = _arrallLB[4];
    [lb4 setText:model.CREATEDTIME];
    
    UILabel *lb5 = _arrallLB[5];
    ///0正在处置 1：处置完成
    if(model.STATUS.intValue == 1)
    {
        [lb5 setText:@"处置完成"];
    }
    else
    {
        [lb5 setText:@"正在处置"];
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
