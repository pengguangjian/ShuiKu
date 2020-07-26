//
//  ZhiShiKuTableViewController.h
//  ShuiKu
//
//  Created by Mac on 2020/7/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZhiShiKuTableViewController : UITableViewController
///
@property (nonatomic , strong) NSString *ID;

-(void)getData;

@end

NS_ASSUME_NONNULL_END
