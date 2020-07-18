

//
//  RenYuanXinXiViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "RenYuanXinXiViewController.h"
#import "RenYuanXinXiTableViewCell.h"
@interface RenYuanXinXiViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tabview;
@property (nonatomic , strong) NSMutableArray *arrdata;
@end

@implementation RenYuanXinXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预警处置";
    
    ///测试
//    self.isedit = NO;
    
    if(self.isedit)
    {
        [self setnavRight];
    }
    
    [self drawUI];
}

-(void)setnavRight
{
    UIButton* btnright = [[UIButton alloc] init];//btnLeft.backgroundColor=[UIColor redColor]
    [btnright setTitle:@"确定" forState:UIControlStateNormal];
    [btnright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnright.titleLabel setFont:[UIFont systemFontOfSize:14]];
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnright];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    [btnright addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)rightAction
{
    NSMutableArray *arrtemp = [NSMutableArray new];
    for(RenYuanXinXiModel *model in  self.arrdata)
    {
        if(model.isselect)
        {
            [arrtemp addObject:model];
        }
    }
}


-(void)drawUI
{
    UITableView *tabview = [[UITableView alloc] init];
    [tabview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tabview setBackgroundColor:[UIColor whiteColor]];
    [tabview setDelegate:self];
    [tabview setDataSource:self];
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
    _tabview = tabview;
    [self drawHeaderView];
    
    
    self.arrdata = [NSMutableArray new];
    for(int i = 0 ; i < 10 ;i++)
    {
        RenYuanXinXiModel *model = [RenYuanXinXiModel new];
        [self.arrdata addObject:model];
    }
    
    
}
-(void)drawHeaderView
{
    
    UIView *viewtop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, 50)];
    [viewtop setBackgroundColor:RGB(132, 172, 223)];
    
    UILabel *lbbcnum = [[UILabel alloc] initWithFrame:CGRectMake(10,0, viewtop.width-20, viewtop.height)];
    [lbbcnum setTextColor:RGB(30, 30, 30)];
    [lbbcnum setTextAlignment:NSTextAlignmentLeft];
    [lbbcnum setFont:[UIFont systemFontOfSize:13]];
    [lbbcnum setText:@"办公室"];
    [viewtop addSubview:lbbcnum];
    [_tabview setTableHeaderView:viewtop];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"RenYuanXinXiTableViewCell";
    RenYuanXinXiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[RenYuanXinXiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.isedit = self.isedit;
    cell.model = self.arrdata[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isedit)
    {
        RenYuanXinXiModel *model = self.arrdata[indexPath.row];
        model.isselect = !model.isselect;
        [tableView reloadData];
    }
    else
    {
        
    }
    
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
