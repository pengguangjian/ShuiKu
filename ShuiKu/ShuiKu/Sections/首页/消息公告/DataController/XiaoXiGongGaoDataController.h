//
//  XiaoXiGongGaoDataController.h
//  ShuiKu
//
//  Created by Mac on 2020/7/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XiaoXiGongGaoDataController : NSObject

/*
通知公告分类
 */
+ (void)requestTongZhiGongFenLeiData:(UIView *)view
                       Callback:(completeCallback)callback;


/*
通知公告列表
 */
+ (void)requestTongZhiGongLieBiaoData:(UIView *)view
                        NewType:(NSString *)NewType
                        pageNumber:(int)pageNumber
                       Callback:(completeCallback)callback;

/*
通知公告详情
 */
+ (void)requestTongZhiGongXiangQingData:(UIView *)view
                        gid:(NSString *)gid
                       Callback:(completeCallback)callback;

@end

NS_ASSUME_NONNULL_END
