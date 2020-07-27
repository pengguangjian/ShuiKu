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


/*
 http://183.230.114.158:8678/ccbt_zhgs/api/home/GetFLowData?SessionId=EwmQtH4kxZklics9KyMePw%3D%3D
 首页
 流量超标及列表详情 1
 浊度超标及列表详情 2
 余氯超标及列表详情 3
 PH值超标及列表详情 4
 温度超标及列表详情 5
 */
///首页超标数据及列表
+ (void)requestChaoBiaoListData:(UIView *)view
type:(NSString *)type
Callback:(completeCallback)callback;

/*
///扫码授权
 http://183.230.114.158:8678/ccbt_zhgs/api/auth/ScanCode?sign=FD12B2163C4F5EEE22663E2D54F0937352CBAE6E&client=3F9A28B3B6F34E64A8C54F26EC7176B5&time=2020-07-14%2010%3A22%3A09&type=1001&SessionId=31eFcXupZCnZSraIOrRFYQ%3D%3D
 二维码规则

 type字段 ：
     1001：表示登录操作（展示当前扫码结果）
     2001：表示业务处理（可直接跳转到实时监测等详情页面）
     3001：表示信息查询（可直接跳转到webview页面）

 time：时间，3分钟有效

 clientid：二维码id

 sign：加密指纹数据
    sha1(type+time+clientid)
 */
///扫码授权
+ (void)requestScanCodeData:(UIView *)view
sign:(NSString *)sign
client:(NSString *)client
time:(NSString *)time
Callback:(completeCallback)callback;

@end

NS_ASSUME_NONNULL_END
