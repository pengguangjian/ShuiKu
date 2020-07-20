//
//  XiaoXiGongGaoTableViewController.h
//  ShuiKu
//
//  Created by Mac on 2020/7/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XiaoXiGongGaoTableViewController : UITableViewController
///
@property (nonatomic , strong) NSString *newtype;

-(void)getData;

@end

NS_ASSUME_NONNULL_END
