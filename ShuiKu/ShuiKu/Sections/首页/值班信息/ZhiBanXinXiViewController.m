
//
//  ZhiBanXinXiViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ZhiBanXinXiViewController.h"

#import "HomeZhiBanTongJiView.h"

@interface ZhiBanXinXiViewController ()

@end

@implementation ZhiBanXinXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"未值班信息";
    
    
    [self drawUI];
}

-(void)drawUI
{
    [self.view setBackgroundColor:RGB(245, 245, 245)];
    UIView *viewback = [[UIView alloc] init];
    [viewback setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewback];
    [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.edges.equalTo(self.view).insets(kPaddingNav);
        }
    }];
    ///值班统计
    HomeZhiBanTongJiView *tongjiview = [[HomeZhiBanTongJiView alloc] init];
    [viewback addSubview:tongjiview];
    [tongjiview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewback);
        make.top.offset(5);
    }];
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
