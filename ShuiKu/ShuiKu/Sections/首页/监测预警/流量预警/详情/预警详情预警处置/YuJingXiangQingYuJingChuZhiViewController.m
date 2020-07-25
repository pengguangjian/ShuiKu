//
//  YuJingXiangQingYuJingChuZhiViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "YuJingXiangQingYuJingChuZhiViewController.h"
#import "YuJingXiangQingYuJingChuZhiView.h"

@interface YuJingXiangQingYuJingChuZhiViewController ()

@end

@implementation YuJingXiangQingYuJingChuZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预警处置";
    
    [self drawUI];
}


-(void)drawUI
{
    YuJingXiangQingYuJingChuZhiView *view = [[YuJingXiangQingYuJingChuZhiView alloc] init];
    [self.view addSubview:view];
    view.WARNING_ID = self.WARNING_ID;
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
