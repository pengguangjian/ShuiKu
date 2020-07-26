//
//  ZhongHeJCDetailViewController.h
//  ShuiKu
//
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class ZongHeJianCeMainListModel;
@interface ZhongHeJCDetailViewController : RootViewController
@property (nonatomic , strong) NSString *strSTCD;
@property (nonatomic , strong) ZongHeJianCeMainListModel *model;
@end

NS_ASSUME_NONNULL_END
