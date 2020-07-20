//
//  AppDelegate.m
//  ShuiKu
//
//  Created by Mac on 2020/7/10.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "PGGTabBarViewControllerConfig.h"
#import "TabBarControllerConfig.h"

@class PGGBaseNavigationController;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    if (@available(iOS 13.0, *)) {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDarkContent];
    } else {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOutNotif) name:@"kNetworkWairningOnload" object:nil];///退出登录
    
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"userislogin"] intValue] ==1)
    {
        TabBarControllerConfig *vc  = [[TabBarControllerConfig alloc] init];
        [self.window setRootViewController:vc.tabBarController];
    }
    else
    {
        ///
        LoginViewController *config = [[LoginViewController alloc] init];
        _nav = [[UINavigationController alloc] initWithRootViewController:config];
        [self.window setRootViewController:_nav];
    }
    
    [[UITabBar appearance] setTranslucent:NO];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    return YES;
}

-(void)loginOutNotif
{
    [[UserInfoModel sharedUserInfo] loginOut];
    LoginViewController *config = [[LoginViewController alloc] init];
    _nav = [[UINavigationController alloc] initWithRootViewController:config];
    [self.window setRootViewController:_nav];
    
}

//此方法会在设备横竖屏变化的时候调用
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    
    //   NSLog(@"方向  =============   %ld", _allowRotate);
    if (_allowRotate == 1) {
        return UIInterfaceOrientationMaskAll;
    }else{
        return (UIInterfaceOrientationMaskPortrait);
    }
}


// 返回是否支持设备自动旋转
- (BOOL)shouldAutorotate
{
    if (_allowRotate == 1) {
        return YES;
    }
    return NO;
}

@end
