//
//  RiLiDayCollectionViewCell.h
//  WuYeYuanGongDuan
//
//  Created by Mac on 2020/6/29.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RiLiDayCollectionViewCell : UICollectionViewCell
@property (nonatomic , retain) NSString *valueday;
///0无 1正常 2不正常
//@property (nonatomic , assign) NSInteger type;
///是否选中
@property (nonatomic , assign) BOOL isselect;

@property (nonatomic , assign) BOOL istoday;

//@property (nonatomic , strong) NSString *value;

@end

NS_ASSUME_NONNULL_END
