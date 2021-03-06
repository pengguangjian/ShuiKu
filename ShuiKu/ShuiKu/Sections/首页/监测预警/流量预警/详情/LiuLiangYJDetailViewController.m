
//
//  LiuLiangYJDetailViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LiuLiangYJDetailViewController.h"
#import "LiuLiangYJDetailView.h"
#import "YuJingNewListModel.h"
@interface LiuLiangYJDetailViewController ()

@end

@implementation LiuLiangYJDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@预警详情",self.model.SWSTNM];
    
    [self drawUI];
    
}

-(void)drawUI
{
    LiuLiangYJDetailView *view = [[LiuLiangYJDetailView alloc] init];
    view.model = self.model;
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
    
}

@end
