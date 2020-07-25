//
//  AddressListAlterView.m
//  ZHProperty
//
//  Created by Mac on 2020/7/16.
//  Copyright © 2020 yx. All rights reserved.
//

#import "AddressListAlterView.h"
#import "AddressListAlterViewTableViewCell.h"
#import "MainHomeDataController.h"
#import "GetAreaModel.h"

@interface AddressListAlterView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tabview;
///
@property (nonatomic , strong) UIView *viewheader;

///顶部可选择
@property (nonatomic , strong) UIView *viewtopitem;
///选中的数据
@property (nonatomic , strong) NSMutableArray *arrSelectItems;
///当前显示的数据
@property (nonatomic , strong) NSMutableArray *arrdata;

@end

@implementation AddressListAlterView
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self arrSelectItems];
        [self getdata];
        
        _viewheader = [self drawHeaderView];
        
        _tabview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self addSubview:_tabview];
        [_tabview setBackgroundColor:[UIColor whiteColor]];
        [_tabview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tabview setDelegate:self];
        [_tabview setDataSource:self];
        [_tabview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.offset(350);
        }];
        UIView *viewtop = [[UIView alloc] init];
        [viewtop setBackgroundColor:[UIColor clearColor]];
        [viewtop setUserInteractionEnabled:YES];
        [self addSubview:viewtop];
        [viewtop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.bottom.equalTo(self.tabview.mas_top);
        }];
        UITapGestureRecognizer  *tapview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiaAction)];
        [viewtop addGestureRecognizer:tapview];
        
        
    }
    return self;
}

-(UIView *)drawHeaderView
{
    UIView *viewheader=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80)];
    [viewheader setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lbtitle = [[UILabel alloc] init];
    [lbtitle setText:@"选择"];
    [lbtitle setTextColor:[UIColor blackColor]];
    [lbtitle setTextAlignment:NSTextAlignmentLeft];
    [lbtitle setFont:[UIFont systemFontOfSize:16]];
    [viewheader addSubview:lbtitle];
    [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(0);
        make.height.offset(40);
    }];
    
    UIView *viewitem = [[UIView alloc] init];
    [viewheader addSubview:viewitem];
    [viewitem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbtitle.mas_bottom);
        make.left.offset(15);
        make.height.offset(40);
    }];
    _viewtopitem = viewitem;
    
    UILabel *lbqingxanz = [[UILabel alloc] init];
    [lbqingxanz setText:@"请选择"];
    [lbqingxanz setTextColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1]];
    [lbqingxanz setTextAlignment:NSTextAlignmentLeft];
    [lbqingxanz setFont:[UIFont systemFontOfSize:14]];
    [viewheader addSubview:lbqingxanz];
    [lbqingxanz mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewitem.mas_right);
        make.centerY.equalTo(viewitem);
    }];
    
    UIView *viewline = [[UIView alloc] init];
    [viewline setBackgroundColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]];
    [viewheader addSubview:viewline];
    [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(viewheader);
        make.height.offset(1);
    }];
    
    return viewheader;
}

///绘制选择的数据按钮
-(void)drawselectBt
{
    NSArray *arrtemp = _viewtopitem.subviews;
    UIButton *btlast = nil;
    [_viewtopitem removeAllSubviews];
    for(int i = 0 ; i < _arrSelectItems.count; i++)
    {
        GetAreaModel *model = _arrSelectItems[i];
        UIButton *btitem = [[UIButton alloc] init];
        [btitem setTitle:model.NAME forState:UIControlStateNormal];
        [btitem setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btitem.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_viewtopitem addSubview:btitem];
        [btitem mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if(btlast==nil)
            {
                make.left.offset(0);
            }
            else
            {
                make.left.equalTo(btlast.mas_right).offset(10);
            }
            make.top.bottom.equalTo(self.viewtopitem);
        }];
        btlast = btitem;
        [btitem setTag:i];
        [btitem addTarget:self action:@selector(topitemAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if(arrtemp.count>0)
    {
        [self.viewtopitem mas_updateConstraints:^(MASConstraintMaker *make) {
            if(btlast==nil)
            {
                
            }
            else
            {
                make.right.equalTo(btlast.mas_right).offset(10);
            }
            
        }];
    }
    else
    {
        [self.viewtopitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(btlast.mas_right).offset(10);
        }];
    }
    
}

-(void)topitemAction:(UIButton *)sender
{
    if(sender.tag>0)
    {
        [self.arrSelectItems removeObjectsInRange:NSMakeRange(sender.tag, self.arrSelectItems.count-sender.tag)];
    }
    else
    {
        [self.arrSelectItems removeAllObjects];
    }
    
    [self drawselectBt];
    [self.tabview reloadData];
    [self getdata];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setBackgroundColor:RGBAlpha(0, 0, 0, 0.4)];
    
    
}


-(void)dismiaAction
{
    [UIView animateWithDuration:0.5 animations:^{
        [self.tabview setTop:[UIScreen mainScreen].bounds.size.height];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"AddressListAlterViewTableViewCell";
    AddressListAlterViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[AddressListAlterViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    GetAreaModel *modelcell = self.arrdata[indexPath.row];
    cell.isselect = NO;
    cell.strvalue = modelcell.NAME;
    for(GetAreaModel *model in _arrSelectItems)
    {
        if([modelcell.ID isEqualToString:model.ID])
        {
            cell.isselect = YES;
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _viewheader;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_arrSelectItems addObject:_arrdata[indexPath.row]];
    
    [self drawselectBt];
    
    [tableView reloadData];
    
    ////如果选择完成就返回数据
    if(_arrSelectItems.count==2)
    {
        if(self.delegate)
        {
            GetAreaModel *model = self.arrSelectItems.lastObject;
            [self.delegate backAddressListAlterViewArr:[NSMutableArray arrayWithObject:model]];
        }
        [self dismiaAction];
    }
    else
    {
        [self getdata];
    }
    
}

-(NSMutableArray *)arrSelectItems
{
    if(_arrSelectItems==nil)
    {
        _arrSelectItems = [NSMutableArray new];
    }
    return _arrSelectItems;
}


-(void)getdata
{
    NSString *strpid = @"500230";
    if(self.arrSelectItems.count > 0)
    {
        GetAreaModel *model = self.arrSelectItems[0];
        strpid = model.ID;
    }
    
    [MainHomeDataController requestShuiChangAlterData:self parentId:strpid Callback:^(NSError *error, BOOL state, NSString *describle, NSMutableArray *value) {
        if(state)
        {
            self.arrdata = value;
        }
        [self.tabview reloadData];
    }];
}

@end
