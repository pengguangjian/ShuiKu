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
 水厂的弹窗
 http://183.230.114.158:8678/ccbt_zhgs/api/DataManagement/GetArea?parentId=500230&SessionId=6eQ6Waq3QSMc-QaizkdWSg%3D%3D
 */
///水厂的弹窗
+ (void)requestShuiChangAlterData:(UIView *)view
                         parentId:(NSString *)parentId
                         Callback:(completeCallback)callback;


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

/*
  值班详情
 http://183.230.114.158:8678/ccbt_zhgs/api/DutyManage/GetRecord?SessionId=6eQ6Waq3QSMc-QaizkdWSg%3D%3D&DUTYTIME=2020-06-29
 */
///值班详情
+ (void)requestZhiBanXiangqingData:(UIView *)view
DUTYTIME:(NSString *)DUTYTIME
Callback:(completeCallback)callback;

/*
水厂列表
 xzqhbm 地区
 http://222.180.173.75:7118/ccbt_zhgs/api/waterwork/GetPage?SessionId=6TuG_lCdmi4bhloIZRCv2A%3D%3D&xzqhbm=&key=&pageNumber=1&pageSize=10
 */
///水厂列表
+ (void)requestShuiChangListData:(UIView *)view
xzqhbm:(NSString *)xzqhbm
key:(NSString *)key
pageNumber:(int)pageNumber
Callback:(completeCallback)callback;


/*
 监测点列表
 http://222.180.173.75:7118/ccbt_zhgs/api/StationManage/GetPage?SessionId=6TuG_lCdmi4bhloIZRCv2A%3D%3D&xzqhbm=50&key=&pageNumber=1&pageSize=10
 */
/// 监测点列表
+ (void)requestCeDianListData:(UIView *)view
xzqhbm:(NSString *)xzqhbm
key:(NSString *)key
pageNumber:(int)pageNumber
Callback:(completeCallback)callback;

@end

NS_ASSUME_NONNULL_END
