//
//  LiuLiangJCDataController.h
//  ShuiKu
//
//  Created by Mac on 2020/7/21.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiuLiangJCDataController : NSObject
/*
 流量监测列表
http://222.180.173.75:7118/ccbt_zhgs/api/flow/GetPage?key=&SessionId=cWNr0jXTB_4Zfc_wQtkQig%3D%3D&pageNumber=1&pageSize=10
 */
+ (void)requestLiuLiangJianCheListData:(UIView *)view
                                key:(NSString *)key
                                pageNumber:(int)pageNumber
                       Callback:(completeCallback)callback;

/*
 流量监测列表
 数据详情
 瞬时流量图
 累计流量图
http://222.180.173.75:7118/ccbt_zhgs/api/flow/GetEchartsData?sTime=2020-06-15&eTime=2020-06-15&SessionId=cWNr0jXTB_4Zfc_wQtkQig%3D%3D&stcd=50023020031601
 */
+ (void)requestLiuLiangJianCheXiangQingData:(UIView *)view
                                sTime:(NSString *)sTime
                                eTime:(NSString *)eTime
                                stcd:(NSString *)stcd
                       Callback:(completeCallback)callback;


/*
 浊度监测列表数据
 http://222.180.173.75:7118/ccbt_zhgs/api/WaterQuality/GetPage?key=&SessionId=cWNr0jXTB_4Zfc_wQtkQig%3D%3D&pageNumber=1&pageSize=10
 */
/// 浊度监测列表数据
+ (void)requestZhuoDuJianCheListData:(UIView *)view
         key:(NSString *)key
         pageNumber:(int)pageNumber
Callback:(completeCallback)callback;

/*
 综合监测列表数据
 http://222.180.173.75:7118/ccbt_zhgs/api/Synthesize/GetPage?key=&SessionId=cWNr0jXTB_4Zfc_wQtkQig%3D%3D&pageNumber=1&pageSize=10
 */
/// 综合监测列表数据
+ (void)requestZongHeJianCheListData:(UIView *)view
         key:(NSString *)key
         pageNumber:(int)pageNumber
Callback:(completeCallback)callback;

/*
 监测详情 除流量、综合
 http://222.180.173.75:7118/ccbt_zhgs/api/WaterQuality/GetEchartsData?sTime=2020-06-15&eTime=2020-06-15&SessionId=cWNr0jXTB_4Zfc_wQtkQig%3D%3D&stcd=50023020031602
 */
///监测详情 除流量、综合
+ (void)requestMainJianCeDetailData:(UIView *)view
         sTime:(NSString *)sTime
         eTime:(NSString *)eTime
          stcd:(NSString *)stcd
Callback:(completeCallback)callback;

/*
 综合监测详情
 http://222.180.173.75:7118/ccbt_zhgs/api/Synthesize/GetWqData?sTime=2020-06-15&eTime=2020-06-15&SessionId=cWNr0jXTB_4Zfc_wQtkQig%3D%3D&code=50023020031601
 */
/// 综合监测详情(除瞬时流量图、累计流量图)
+ (void)requestMainZongHeJianCeDetailData:(UIView *)view
         sTime:(NSString *)sTime
         eTime:(NSString *)eTime
          code:(NSString *)code
Callback:(completeCallback)callback;
/*
 综合监测详情 瞬时流量图、累计流量图
 http://222.180.173.75:7118/ccbt_zhgs/api/Synthesize/GetFlowData?sTime=2020-06-15&eTime=2020-06-15&SessionId=cWNr0jXTB_4Zfc_wQtkQig%3D%3D&code=50023020031601

 */
/// 综合监测详情 瞬时流量图、累计流量图
+ (void)requestMainZongHeLiuLiangJianCeDetailData:(UIView *)view
         sTime:(NSString *)sTime
         eTime:(NSString *)eTime
          code:(NSString *)code
Callback:(completeCallback)callback;


@end

NS_ASSUME_NONNULL_END
