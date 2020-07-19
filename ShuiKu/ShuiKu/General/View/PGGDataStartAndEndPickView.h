//
//  PGGDataStartAndEndPickView.h
//  ZHProperty
// 包含开始和结束的日期
//  Created by Mac on 2020/7/16.
//  Copyright © 2020 yx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PGGDataStartAndEndPickViewDelegate <NSObject>

-(void)changetimeValue:(NSString *)strvalue;

-(void)dismisAction;

@end

@interface PGGDataStartAndEndPickView : UIView

@property (nonatomic , retain) id<PGGDataStartAndEndPickViewDelegate>degelate;
////多少列  最多5列
@property (nonatomic , assign) int iline;
///是否到当前时间 默认是no
@property (nonatomic , assign) BOOL isNotnowtime;

@end

NS_ASSUME_NONNULL_END
