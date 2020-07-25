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

/*
 值班统计
 http://222.180.173.75:7118/ccbt_zhgs/api/DutyManage/DutyStatistic?SessionId=6TuG_lCdmi4bhloIZRCv2A%3D%3D&enddate=2020-06-30&startdate=2020-06-01
 */
/// 值班统计
+ (void)requestZhiBanTongJiData:(UIView *)view
enddate:(NSString *)enddate
startdate:(NSString *)startdate
Callback:(completeCallback)callback;


@end

NS_ASSUME_NONNULL_END
