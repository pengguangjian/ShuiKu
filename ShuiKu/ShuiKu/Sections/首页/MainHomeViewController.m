//
//  MainHomeViewController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MainHomeViewController.h"

#import "MainHomeView.h"

@interface MainHomeViewController ()

@property (nonatomic , strong) MainHomeView *homeview;

@end

@implementation MainHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"";
    [self setnavView];
    [self drawUI];
    
    
}

-(void)setnavView
{
    UIButton* btnleft = [[UIButton alloc] init];//btnLeft.backgroundColor=[UIColor redColor]
    [btnleft setTitle:@"丰都智慧供水" forState:UIControlStateNormal];
    [btnleft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnleft.titleLabel setFont:[UIFont systemFontOfSize:14]];
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnleft];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIButton* btnright = [[UIButton alloc] init];//btnLeft.backgroundColor=[UIColor redColor]
    [btnright setImage:[UIImage imageNamed:@"ic_qr"] forState:UIControlStateNormal];
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnright];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    [btnright addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)rightAction
{
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_homeview refCollect];
}

-(void)drawUI
{
    MainHomeView *view = [[MainHomeView alloc] init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.edges.equalTo(self.view).insets(kPaddingNav);
        }
    }];
    
    _homeview = view;
    
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
