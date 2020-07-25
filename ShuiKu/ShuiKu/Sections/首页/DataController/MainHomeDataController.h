//
//  MainHomeDataController.h
//  ShuiKu
//
//  Created by Mac on 2020/7/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainHomeDataController : NSObject
/*
 首页通知公告
 */
+ (void)requestTongZhiGongGGData:(UIView *)view
                       Callback:(completeCallback)callback;

/*
获取联系人用户信息
 */
+ (void)requestUserListData:(UIView *)view
                        Callback:(completeCallback)callback;


@end

NS_ASSUME_NONNULL_END
