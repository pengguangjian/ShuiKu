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
#import "XiaoXiGongGaoViewController.h"

#import "MainHomeDataController.h"


@interface MainHomeView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView *collect;
@property (nonatomic , strong) NSMutableArray *arrTopTitle;
@property (nonatomic , strong) ImagePlayerView *imgvheader;


///通知公告
@property (nonatomic , strong) CCPScrollView *ccpHotPointView;
@property (nonatomic , strong) NSMutableArray *arrtongzhigonggao;



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
        
        [self getData];
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
        NSDictionary *dicitem = self.arrtongzhigonggao[index];
        
        XiaoXiGongGaoViewController *vc = [[XiaoXiGongGaoViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }];
    _ccpHotPointView = ccpHotPointView;
    
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
        _arrTopTitle = [[NSMutableArray alloc] initWithObjects:@"视频监测",@"一张图",@"测站信息",@"流量预警", nil];
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

-(void)getData
{
    [MainHomeDataController requestTongZhiGongGGData:self Callback:^(NSError *error, BOOL state, NSString *describle, NSDictionary *value) {
        
        self.arrtongzhigonggao = (NSMutableArray *)[value objectForKey:@"rows"];
        NSMutableArray *arrtitlegg = [NSMutableArray new];
        for(NSDictionary *dicitem in self.arrtongzhigonggao)
        {
            [arrtitlegg addObject:[NSString nullToString:[dicitem objectForKey:@"NISUMMARY"]]];
        }
        if(arrtitlegg.count>0)
        {
            [self.ccpHotPointView setTitleArray:arrtitlegg];
        }
        
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
    NSArray *arr1 = @[@"流量监测",@"浊度监测",@"余氯监测",@"温度监测",@"PH值监测",@"视频监测",@"水质监测",@"综合监测",@"一张图"];
    NSArray *arr2 = @[@"水质分析",@"流量分析",@"测点分析",@"预警分析",@"水费统计",@"用水户统计"];
    NSArray *arr3 = @[@"流量预警",@"浊度预警",@"余氯预警",@"PH值预警",@"温度预警"];
    NSArray *arr4 = @[@"水厂信息",@"测站信息",@"人员信息"];
    NSArray *arr5 = @[@"值班信息",@"知识库"];
    NSArray *arrvc1 = @[@"LiuLiangJCViewController",@"ZhuoDuJianCeViewController",@"YuLvJCViewController",@"WenDuJCViewController",@"PHZhiJCViewController",@"ShiPinJCViewController",@"ShuiZhiJCViewController",@"ZhongHeJCViewController",@"MainMapViewController"];
    NSArray *arrvc2 = @[@"ZhuoDuTJViewController",@"LiuLiangJianCeTongJiViewController",@"CeZhanJianCeTongJiViewController",@"JianCeYuJinTJViewController",@"YongShuiShouFeiTJViewController",@"YongHuTJViewController"];
    NSArray *arrvc3 = @[@"LiuLiangYJViewController",@"LiuLiangYJViewController",@"LiuLiangYJViewController",@"LiuLiangYJViewController",@"LiuLiangYJViewController"];
    ////@[@"LiuLiangYJViewController",@"ZhuoDuYJViewController",@"YuLvYJViewController",@"PHZhiYJViewController",@"WenDuYJViewController"];
    NSArray *arrvc4 = @[@"ShuiChangXinXiTableViewController",@"CeZhanXinXiViewController",@"RenYuanXinXiViewController"];
    NSArray *arrvc5 = @[@"ZhiBanXinXiViewController",@"ZhiShiKuViewController"];
    
    NSArray *arr0 = [[NSUserDefaults standardUserDefaults] objectForKey:@"hometopItemArr"];
    NSMutableDictionary *dictemp = [NSMutableDictionary new];
    NSArray *arrallname = @[arr1,arr2,arr3,arr4,arr5];
    NSArray *arrallvc = @[arrvc1,arrvc2,arrvc3,arrvc4,arrvc5];
    for(int i = 0 ; i < arrallvc.count; i++)
    {
        NSArray *arrvctemp = arrallvc[i];
        NSArray *arrnametemp = arrallname[i];
        for(int j = 0 ; j < arrvctemp.count; j++)
        {
            [dictemp setObject:arrvctemp[j] forKey:arrnametemp[j]];
        }
        
    }
    [dictemp setObject:@"ZiDingYiPeiZhiViewController" forKey:@"更多"];
    NSMutableArray *arrallvcname = [[NSMutableArray alloc] initWithArray:arr0];
    [arrallvcname addObject:@"更多"];
    
    NSString *strname = [dictemp objectForKey:arrallvcname[indexPath.row]];
    UIViewController *vc = [NSClassFromString(strname) new];
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
}

@end
