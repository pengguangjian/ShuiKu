//
//  AlterListView.m
//  ZHProperty
//
//  Created by Mac on 2020/7/16.
//  Copyright © 2020 yx. All rights reserved.
//

#import "AlterListView.h"

@interface AlterListView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic , strong) UITableView *tabview;
@property (nonatomic , strong) UITapGestureRecognizer *tapview;
@end


@implementation AlterListView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UITapGestureRecognizer *tapview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismisAction)];
        [tapview setDelegate:self];
        _tapview = tapview;
        [self addGestureRecognizer:tapview];
        _tabview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self addSubview:_tabview];
        [_tabview setBackgroundColor:[UIColor clearColor]];
        [_tabview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tabview setDelegate:self];
        [_tabview setDataSource:self];
        [_tabview.layer setMasksToBounds:YES];
        [_tabview.layer setCornerRadius:5];
        [_tabview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(50);
            make.right.equalTo(self).offset(-50);
            make.centerY.equalTo(self);
        }];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setBackgroundColor:RGBAlpha(0, 0, 0, 0.4)];
    
    
}

-(void)dismisAction
{
    [self removeFromSuperview];
}

-(void)setArrdata:(NSMutableArray *)arrdata
{
    _arrdata = arrdata;
    
    if(_arrdata.count>=5)
    {
        [_tabview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(270);
        }];
    }
    else
    {
        [_tabview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(50*(_arrdata.count+1));
        }];
    }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    if(touch.view == self)
    {
        return YES;
    }
    return NO;
}
#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
        UIView *viewline = [[UIView alloc] init];
        
        [viewline setBackgroundColor:RGB(245, 245, 245)];
        [cell.contentView addSubview:viewline];
        [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.bottom.right.equalTo(cell);
            make.height.offset(1);
        }];
        
    }
    [cell.textLabel setText:_arrdata[indexPath.row]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, 50)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lbname = [[UILabel alloc] init];
    [lbname setText:_strtitle];
    [lbname setTextColor:RGB(101, 101, 101)];
    [lbname setFont:[UIFont systemFontOfSize:12]];
    [lbname setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:lbname];
    [lbname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(view);
    }];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [UIView animateWithDuration:0.3 animations:^{
        [self->_tabview setTop:kMainScreenW];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    if(self.delegate)
    {
        [self.delegate ListAlterViewItemSelect:_arrdata[indexPath.row] andviewtag:self.tag];
    }
    
}



@end
