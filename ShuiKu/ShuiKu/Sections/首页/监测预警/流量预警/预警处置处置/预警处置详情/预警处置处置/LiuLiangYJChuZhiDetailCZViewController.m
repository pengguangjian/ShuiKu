//
//  LiuLiangYJChuZhiDetailCZViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LiuLiangYJChuZhiDetailCZViewController.h"
#import "LiuLiangYJChuZhiDetailCZView.h"

@interface LiuLiangYJChuZhiDetailCZViewController ()

@end

@implementation LiuLiangYJChuZhiDetailCZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预警处置";
    
    [self drawUI];
}


-(void)drawUI
{
    LiuLiangYJChuZhiDetailCZView *view = [[LiuLiangYJChuZhiDetailCZView alloc] init];
    view.ID = self.ID;
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
