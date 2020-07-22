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


@end

NS_ASSUME_NONNULL_END
