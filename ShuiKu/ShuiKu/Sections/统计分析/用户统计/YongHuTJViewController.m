//
//  YongHuTJViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/14.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "YongHuTJViewController.h"
#import "VTMagic.h"


@interface YongHuTJViewController ()

@end

@implementation YongHuTJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户统计";
    
    [WYTools showNotifyHUDwithtext:@"开发中" inView:self.view];
    
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
