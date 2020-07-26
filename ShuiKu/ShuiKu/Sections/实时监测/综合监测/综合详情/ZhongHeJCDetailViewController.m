

//
//  ZhongHeJCDetailViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ZhongHeJCDetailViewController.h"
#import "ZhongHeJCDetailDetailViewController.h"
#import "VTMagic.h"
#import "JianCeAllZheXianTuTuViewController.h"
@interface ZhongHeJCDetailViewController ()<VTMagicViewDataSource,VTMagicViewDelegate>
{
    VTMagicController *magicController;
    NSArray *menuList;
    
    NSMutableArray *arrallvc;
}

@end

@implementation ZhongHeJCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self drawUI];
}
-(void)drawUI
{
    
    arrallvc = [NSMutableArray new];
    ZhongHeJCDetailDetailViewController *vc0 = [[ZhongHeJCDetailDetailViewController alloc] init];
    vc0.strSTCD = self.strSTCD;
    vc0.model = self.model;
    [arrallvc addObject:vc0];
    
    JianCeAllZheXianTuTuViewController *vc1 = [[JianCeAllZheXianTuTuViewController alloc] init];
    vc1.strYValue = @"浊度NTU";
    vc1.strXValue = @"时间";
    vc1.strtitle = @"日统计";
    vc1.strtitle1 = @"浊度统计";
    vc1.type = 7;
    vc1.typeson = 1;
    vc1.stcd = self.strSTCD;
    vc1.arrinfo = @[@"进水浊度",@"出水浊度"];
    [arrallvc addObject:vc1];
    
    JianCeAllZheXianTuTuViewController *vc2 = [[JianCeAllZheXianTuTuViewController alloc] init];
    vc2.strYValue = @"余氯mg/L";
    vc2.strXValue = @"时间";
    vc2.strtitle = @"日统计";
    vc2.strtitle1 = @"余氯统计";
    vc2.stcd = self.strSTCD;
    vc2.type = 7;
    vc2.typeson = 2;
    vc2.arrinfo = @[@"出水余氯"];
    [arrallvc addObject:vc2];
    
    JianCeAllZheXianTuTuViewController *vc3 = [[JianCeAllZheXianTuTuViewController alloc] init];
    vc3.strYValue = @"温度℃";
    vc3.strXValue = @"时间";
    vc3.strtitle = @"日统计";
    vc3.strtitle1 = @"温度统计";
    vc3.stcd = self.strSTCD;
    vc3.type = 7;
    vc3.typeson = 3;
    vc3.arrinfo = @[@"进水温度",@"出水温度"];
    [arrallvc addObject:vc3];
    
    JianCeAllZheXianTuTuViewController *vc4 = [[JianCeAllZheXianTuTuViewController alloc] init];
    vc4.strYValue = @"PH值";
    vc4.strXValue = @"时间";
    vc4.strtitle = @"日统计";
    vc4.strtitle1 = @"PH值统计";
    vc4.type = 7;
    vc4.typeson = 4;
    vc4.stcd = self.strSTCD;
    vc4.arrinfo = @[@"进水PH值",@"出水PH值"];
    [arrallvc addObject:vc4];
    
    JianCeAllZheXianTuTuViewController *vc5 = [[JianCeAllZheXianTuTuViewController alloc] init];
    vc5.strYValue = @"瞬时流量";
    vc5.strXValue = @"时间";
    vc5.strtitle = @"日统计";
    vc5.strtitle1 = @"瞬时流量统计";
    vc5.stcd = self.strSTCD;
    vc5.type = 7;
    vc5.typeson = 5;
    vc5.arrinfo = @[@"瞬时进水流量",@"瞬时出水流量"];
    [arrallvc addObject:vc5];

    JianCeAllZheXianTuTuViewController *vc6 = [[JianCeAllZheXianTuTuViewController alloc] init];
    vc6.strYValue = @"累计流量";
    vc6.strXValue = @"时间";
    vc6.strtitle = @"日统计";
    vc6.strtitle1 = @"累计流量统计";
    vc6.stcd = self.strSTCD;
    vc6.type = 7;
    vc6.typeson = 6;
    vc6.arrinfo = @[@"累计进水流量",@"累计出水流量"];
    [arrallvc addObject:vc6];
    
    menuList = @[@{@"name":@"数据详情",
                   @"type":@"0"},
                @{@"name":@"浊度图",
                  @"type":@"1"},
                 @{@"name":@"出水余氯图",
                 @"type":@"2"},
                 @{@"name":@"温度图",
                 @"type":@"3"},
                 @{@"name":@"PH值图",
                 @"type":@"4"},
                 @{@"name":@"瞬时流量图",
                 @"type":@"5"},
                 @{@"name":@"累计流量图",
                 @"type":@"6"}];
        
        
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
