//
//  MainShiShiJianCeViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MainShiShiJianCeViewController.h"
#import "HomeCollectionViewCell.h"
#import "ZhuoDuJianCeViewController.h"

@interface MainShiShiJianCeViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView *collect;

@property (nonatomic , strong) NSMutableArray *arrTopTitle;

@end

@implementation MainShiShiJianCeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实时监测";
    
    [self drawUI];
}

-(void)drawUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((kMainScreenW-60)/3, kScale * 90);
    [layout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [collect setBackgroundColor:[UIColor whiteColor]];
    [collect setDelegate:self];
    [collect setDataSource:self];
    [self.view addSubview:collect];
    [collect mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.edges.equalTo(self.view).insets(kPaddingNav);
        }
        
    }];
    [collect registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
    _collect = collect;
    
    _arrTopTitle = [[NSMutableArray alloc] initWithObjects:@"流量监测",@"浊度监测",@"余氯监测",@"温度监测",@"PH值监测",@"水质监测",@"综合监测", nil];
    
    
}

#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrTopTitle.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    cell.strname = _arrTopTitle[indexPath.row];
    cell.image = [UIImage imageNamed:_arrTopTitle[indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    @"流量监测",@"浊度监测",@"余氯监测",@"温度监测",@"PH值监测",@"水质监测",@"综合监测",
    NSArray *arrVC = @[@"LiuLiangJCViewController",@"ZhuoDuJianCeViewController",@"YuLvJCViewController",@"WenDuJCViewController",@"PHZhiJCViewController",@"ShuiZhiJCViewController",@"ZhongHeJCViewController"];
    UIViewController *vc = [NSClassFromString(arrVC[indexPath.row]) new];
    [self.navigationController pushViewController:vc animated:YES];
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
