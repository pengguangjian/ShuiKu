//
//  MainMapViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/12.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MainMapViewController.h"
#import "GaoDeMapView.h"
#import "UIButton+HQCustomIcon.h"
#import "MapShaiXuanView.h"

@interface MainMapViewController ()

@property (nonatomic , strong) MapShaiXuanView *shaixuanView;

@end

@implementation MainMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setnavbt];
    
//    self.title = @"地图信息";
    [self drawtitleview];
    
    [self drawUI];
    
}

-(void)drawtitleview
{
    UIView *viewtitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    self.navigationItem.titleView = viewtitle;
    UILabel *lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    [lbtitle setTextColor:[UIColor whiteColor]];
    [lbtitle setText:@"地图信息"];
    [lbtitle setTextAlignment:NSTextAlignmentCenter];
    [lbtitle setFont:[UIFont systemFontOfSize:16]];
    [viewtitle addSubview:lbtitle];
    
    UILabel *lbsubtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 200, 20)];
    [lbsubtitle setTextColor:[UIColor whiteColor]];
    [lbsubtitle setText:@"水厂总数：33座"];
    [lbsubtitle setTextAlignment:NSTextAlignmentCenter];
    [lbsubtitle setFont:[UIFont systemFontOfSize:13]];
    [viewtitle addSubview:lbsubtitle];
    
    
    
}

//-(void)setnavbt
//{
//    UIButton* btnright = [[UIButton alloc] init];//btnLeft.backgroundColor=[UIColor redColor]
//    [btnright setImage:[UIImage imageNamed:@"地图筛选"] forState:UIControlStateNormal];
//    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnright];
//    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
//    [btnright addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
//
//}
//
//-(void)rightAction
//{
//    if(_shaixuanView==nil)
//    {
//        MapShaiXuanView *view = [[MapShaiXuanView alloc] init];
//        [self.view addSubview:view];
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            if (@available(iOS 11.0, *)) {
//                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
//                make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
//                make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
//                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
//            }else{
//                make.edges.equalTo(self.view).insets(kPaddingNav);
//            }
//        }];
//        _shaixuanView  = view;
//    }
//
//    [_shaixuanView setHidden:NO];
//
//    [_shaixuanView showView];
//
//}


-(void)drawUI
{
    GaoDeMapView *view = [[GaoDeMapView alloc] init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.edges.equalTo(self.view).insets(kPaddingNav);
        }
    }];
    
    [self drawInfo];
    
}
-(void)drawInfo
{
    UIButton *btzhengchang = [[UIButton alloc] init];
    [btzhengchang setTitle:@"正常" forState:UIControlStateNormal];
    [btzhengchang setTitleColor:[UIColor blackColor ] forState:UIControlStateNormal];
    [btzhengchang.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btzhengchang setImage:[UIImage imageNamed:@"ic_loc_blue"] forState:UIControlStateNormal];
    [self.view addSubview:btzhengchang];
    [btzhengchang mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(20);
        make.bottom.equalTo(self.view).offset(-50);
        make.size.sizeOffset(CGSizeMake(60, 30));
        
    }];
    [btzhengchang setIconInLeftWithSpacing:5];
    
    
    UIButton *btguzhang = [[UIButton alloc] init];
    [btguzhang setTitle:@"故障" forState:UIControlStateNormal];
    [btguzhang setTitleColor:[UIColor blackColor ] forState:UIControlStateNormal];
    [btguzhang.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btguzhang setImage:[UIImage imageNamed:@"ic_loc_red"] forState:UIControlStateNormal];
    [self.view addSubview:btguzhang];
    [btguzhang mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(btzhengchang.mas_right).offset(15);
        make.size.centerY.equalTo(btzhengchang);
        
    }];
    [btguzhang setIconInLeftWithSpacing:5];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
