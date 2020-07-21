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

@end

NS_ASSUME_NONNULL_END
