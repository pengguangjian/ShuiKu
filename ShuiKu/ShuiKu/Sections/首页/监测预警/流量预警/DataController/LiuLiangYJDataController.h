//
//  LiuLiangYJDataController.h
//  ShuiKu
//
//  Created by Mac on 2020/7/21.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiuLiangYJDataController : NSObject

/*
最新预警
 */
+ (void)requestZuiXinYuJinGGData:(UIView *)view
                             key:(NSString *)key
                      pageNumber:(int)pageNumber
                       Callback:(completeCallback)callback;

/*
历史预警
 http://222.180.173.75:7118/ccbt_zhgs/api/newwarning/GetItems?sTime=2020-06-15&eTime=2020-06-15&SessionId=cWNr0jXTB_4Zfc_wQtkQig%3D%3D&stcd=2020060901
 */
+ (void)requestLiShiYuJinGGData:(UIView *)view
                             sTime:(NSString *)sTime
                            eTime:(NSString *)eTime
                            stcd:(NSString *)stcd
                       Callback:(completeCallback)callback;

/*
关闭预警
 http://222.180.173.75:7118/ccbt_zhgs/api/newwarning/Delete?id=353153&SessionId=TaH7ecE1pL-2isC6iZCeXA%3D%3D
 */
+ (void)requestGuanBiYuJinGGData:(UIView *)view
                             did:(NSString *)did
                       Callback:(completeCallback)callback;

/*
预警处置
http://222.180.173.75:7118/ccbt_zhgs/api/newwarning/HandleWarning?SUGGEST=22&HANDLER_ID=458FB6345F8D4E7683EA6679381488A8&NOTICE=1&SessionId=LTuHNNSy5Dd8tEsJ_aBG2Q%3D%3D&DESCRIPTION=11&WARNING_ID=5002302003160114&TASK_LEVEL=2
 */
+ (void)requestChuZhiYuJinGGData:(UIView *)view
                             SUGGEST:(NSString *)SUGGEST
                            HANDLER_ID:(NSString *)HANDLER_ID
                            NOTICE:(NSString *)NOTICE
                            DESCRIPTION:(NSString *)DESCRIPTION
                            WARNING_ID:(NSString *)WARNING_ID
                            TASK_LEVEL:(NSString *)TASK_LEVEL
                       Callback:(completeCallback)callback;

/*
 获取预警任务分页列表
 http://222.180.173.75:7118/ccbt_zhgs/api/WarningArrangement/GetPage?key=&SessionId=qoPUTUnE54NFXZSK0uf5Gw%3D%3D&pageNumber=1&pageSize=10
 */
/// 获取预警任务分页列表
+ (void)requestYuJingRengWuListData:(UIView *)view
      key:(NSString *)key
     pageNumber:(NSString *)pageNumber
     pageSize:(NSString *)pageSize
Callback:(completeCallback)callback;

/*
 任务详情（处置记录）
 http://222.180.173.75:7118/ccbt_zhgs/api/WarningArrangement/GetTrans?id=20200617140002&SessionId=qoPUTUnE54NFXZSK0uf5Gw%3D%3D
 */
///任务详情（处置记录）
+ (void)requestYuJingRengWuChuZhiJiLuData:(UIView *)view
      ID:(NSString *)ID
Callback:(completeCallback)callback;

/*
 新增任务处置
 http://222.180.173.75:7118/ccbt_zhgs/api/WarningArrangement/HandlerTrans?handler=458FB6345F8D4E7683EA6679381488A8%2CC2F28C23D76B4375B67DE2BAD55AAB0F&id=20200617140002&SessionId=LTuHNNSy5Dd8tEsJ_aBG2Q%3D%3D&des=%E6%94%B6%E5%88%B0%E7%9A%84
 */
/// 新增任务处置
+ (void)requestYuJingRengWuChuZhiXinZengData:(UIView *)view
      ID:(NSString *)ID
handler:(NSString *)handler
des:(NSString *)des
Callback:(completeCallback)callback;

/*
 http://222.180.173.75:7118/ccbt_zhgs/api/WarningArrangement/CloseTask?id=20200617150002&SessionId=qoPUTUnE54NFXZSK0uf5Gw%3D%3D
 关闭预警（办结）
 */
/// 关闭预警（办结）
+ (void)requestYuJingRengWuChuZhiBanJieData:(UIView *)view
      ID:(NSString *)ID
Callback:(completeCallback)callback;



@end

NS_ASSUME_NONNULL_END
