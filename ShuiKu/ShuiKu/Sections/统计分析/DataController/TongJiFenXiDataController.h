//
//  TongJiFenXiDataController.h
//  ShuiKu
//
//  Created by Mac on 2020/7/22.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TongJiFenXiDataController : NSObject
/*
 流量分析
http://222.180.173.75:7118/ccbt_zhgs/api/FlowStatistic/GetEchartsDataByDay?date=2020-07&SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=
 http://222.180.173.75:7118/ccbt_zhgs/api/FlowStatistic/GetEchartsDataByMonth?date=2020&SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=
 http://222.180.173.75:7118/ccbt_zhgs/api/FlowStatistic/GetEchartsDataByYear?SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=
 type 0日 1月 2年
 */
+ (void)requestLiuLiangFenXiData:(UIView *)view
                                date:(NSString *)date
                                type:(int)type
                                stcd:(NSString *)stcd
                       Callback:(completeCallback)callback;

/*
 浊度分析
  type 0日 1月 2年
 http://222.180.173.75:7118/ccbt_zhgs/api/TurbStatistic/GetEchartsDataByDay?date=2020-07&SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=
 http://222.180.173.75:7118/ccbt_zhgs/api/TurbStatistic/GetEchartsDataByMonth?date=2020&SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=
 http://222.180.173.75:7118/ccbt_zhgs/api/TurbStatistic/GetEchartsDataByYear?SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=
 */
+ (void)requestZhuoDuFenXiData:(UIView *)view
         date:(NSString *)date
         type:(int)type
         stcd:(NSString *)stcd
Callback:(completeCallback)callback;

/*
 余氯分析
 type 0日 1月 2年
 http://222.180.173.75:7118/ccbt_zhgs/api/ClStatistic/GetEchartsDataByDay?date=2020-07&SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=
 http://222.180.173.75:7118/ccbt_zhgs/api/ClStatistic/GetEchartsDataByMonth?date=2020&SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=
 http://222.180.173.75:7118/ccbt_zhgs/api/ClStatistic/GetEchartsDataByYear?SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=
 */
+ (void)requestYuLvFenXiData:(UIView *)view
         date:(NSString *)date
         type:(int)type
         stcd:(NSString *)stcd
Callback:(completeCallback)callback;

/*
 PH分析

 http://222.180.173.75:7118/ccbt_zhgs/api/PhStatistic/GetEchartsDataByDay?date=2020-07&SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=
 http://222.180.173.75:7118/ccbt_zhgs/api/PhStatistic/GetEchartsDataByMonth?date=2020&SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=
 http://222.180.173.75:7118/ccbt_zhgs/api/PhStatistic/GetEchartsDataByYear?SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=
 
 */
+ (void)requestPHZhiFenXiData:(UIView *)view
         date:(NSString *)date
         type:(int)type
         stcd:(NSString *)stcd
Callback:(completeCallback)callback;

/*
 温度分析
 http://222.180.173.75:7118/ccbt_zhgs/api/WtStatistic/GetEchartsDataByDay?date=2020-07&SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=
 http://222.180.173.75:7118/ccbt_zhgs/api/WtStatistic/GetEchartsDataByMonth?date=2020&SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=
 http://222.180.173.75:7118/ccbt_zhgs/api/WtStatistic/GetEchartsDataByYear?SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=

 */
+ (void)requestWenDuFenXiData:(UIView *)view
         date:(NSString *)date
         type:(int)type
         stcd:(NSString *)stcd
Callback:(completeCallback)callback;

/*
 监测预警统计
 
 http://222.180.173.75:7118/ccbt_zhgs/api/WarningStatistic/GetEchartsDataByDay?date=2020-07&SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=
 http://222.180.173.75:7118/ccbt_zhgs/api/WarningStatistic/GetEchartsDataByMonth?date=2020&SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=
 http://222.180.173.75:7118/ccbt_zhgs/api/WarningStatistic/GetEchartsDataByYear?SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=
 */
+ (void)requestYuJingFenXiData:(UIView *)view
         date:(NSString *)date
         type:(int)type
         stcd:(NSString *)stcd
Callback:(completeCallback)callback;

/*
 测站统计
 http://222.180.173.75:7118/ccbt_zhgs/api/StationStatistic/GetEchartsDataByMonth?date=2020-07&SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=
 http://222.180.173.75:7118/ccbt_zhgs/api/StationStatistic/GetEchartsDataByMonth?date=2020&SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=
 http://222.180.173.75:7118/ccbt_zhgs/api/StationStatistic/GetEchartsDataByYear?SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&stcd=

 */
+ (void)requestCeDianFenXiData:(UIView *)view
         date:(NSString *)date
         type:(int)type
         stcd:(NSString *)stcd
Callback:(completeCallback)callback;

@end

NS_ASSUME_NONNULL_END
