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
                       Callback:(completeCallback)callback;




@end

NS_ASSUME_NONNULL_END
