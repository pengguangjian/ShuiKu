//
//  RenYuanXinXiViewController.h
//  ShuiKu
//
//  Created by Mac on 2020/7/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RenYuanXinXiViewControllerDelegate <NSObject>
///编辑时选中的人员
-(void)backSelecePeopleArr:(NSMutableArray *)arrvalue;

@end

@interface RenYuanXinXiViewController : RootViewController
@property (nonatomic , weak) id<RenYuanXinXiViewControllerDelegate>delegate;
@property (nonatomic , assign) BOOL isedit;

@end

NS_ASSUME_NONNULL_END
