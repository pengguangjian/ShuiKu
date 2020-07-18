//
//  RenYuanXinXiTableViewCell.h
//  ShuiKu
//
//  Created by Mac on 2020/7/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RenYuanXinXiModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RenYuanXinXiTableViewCell : UITableViewCell
@property (nonatomic , assign) BOOL isedit;
@property (nonatomic , strong) RenYuanXinXiModel *model;

@end

NS_ASSUME_NONNULL_END
