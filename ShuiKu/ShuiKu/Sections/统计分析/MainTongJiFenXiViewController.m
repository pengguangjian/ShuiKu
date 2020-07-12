//
//  MainTongJiFenXiViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MainTongJiFenXiViewController.h"
#import "HomeCollectionViewCell.h"

#import "LiuLiangJianCeTongJiViewController.h"
#import "CeZhanJianCeTongJiViewController.h"

@interface MainTongJiFenXiViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView *collect;

@property (nonatomic , strong) NSMutableArray *arrTopTitle;

@end

@implementation MainTongJiFenXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"统计分析";
    
   [self drawUI];
}

-(void)drawUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((kMainScreenW-20)/3, kScale * 90);
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
    
    _arrTopTitle = [[NSMutableArray alloc] initWithObjects:@"流量监测统计",@"生态流量监测统计",@"雨量监测统计",@"水位监测统计",@"测站监测统计",@"用户统计",@"用水收费记录",@"监测预警统计",@"浊度统计",@"余氯统计",@"PH值统计",@"温度统计", nil];
    
    
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
//    LiuLiangJianCeTongJiViewController *vc = [[LiuLiangJianCeTongJiViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    CeZhanJianCeTongJiViewController *vc = [[CeZhanJianCeTongJiViewController alloc] init];
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
