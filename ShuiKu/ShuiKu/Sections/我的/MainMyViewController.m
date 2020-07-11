//
//  MainMyViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MainMyViewController.h"
#import "MainMyTableViewCell.h"
@interface MainMyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) NSArray *arrtitle;
@end

@implementation MainMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    
    
    [self drawUI];
}

-(void)drawUI
{
    
    UITableView *tabview = [[UITableView alloc] init];
    [tabview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tabview setDelegate:self];
    [tabview setDataSource:self];
    [tabview setScrollEnabled:NO];
    [self.view addSubview:tabview];
    [tabview mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.edges.equalTo(self.view).insets(kPaddingNav);
        }
    }];
    [tabview setTableHeaderView:[self drawheaderView]];
    
    NSArray *arrtitle = @[@"重设密码",@"关于我们",@"意见反馈",@"设置"];
    _arrtitle = arrtitle;
    
}

-(UIView *)drawheaderView
{
    UIView *viewback = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, 170)];
    [viewback setClipsToBounds:YES];
    UIImageView *imgvback = [[UIImageView alloc] init];
    [imgvback setImage:[UIImage imageNamed:@"我的背景"]];
    [imgvback setContentMode:UIViewContentModeScaleAspectFill];
    [viewback addSubview:imgvback];
    [imgvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(viewback);
    }];
    
    
    UIImageView *imgvhd = [[UIImageView alloc] init];
    [imgvhd setBackgroundColor:[UIColor grayColor]];
    [imgvhd.layer setMasksToBounds:YES];
    [imgvhd.layer setCornerRadius:35];
    [viewback addSubview:imgvhd];
    [imgvhd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(70);
        make.centerX.equalTo(viewback);
        make.top.offset(20);
    }];
    
    UILabel *lbname = [[UILabel alloc] init];
    [lbname setText:@"张三"];
    [lbname setTextColor:[UIColor whiteColor]];
    [lbname setTextAlignment:NSTextAlignmentCenter];
    [lbname setFont:[UIFont systemFontOfSize:15]];
    [viewback addSubview:lbname];
    [lbname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewback);
        make.top.equalTo(imgvhd.mas_bottom).offset(15);
    }];
    
    UILabel *lbzhiwei = [[UILabel alloc] init];
    [lbzhiwei setText:@"管理员"];
    [lbzhiwei setTextColor:[UIColor whiteColor]];
    [lbzhiwei setTextAlignment:NSTextAlignmentCenter];
    [lbzhiwei setFont:[UIFont systemFontOfSize:13]];
    [viewback addSubview:lbzhiwei];
    [lbzhiwei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewback);
        make.top.equalTo(lbname.mas_bottom).offset(5);
    }];
    
    return viewback;
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _arrtitle.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"MainMyTableViewCell";
    MainMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[MainMyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.strtitle = _arrtitle[indexPath.row];
    
    cell.imagehd = [UIImage imageNamed:_arrtitle[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
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
