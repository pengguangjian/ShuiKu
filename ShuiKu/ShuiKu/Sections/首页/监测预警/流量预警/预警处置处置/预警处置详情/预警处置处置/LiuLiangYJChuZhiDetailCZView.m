
//
//  LiuLiangYJChuZhiDetailCZView.m
//  ShuiKu
//
//  Created by Mac on 2020/7/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LiuLiangYJChuZhiDetailCZView.h"
#import "UITextView+Placeholder.h"

#import "RenYuanXinXiViewController.h"
#import "RenYuanXinXiModel.h"
#import "LiuLiangYJDataController.h"

@interface LiuLiangYJChuZhiDetailCZView ()<RenYuanXinXiViewControllerDelegate>

@property (nonatomic , strong) UILabel *lbreyuan;

@property (nonatomic , strong) UITextView *textview;

@property (nonatomic , strong) NSString *strpeopleid;


@end

@implementation LiuLiangYJChuZhiDetailCZView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:RGB(245, 245, 245)];
        
        UIButton *btqingc = [[UIButton alloc] init];
        [btqingc.layer setMasksToBounds:YES];
        [btqingc.layer setCornerRadius:3];
        [btqingc setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:btqingc];
        [btqingc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.offset(10);
            make.right.equalTo(self).offset(-10);
            make.height.offset(50);
        }];
        _lbreyuan = [self drawItemBt:btqingc andtitle:@"选择人员"];
        [btqingc addTarget:self action:@selector(renyuanAction) forControlEvents:UIControlEventTouchUpInside];
        
        UITextView *textview = [[UITextView alloc] init];
        [textview setTextColor:RGB(30,30, 30)];
        [textview setTextAlignment:NSTextAlignmentLeft];
        [textview setFont:[UIFont systemFontOfSize:14]];
        [textview setPlaceholder:@"情况描述……"];
        [textview setBackgroundColor:[UIColor whiteColor]];
        [textview.layer setCornerRadius:3];
        [textview setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:textview];
        [textview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(btqingc);
            make.top.equalTo(btqingc.mas_bottom).offset(10);
            make.height.offset(100);
        }];
        _textview = textview;
        
        UIButton *btxinz = [[UIButton alloc] init];
        [btxinz setTitle:@"新增" forState:UIControlStateNormal];
        [btxinz setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btxinz.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btxinz setBackgroundColor:MenuColor];
        [self addSubview:btxinz];
        [btxinz mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.offset(49);
        }];
        [btxinz addTarget:self action:@selector(xinzenAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(UILabel *)drawItemBt:(UIButton *)btqingc andtitle:(NSString *)title
{
    UILabel *lbqingc = [[UILabel alloc] init];
    [lbqingc setTextColor:RGB(30,30, 30)];
    [lbqingc setTextAlignment:NSTextAlignmentLeft];
    [lbqingc setFont:[UIFont systemFontOfSize:14]];
    [lbqingc setText:title];
    [btqingc addSubview:lbqingc];
    [lbqingc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btqingc);
        make.left.offset(5);
    }];
    
    UIImageView *imgvnext = [[UIImageView alloc] init];
    [imgvnext setImage:[UIImage imageNamed:@"下一步"]];
    [imgvnext setContentMode:UIViewContentModeScaleAspectFit];
    [btqingc addSubview:imgvnext];
    [imgvnext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(18);
        make.right.equalTo(btqingc).offset(-10);
        make.centerY.equalTo(btqingc);
    }];

    
    return lbqingc;
}

///选择人员
-(void)renyuanAction
{
    RenYuanXinXiViewController *vc = [[RenYuanXinXiViewController alloc] init];
    vc.isedit = YES;
    vc.delegate = self;
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
}
///编辑时选中的人员
-(void)backSelecePeopleArr:(NSMutableArray *)arrvalue
{
    self.strpeopleid = @"";
    NSString *strtemp = @"";
    for(RenYuanXinXiModel *model in arrvalue)
    {
        if(strtemp.length==0)
        {
            strtemp = model.USER_NAME;
            self.strpeopleid = model.ID;
        }
        else
        {
            strtemp = [NSString stringWithFormat:@"%@,%@",strtemp,model.USER_NAME];
            self.strpeopleid = [NSString stringWithFormat:@"%@,%@",self.strpeopleid,model.ID];
        }
    }
    [self.lbreyuan setText:strtemp];
}
///新增
-(void)xinzenAction
{
    if(self.strpeopleid.length==0)
    {
        [WYTools showNotifyHUDwithtext:@"请选择人员" inView:self];
        return;
    }
    
    
    if(self.textview.text.length<3)
    {
        [WYTools showNotifyHUDwithtext:@"请输入描述" inView:self];
        return;
    }
    
    [LiuLiangYJDataController requestYuJingRengWuChuZhiXinZengData:self ID:self.ID handler:self.strpeopleid des:self.textview.text Callback:^(NSError *error, BOOL state, NSString *describle, id value) {
        if(state)
        {
            [WYTools showNotifyHUDwithtext:@"新增成功" inView:self.window];
            [self.viewController.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [WYTools showNotifyHUDwithtext:describle inView:self];
        }
    }];;
    
    
}
@end
