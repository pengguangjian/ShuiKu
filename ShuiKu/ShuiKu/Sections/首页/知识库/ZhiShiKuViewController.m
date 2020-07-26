
//
//  ZhiShiKuViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ZhiShiKuViewController.h"
#import "ZhiShiKuTableViewController.h"
#import "VTMagic.h"
#import "ZhiShiKuDataController.h"

@interface ZhiShiKuViewController ()<VTMagicViewDataSource,VTMagicViewDelegate>
{
    VTMagicController *magicController;
    NSArray *menuList;
}

@end

@implementation ZhiShiKuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"知识库";
    
    [self getdata];
}
-(void)getdata
{
    [ZhiShiKuDataController requestZhiShiKuFenLeiData:self.view Callback:^(NSError *error, BOOL state, NSString *describle, NSArray *value) {
        if(state)
        {
            self->menuList = value;
            [self drawUI];
        }
        else
        {
            [WYTools showNotifyHUDwithtext:describle inView:self.view];
        }
    }];
    
}
-(void)drawUI
{
        
        
    magicController = [[VTMagicController alloc] init];
    magicController.view.translatesAutoresizingMaskIntoConstraints = NO;
    magicController.magicView.sliderColor = MenuColor;
    magicController.magicView.itemScale = 1;
    magicController.magicView.itemSpacing = 40;
    magicController.magicView.navigationColor = [UIColor whiteColor];
    magicController.magicView.layoutStyle = VTLayoutStyleDefault;
    magicController.magicView.switchStyle = VTSwitchStyleStiff;
    magicController.magicView.navigationHeight = 50.f;
    magicController.magicView.dataSource = self;
    magicController.magicView.delegate = self;
    magicController.magicView.sliderWidth = 50;
    magicController.magicView.separatorHidden = YES;
    
    [self addChildViewController:magicController];
    [self.view addSubview:magicController.view];
    [magicController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.edges.equalTo(self.view).insets(kPaddingNav);
        }
    }];
    [magicController.magicView reloadData];
    
}

#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSMutableArray *titles = [NSMutableArray array];
    for (NSDictionary *dict in menuList) {
        if (dict[@"NAME"]) {
            [titles addObject:dict[@"NAME"]];
        }
    }
    return titles.mutableCopy;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:RGBCOLOR(10, 10, 10) forState:UIControlStateNormal];
        [menuItem setTitleColor:MenuColor forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont systemFontOfSize:13.f];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    static NSString *gridId = @"ZhiShiKuTableViewController";
    ZhiShiKuTableViewController *viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
    if (!viewController) {
        viewController = [[ZhiShiKuTableViewController alloc] init];
    }
    
    viewController.ID = [NSString nullToString:[menuList[pageIndex] objectForKey:@"ID"]];
    [viewController getData];
    return viewController;
}




@end
