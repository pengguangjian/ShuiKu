//
//  PHZhiJCDetailViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "PHZhiJCDetailViewController.h"
#import "PHZhiJCDetailDetailViewController.h"
#import "VTMagic.h"
#import "JianCeAllZheXianTuTuViewController.h"
@interface PHZhiJCDetailViewController ()<VTMagicViewDataSource,VTMagicViewDelegate>
{
    VTMagicController *magicController;
    NSArray *menuList;
    
    NSMutableArray *arrallvc;
    
}

@end

@implementation PHZhiJCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self drawUI];
}
-(void)drawUI
{
    arrallvc = [NSMutableArray new];
    PHZhiJCDetailDetailViewController *vc0 = [[PHZhiJCDetailDetailViewController alloc] init];
    vc0.strSTCD = self.strSTCD;
    [arrallvc addObject:vc0];
    
    JianCeAllZheXianTuTuViewController *vc1 = [[JianCeAllZheXianTuTuViewController alloc] init];
    vc1.strYValue = @"PH";
    vc1.strXValue = @"时间";
    vc1.strtitle = @"日统计";
    vc1.strtitle1 = @"PH统计";
    vc1.stcd = self.strSTCD;
    vc1.type = 5;
    vc1.typeson = 4;
    vc1.arrinfo = @[@"进水PH",@"出水PH"];
    [arrallvc addObject:vc1];
    
    menuList = @[@{@"name":@"数据详情",
                   @"type":@"0"},
                @{@"name":@"PH值图",
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
