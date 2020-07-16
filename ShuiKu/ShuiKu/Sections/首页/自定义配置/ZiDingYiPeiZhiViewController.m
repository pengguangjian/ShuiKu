
//
//  ZiDingYiPeiZhiViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ZiDingYiPeiZhiViewController.h"
#import "ZiDingYiPeiZhiCollectionViewCell.h"
#import "ZiDingYiPeiZhiHeaderView.h"

#import "ZiDingYiPeiZhiModel.h"

@interface ZiDingYiPeiZhiViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView *collect;

@property (nonatomic , strong) NSMutableArray *arrdata;

@property (nonatomic , assign) BOOL isedit;

@property (nonatomic , assign) CGPoint pointfirst;
///保存的功能
@property (nonatomic, strong) NSMutableArray *arrHestoryAction;

@property (nonatomic, strong) NSMutableArray *cellAttributesArray;
@property (nonatomic, assign) CGPoint lastPressPoint;


@end

@implementation ZiDingYiPeiZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义配置";
    [self setnavbt];
    
    [self drawUI];
    
    
    _lastPressPoint = CGPointZero;
    
}

-(void)setnavbt
{
    UIButton* btnright = [[UIButton alloc] init];//btnLeft.backgroundColor=[UIColor redColor]
    [btnright setTitle:@"管理" forState:UIControlStateNormal];
    [btnright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnright.titleLabel setFont:[UIFont systemFontOfSize:14]];
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnright];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    [btnright addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)rightAction:(UIButton *)sender
{
    if(_isedit == NO)
    {
        _isedit = YES;
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        
        [self iseditData];
        
    }
    else
    {
        _isedit = NO;
        [sender setTitle:@"管理" forState:UIControlStateNormal];
        [self isNoteditData];
        
    }
}
///将数据更改为编辑状态
-(void)iseditData
{
    NSMutableArray *arrfist = _arrdata[0];
    for(int i =0; i<_arrdata.count; i++)
    {
        NSMutableArray *arritem = _arrdata[i];
        for(ZiDingYiPeiZhiModel *model in arritem)
        {
            if(i==0)
            {///状态 0无 1+ 2- 3勾
                model.type = 2;
            }
            else
            {
                model.type = 1;
                ///如果有的话就是勾
                for(ZiDingYiPeiZhiModel *model1 in arrfist)
                {
                    if([model1.name isEqualToString:model.name])
                    {
                        model.type = 3;
                    }
                }
            }
        }
    }
    [_collect reloadData];
    
    _arrHestoryAction = _arrdata[0];
    
}
///将数据更改为非编辑状态
-(void)isNoteditData
{
    for(NSMutableArray *arritem in _arrdata)
    {
        for(ZiDingYiPeiZhiModel *model in arritem)
        {
            model.type = 0;
        }
    }
    [_collect reloadData];
}


-(void)drawUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((kMainScreenW-60)/5, kScale * 70);
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
    [collect registerClass:[ZiDingYiPeiZhiCollectionViewCell class] forCellWithReuseIdentifier:@"ZiDingYiPeiZhiCollectionViewCell"];
    [collect registerClass:[ZiDingYiPeiZhiHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZiDingYiPeiZhiHeaderView"];
    [collect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"];
    _collect = collect;
    
    [self dataAction];
}

-(void)dataAction
{
    NSArray *arr0 = [[NSUserDefaults standardUserDefaults] objectForKey:@"hometopItemArr"];
    if(arr0==nil)
    {
        arr0 = [NSArray array];
    }
    _arrdata = [NSMutableArray new];
    
    NSArray *arr1 = @[@"流量监测",@"浊度监测",@"余氯监测",@"温度监测",@"PH值监测",@"视频监测",@"水质监测",@"综合监测",@"一张图"];
    NSArray *arr2 = @[@"水质分析",@"流量分析",@"测点分析",@"预警分析",@"水费统计",@"用水户统计"];
    NSArray *arr3 = @[@"流量预警",@"浊度预警",@"余氯预警",@"PH值预警",@"温度预警"];
    NSArray *arr4 = @[@"水厂信息",@"测站信息",@"人员信息"];
    NSArray *arr5 = @[@"值班信息",@"知识库"];
    
    [_arrdata addObject:[self changeToModelArr:arr0]];
    [_arrdata addObject:[self changeToModelArr:arr1]];
    [_arrdata addObject:[self changeToModelArr:arr2]];
    [_arrdata addObject:[self changeToModelArr:arr3]];
    [_arrdata addObject:[self changeToModelArr:arr4]];
    [_arrdata addObject:[self changeToModelArr:arr5]];
    [_collect reloadData];
}

-(NSMutableArray *)changeToModelArr:(NSArray *)arr
{
    NSMutableArray *arrtmep = [NSMutableArray new];
    for(NSString *strtemp in arr)
    {
        ZiDingYiPeiZhiModel *model = [[ZiDingYiPeiZhiModel alloc] init];
        model.name = strtemp;
        model.type = 0;
        [arrtmep addObject:model];
    }
    
    
    return arrtmep;
}

- (void)longPressAction:(UILongPressGestureRecognizer *)sender{
    ZiDingYiPeiZhiCollectionViewCell *cell = (ZiDingYiPeiZhiCollectionViewCell *)sender.view;
    NSIndexPath *cellIndexPath = [_collect indexPathForCell:cell];
    [_collect bringSubviewToFront:cell];
    BOOL isChanged = NO;
    
//    NSMutableArray *arrtemp = _arrHestoryAction;
//    NSMutableArray *arrfirst = [[NSMutableArray alloc] initWithArray:arrtemp];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self.cellAttributesArray removeAllObjects];
        for (int i = 0;i< _arrHestoryAction.count; i++) {
            [self.cellAttributesArray addObject:[_collect layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
        }
        self.lastPressPoint = [sender locationInView:_collect];
    }else if (sender.state == UIGestureRecognizerStateChanged){
        cell.center = [sender locationInView:_collect];
        for (UICollectionViewLayoutAttributes *attributes in self.cellAttributesArray) {
            if (CGRectContainsPoint(attributes.frame, cell.center) && cellIndexPath != attributes.indexPath) {
                isChanged = YES;
                //对数组中存放的元素重新排序
                ZiDingYiPeiZhiModel *imageStr = _arrHestoryAction[cellIndexPath.row];
                [_arrHestoryAction removeObjectAtIndex:cellIndexPath.row];
                [_arrHestoryAction insertObject:imageStr atIndex:attributes.indexPath.row];
                [self.collect moveItemAtIndexPath:cellIndexPath toIndexPath:attributes.indexPath];
                
                
            }
        }
        
    }else if (sender.state == UIGestureRecognizerStateEnded) {
        if (!isChanged) {
            cell.center = [_collect layoutAttributesForItemAtIndexPath:cellIndexPath].center;
        }
//        NSLog(@"排序后---%@",arrfirst);
        
        NSMutableArray *arrsave = [NSMutableArray new];
        for(ZiDingYiPeiZhiModel *model in _arrHestoryAction)
        {
            [arrsave addObject:model.name];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:arrsave forKey:@"hometopItemArr"];
        
    }
}


#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _arrdata.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *arritem = _arrdata[section];
    return arritem.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZiDingYiPeiZhiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZiDingYiPeiZhiCollectionViewCell" forIndexPath:indexPath];
    
    
    NSArray *arritem = _arrdata[indexPath.section];
    ZiDingYiPeiZhiModel *model = arritem[indexPath.row];
    cell.strname = model.name;
    cell.image = [UIImage imageNamed:model.name];
    cell.type = model.type;
    
    ///
    if(model.type==2)
    {
        
        [cell setUserInteractionEnabled:YES];
        UILongPressGestureRecognizer *gesture =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [cell addGestureRecognizer:gesture];
        
        
    }
    
    
    [cell setBtaction:^{
        ///状态 0无 1+ 2- 3勾
        if(model.type==1)
        {
            
            NSArray *arr0 = [[NSUserDefaults standardUserDefaults] objectForKey:@"hometopItemArr"];
            
            if(arr0.count==9)
            {
                [WYTools showNotifyHUDwithtext:@"最多可添加9个" inView:self.view];
                return;
            }
            
            NSMutableArray *arrtemp = [NSMutableArray new];
            if(arr0!=nil)
            {
                [arrtemp addObjectsFromArray:arr0];
            }
            
            [arrtemp addObject:model.name];
            [[NSUserDefaults standardUserDefaults] setObject:arrtemp forKey:@"hometopItemArr"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dataAction];
                [self iseditData];
            });
            
            
        }
        else if (model.type==2)
        {
            NSArray *arr0 = [[NSUserDefaults standardUserDefaults] objectForKey:@"hometopItemArr"];
            NSMutableArray *arrtemp = [NSMutableArray new];
            if(arr0!=nil)
            {
                [arrtemp addObjectsFromArray:arr0];
            }
            for(NSString *strtemp in arrtemp)
            {
                if([strtemp isEqualToString:model.name])
                {
                    [arrtemp removeObject:strtemp];
                    break;
                }
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:arrtemp forKey:@"hometopItemArr"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dataAction];
                [self iseditData];
            });
        }
        
    }];
    
    return cell;
}
///顶部的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){kMainScreenW,44};
}

///底部的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return (CGSize){kMainScreenW,10};
}

// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        ZiDingYiPeiZhiHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ZiDingYiPeiZhiHeaderView" forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[ZiDingYiPeiZhiHeaderView alloc] init];
        }
        NSArray *arrname = @[@"首页展示",@"实时监测",@"统计分析",@"监测预警",@"基础信息",@"运行管理"];
        [headerView.lbname setText:arrname[indexPath.section]];
        if(indexPath.section==0)
        {
            [headerView.lbcontent setText:@"最多可展示9个，可拖到排序"];
        }
        else
        {
            [headerView.lbcontent setText:@""];
        }
        
        
        return headerView;
    }
    if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
        }
        
        [headerView setBackgroundColor:RGB(245, 245, 245)];
        
        return headerView;
    }
    return nil;
}
        
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==4)
    {
        
        NSArray *arrvc = @[@"ShuiChangXinXiTableViewController",@"CeZhanXinXiViewController",@"RenYuanXinXiViewController"];
        
        UIViewController *vc = [NSClassFromString(arrvc[indexPath.row]) new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(indexPath.section==5)
    {
        NSArray *arrvc = @[@"ZhiBanXinXiViewController",@"ZhiBanXinXiViewController"];
        
        UIViewController *vc = [NSClassFromString(arrvc[indexPath.row]) new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}


- (NSMutableArray *)cellAttributesArray{
    if (!_cellAttributesArray) {
        self.cellAttributesArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _cellAttributesArray;
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
