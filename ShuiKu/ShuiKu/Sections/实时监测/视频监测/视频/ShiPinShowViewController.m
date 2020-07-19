
//
//  ShiPinShowViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ShiPinShowViewController.h"
#import "ShiPinShowView.h"
@interface ShiPinShowViewController ()

@end

@implementation ShiPinShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"监控播放";
    
    
    ShiPinShowView *view = [[ShiPinShowView alloc] init];
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
