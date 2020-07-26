
//
//  YuLvJCDetailViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "YuLvJCDetailViewController.h"
#import "YuLvJCDetailDetailViewController.h"
#import "VTMagic.h"

#import "JianCeAllZheXianTuTuViewController.h"

@interface YuLvJCDetailViewController ()<VTMagicViewDataSource,VTMagicViewDelegate>
{
    VTMagicController *magicController;
    NSArray *menuList;
    
    NSMutableArray *arrallvc;
    
}

@end

@implementation YuLvJCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self drawUI];
}
-(void)drawUI
{
    arrallvc = [NSMutableArray new];
    YuLvJCDetailDetailViewController *vc0 = [[YuLvJCDetailDetailViewController alloc] init];
    vc0.strSTCD = self.strSTCD;
    [arrallvc addObject:vc0];
    
    JianCeAllZheXianTuTuViewController *vc1 = [[JianCeAllZheXianTuTuViewController alloc] init];
    vc1.strYValue = @"余氯mg/L";
    vc1.strXValue = @"时间";
    vc1.strtitle = @"日统计";
    vc1.strtitle1 = @"余氯统计";
    vc1.stcd = self.strSTCD;
    vc1.type = 3;
    vc1.typeson = 2;
    vc1.arrinfo = @[@"出水余氯"];
    [arrallvc addObject:vc1];
    
    menuList = @[@{@"name":@"数据详情",
                   @"type":@"0"},
                @{@"name":@"出水余氯图",
                  @"type":@"1"}];
        
        
    magicController = [[VTMagicController alloc] init];
    magicController.view.translatesAutoresizingMaskIntoConstraints = NO;
    magicController.magicView.sliderColor = MenuColor;
    magicController.magicView.itemScale = 1;
    magicController.magicView.itemSpacing = 40;
    magicController.magicView.navigationColor = [UIColor whiteColor];
    magicController.magicView.layoutStyle = VTLayoutStyleDivide;
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
        if (dict[@"name"]) {
            [titles addObject:dict[@"name"]];
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
        menuItem.titleLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {

    return arrallvc[pageIndex];
}



@end
