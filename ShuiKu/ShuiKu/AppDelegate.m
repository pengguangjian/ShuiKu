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
    
    ///
    LoginViewController *config = [[LoginViewController alloc] init];
    _nav = [[UINavigationController alloc] initWithRootViewController:config];
    [self.window setRootViewController:_nav];
    
    
    
    [[UITabBar appearance] setTranslucent:NO];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    return YES;
}


@end
