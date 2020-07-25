//
//  YuJingXiangQingYuJingChuZhiView.m
//  ShuiKu
//
//  Created by Mac on 2020/7/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "YuJingXiangQingYuJingChuZhiView.h"
#import "UITextView+Placeholder.h"

#import "RenYuanXinXiViewController.h"
#import "AlterListView.h"

#import "RenYuanXinXiModel.h"
#import "LiuLiangYJDataController.h"

@interface YuJingXiangQingYuJingChuZhiView ()<RenYuanXinXiViewControllerDelegate,AlterListViewDelegate>

@property (nonatomic , strong) UIView *viewpeoplenumber;
@property (nonatomic , strong) UILabel *lbreyuan;
@property (nonatomic , strong) UIButton *btshifouduanxin;
///任务紧急程度
@property (nonatomic , strong) UILabel *lbdengji;
///
@property (nonatomic , assign) int type;

@property (nonatomic , strong)UITextView *textview;
@property (nonatomic , strong)UITextView *textviewjy;
///处置人ID
@property (nonatomic , strong) NSString *strpeopleid;
@property (nonatomic , strong) NSMutableArray *arrpeoples;
@end

@implementation YuJingXiangQingYuJingChuZhiView


-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.type = -1;
        [self setBackgroundColor:RGB(245, 245, 245)];
        
        UIView *viewpeople = [[UIView alloc] init];
        [viewpeople.layer setMasksToBounds:YES];
        [viewpeople.layer setCornerRadius:3];
        [viewpeople setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:viewpeople];
        [viewpeople mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.offset(10);
            make.right.equalTo(self).offset(-10);
            make.height.offset(120);
        }];
        
        UIButton *btqingc = [[UIButton alloc] init];
        [viewpeople addSubview:btqingc];
        [btqingc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(viewpeople);
            make.height.offset(50);
        }];
        _lbreyuan = [self drawItemBt:btqingc andtitle:@"选择人员"];
        [btqingc addTarget:self action:@selector(renyuanAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *viewpeoplenumber = [[UIView alloc] init];
        [viewpeople addSubview:viewpeoplenumber];
        [viewpeoplenumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(viewpeople);
            make.top.equalTo(btqingc.mas_bottom);
            make.height.offset(40);
        }];
        _viewpeoplenumber = viewpeoplenumber;
        
        UIButton *btshifouduanxin = [[UIButton alloc] init];
        [btshifouduanxin setImage:[UIImage imageNamed:@"选择框"] forState:UIControlStateNormal];
        [btshifouduanxin setImage:[UIImage imageNamed:@"选择"] forState:UIControlStateSelected];
        [btshifouduanxin setTitle:@"是否短信通知" forState:UIControlStateNormal];
        [btshifouduanxin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btshifouduanxin.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [viewpeople addSubview:btshifouduanxin];
        [btshifouduanxin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.equalTo(viewpeoplenumber.mas_bottom);
            make.height.offset(30);
        }];
        [btshifouduanxin addTarget:self action:@selector(duanxinAction) forControlEvents:UIControlEventTouchUpInside];
        _btshifouduanxin = btshifouduanxin;
        
        
        UIButton *btdengji = [[UIButton alloc] init];
        [btdengji.layer setMasksToBounds:YES];
        [btdengji.layer setCornerRadius:3];
        [btdengji setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:btdengji];
        [btdengji mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(viewpeople);
            make.top.equalTo(viewpeople.mas_bottom).offset(10);
            make.height.offset(50);
        }];
        [self drawItemBt:btdengji andtitle:@"任务紧急程度"];
        [btdengji addTarget:self action:@selector(dengjiAction) forControlEvents:UIControlEventTouchUpInside];
        UILabel *lbqingc = [[UILabel alloc] init];
        [lbqingc setTextColor:RGB(30,30, 30)];
        [lbqingc setTextAlignment:NSTextAlignmentRight];
        [lbqingc setFont:[UIFont systemFontOfSize:13]];
        [lbqingc setText:@"请选择"];
        [btdengji addSubview:lbqingc];
        [lbqingc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(btdengji);
            make.right.equalTo(btdengji.mas_right).offset(-30);
        }];
        _lbdengji = lbqingc;
        
        
        
        UITextView *textview = [[UITextView alloc] init];
        [textview setTextColor:RGB(30,30, 30)];
        [textview setTextAlignment:NSTextAlignmentLeft];
        [textview setFont:[UIFont systemFontOfSize:14]];
        [textview setPlaceholder:@"任务描述……"];
        [textview setBackgroundColor:[UIColor whiteColor]];
        [textview.layer setCornerRadius:3];
        [textview setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:textview];
        [textview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(btqingc);
            make.top.equalTo(btdengji.mas_bottom).offset(10);
            make.height.offset(100);
        }];
        _textview = textview;
        
        UITextView *textviewjy = [[UITextView alloc] init];
        [textviewjy setTextColor:RGB(30,30, 30)];
        [textviewjy setTextAlignment:NSTextAlignmentLeft];
        [textviewjy setFont:[UIFont systemFontOfSize:14]];
        [textviewjy setPlaceholder:@"处置建议……"];
        [textviewjy setBackgroundColor:[UIColor whiteColor]];
        [textviewjy.layer setCornerRadius:3];
        [textviewjy setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:textviewjy];
        [textviewjy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(btqingc);
            make.top.equalTo(textview.mas_bottom).offset(10);
            make.height.offset(100);
        }];
        _textviewjy = textviewjy;
        
        
        UIButton *btxinz = [[UIButton alloc] init];
        [btxinz setTitle:@"立即发布" forState:UIControlStateNormal];
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

-(void)drawPeoPleView:(NSMutableArray *)arrvalue
{
    [_viewpeoplenumber removeAllSubviews];
    int i =0;
    for(RenYuanXinXiModel *model in arrvalue)
    {
        UIButton *btitem = [[UIButton alloc] init];
        [btitem setTitle:model.USER_NAME forState:UIControlStateNormal];
        [btitem setBackgroundColor:MenuColor];
        [btitem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btitem.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [btitem.layer setMasksToBounds:YES];
        [btitem.layer setCornerRadius:3];
        [btitem setTag:i];
        [_viewpeoplenumber addSubview:btitem];
        [btitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10+75*i);
            make.height.offset(30);
            make.width.offset(70);
            make.centerY.equalTo(self.viewpeoplenumber);
        }];
        [btitem addTarget:self action:@selector(itemUserAction:) forControlEvents:UIControlEventTouchUpInside];
        i++;
    }
    
}

-(void)itemUserAction:(UIButton *)sender
{
    
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否移除该用户" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.arrpeoples removeObjectAtIndex:sender.tag];
        [self backSelecePeopleArr:self.arrpeoples];
        
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alter addAction:action];
    [alter addAction:action1];
    
    [self.viewController presentViewController:alter animated:YES completion:nil];
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
    self.arrpeoples = arrvalue;
    self.strpeopleid = @"";
    for(RenYuanXinXiModel *model in arrvalue)
    {
        if(self.strpeopleid.length==0)
        {
            self.strpeopleid = model.ID;
        }
        else
        {
            self.strpeopleid = [NSString stringWithFormat:@"%@,%@",self.strpeopleid,model.ID];
        }
    }
    
    [self drawPeoPleView:arrvalue];
    
}

//短信
-(void)duanxinAction
{
    self.btshifouduanxin.selected = !self.btshifouduanxin.selected;
}
///新增
-(void)xinzenAction
{
    if(self.strpeopleid.length<1)
    {
        [WYTools showNotifyHUDwithtext:@"请选择人员" inView:self];
        return;
    }
    if(self.type<0)
    {
        [WYTools showNotifyHUDwithtext:@"请选择任务紧急程度" inView:self];
        return;
    }
    if(self.textview.text.length<1)
    {
        [WYTools showNotifyHUDwithtext:@"请输入任务描述" inView:self];
        return;
    }
    
    NSString *strnotice = @"0";
    if(self.btshifouduanxin.isSelected)
    {
        strnotice = @"1";
    }
    
    [LiuLiangYJDataController requestChuZhiYuJinGGData:self.viewpeoplenumber SUGGEST:[self.textviewjy.text stringByURLEncode] HANDLER_ID:self.strpeopleid NOTICE:strnotice DESCRIPTION:[self.textview.text stringByURLEncode] WARNING_ID:self.WARNING_ID TASK_LEVEL:[NSString stringWithFormat:@"%d",self.type] Callback:^(NSError *error, BOOL state, NSString *describle, id value) {
        if(state)
        {
            [WYTools showNotifyHUDwithtext:@"处置成功" inView:self.window];
            NSArray *arrvc = self.viewController.navigationController.viewControllers;
            UIViewController *vc = arrvc[1];
            [self.viewController.navigationController popToViewController:vc animated:YES];
            
        }
        else
        {
            [WYTools showNotifyHUDwithtext:describle inView:self];
        }
    }];
    
}
///等级
-(void)dengjiAction
{
    AlterListView *view = [[AlterListView alloc] init];
    [self.viewController.view.window addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.width.offset(kMainScreenW);
        make.height.offset(kMainScreenH);
    }];
    [view setDelegate:self];
    [view setStrtitle:@"任务紧急程度"];
    [view setArrdata:@[@"一般",@"较急",@"紧急",@"特急"]];
}

-(void)ListAlterViewItemSelect:(id)value andviewtag:(NSInteger)tag
{
    NSArray *arrtitle = @[@"一般",@"较急",@"紧急",@"特急"];
    
    for(int i = 0 ; i < arrtitle.count; i++)
    {
        if([value isEqualToString:arrtitle[i]])
        {
            self.type = i;
        }
    }
    [self.lbdengji setText:arrtitle[self.type]];
}


@end
