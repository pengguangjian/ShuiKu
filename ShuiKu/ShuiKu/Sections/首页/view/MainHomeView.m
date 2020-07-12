//
//  MainHomeView.m
//  ShuiKu
//
//  Created by Mac on 2020/7/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MainHomeView.h"
#import "HomeCollectionViewCell.h"
#import "CCPScrollView.h"
#import "ImagePlayerView.h"
#import "HomeJinRiYuJinView.h"
#import "HomeZhiBanTongJiView.h"
#import "ZiDingYiPeiZhiViewController.h"
#import "MainMapViewController.h"

@interface MainHomeView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView *collect;
@property (nonatomic , strong) NSMutableArray *arrTopTitle;
@property (nonatomic , strong) ImagePlayerView *imgvheader;


@end

@implementation MainHomeView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UIScrollView *scvback = [[UIScrollView alloc] init];
        [self addSubview:scvback];
        [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((kMainScreenW-60)/5, kScale * 70);
        [layout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [collect setBackgroundColor:[UIColor whiteColor]];
        [collect setDelegate:self];
        [collect setDataSource:self];
        [collect setScrollEnabled:NO];
        [scvback addSubview:collect];
        [collect mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.offset(0);
            make.height.offset(kScale * 70);
            
        }];
        [collect registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
        _collect = collect;
        [self nomoData];
        
        
        ///公告
        UIView *viewgonggao = [[UIView alloc] init];
        [viewgonggao setBackgroundColor:[UIColor whiteColor]];
        [scvback addSubview:viewgonggao];
        [viewgonggao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(collect.mas_bottom).offset(10);
            make.height.offset(40);
        }];
        [self drawGongGaoView:viewgonggao];
        
        ///banner
        ///banner
        ImagePlayerView *imgvheader = [[ImagePlayerView alloc] init];
        [imgvheader setBackgroundColor:[UIColor grayColor]];
        [scvback addSubview:imgvheader];
        [imgvheader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.right.equalTo(self);
            make.top.equalTo(viewgonggao.mas_bottom).offset(10);
            make.height.offset(80);
        }];
        _imgvheader = imgvheader;
        
        ///今日预警
        HomeJinRiYuJinView *jinriyjview = [[HomeJinRiYuJinView alloc] init];
        [scvback addSubview:jinriyjview];
        [jinriyjview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(imgvheader);
            make.top.equalTo(imgvheader.mas_bottom).offset(10);
            
        }];
        
        ///值班统计
        HomeZhiBanTongJiView *tongjiview = [[HomeZhiBanTongJiView alloc] init];
        [scvback addSubview:tongjiview];
        [tongjiview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(imgvheader);
            make.top.equalTo(jinriyjview.mas_bottom).offset(10);
        }];
        
        [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(tongjiview.mas_bottom).offset(10);
        }];
        
    }
    return self;
}

///公告
-(void)drawGongGaoView:(UIView *)view
{
    UILabel *lbgg = [[UILabel alloc] init];
    [lbgg setTextColor:MenuColor];
    [lbgg setTextAlignment:NSTextAlignmentLeft];
    [lbgg setFont:[UIFont systemFontOfSize:14]];
    [lbgg setText:@"公告"];
    [view addSubview:lbgg];
    [lbgg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.bottom.equalTo(view);
    }];
    
    CCPScrollView *ccpHotPointView = [[CCPScrollView alloc] initWithFrame:CGRectMake(66, 0, kMainScreenW-60-32, 40)];
    [view addSubview:ccpHotPointView];
    ccpHotPointView.titleFont = 12;
    ccpHotPointView.titleColor = RGB(100, 100, 100);
    ccpHotPointView.BGColor = [UIColor whiteColor];
    [ccpHotPointView clickTitleLabel:^(NSInteger index,NSString *titleString) {
        ///点击
//        [self selectNewMessageIndex:index];
    }];
    
    [ccpHotPointView setTitleArray:@[@"运行状况",@"视频监控",@"一张图",@"测站信息"]];
    
    UIImageView *imgvnext = [[UIImageView alloc] init];
    [imgvnext setImage:[UIImage imageNamed:@"下一步"]];
    [imgvnext setContentMode:UIViewContentModeScaleAspectFit];
    [view addSubview:imgvnext];
    [imgvnext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(10);
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-15);
    }];
    
}
///更新顶部
-(void)refCollect
{
    [self nomoData];
    [_collect reloadData];
}

-(void)nomoData
{
    NSArray *arrnomo = [[NSUserDefaults standardUserDefaults] objectForKey:@"hometopItemArr"];
    if(arrnomo == nil)
    {///默认数据
        _arrTopTitle = [[NSMutableArray alloc] initWithObjects:@"运行状况",@"视频监控",@"一张图",@"测站信息",@"值班统计",@"流量预警",@"实时监测", nil];
        [[NSUserDefaults standardUserDefaults] setObject:_arrTopTitle forKey:@"hometopItemArr"];
        [_arrTopTitle addObject:@"更多"];
        
    }
    else
    {
        _arrTopTitle = [[NSMutableArray alloc] initWithArray:arrnomo];
        [_arrTopTitle addObject:@"更多"];
    }
    
    
    NSInteger ilint = _arrTopTitle.count/5;
    if(_arrTopTitle.count%5!=0)
    {
        ilint+=1;
    }
    float fheight = kScale * 70;
    
    [_collect mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(fheight*ilint+10*(ilint-1));
    }];
    
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
    if(indexPath.row==_arrTopTitle.count-1)
    {///更多
        ZiDingYiPeiZhiViewController *vc = [[ZiDingYiPeiZhiViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        if([_arrTopTitle[indexPath.row] isEqualToString:@"一张图"])
        {
            UIViewController *vc = [NSClassFromString(@"MainMapViewController") new];
            
//            MainMapViewController *vc = [[MainMapViewController alloc] init];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

@end
