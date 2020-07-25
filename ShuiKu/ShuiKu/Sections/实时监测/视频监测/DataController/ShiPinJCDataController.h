//
//  ShiPinJCDataController.h
//  ShuiKu
//
//  Created by Mac on 2020/7/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShiPinJCDataController : NSObject

/*
 获取水厂列表
 http://183.230.114.158:8678/ccbt_zhgs/api/hikapi/GetDevicePage?name=&SessionId=31eFcXupZCnZSraIOrRFYQ%3D%3D&pageNumber=2&pageSize=10
 */
+ (void)requestShuiChangListData:(UIView *)view
         name:(NSString *)name
         pageNumber:(int)pageNumber
Callback:(completeCallback)callback;

/*
 获取水厂下的视频列表
 http://183.230.114.158:8678/ccbt_zhgs/api/hikapi/GetCameraPage?SessionId=31eFcXupZCnZSraIOrRFYQ%3D%3D&cameraName=&indexCode=34648a0ed7df400dab496ee1ab663682&pageNumber=1&pageSize=10
 */
/// 获取水厂下的视频列表
+ (void)requestShuiChangCamaListData:(UIView *)view
         cameraName:(NSString *)cameraName
         pageNumber:(int)pageNumber
indexCode:(NSString *)indexCode
Callback:(completeCallback)callback;

/*
 获取视频播放地址
 http://183.230.114.158:8678/ccbt_zhgs/api/hikapi/GetPreviweUrl?indexCode=5aff3ca8b89a450ba3565809d8e07808&SessionId=31eFcXupZCnZSraIOrRFYQ%3D%3D&streamType=0
 */
//// 获取视频播放地址
+ (void)requestShuiChangMoveUrlData:(UIView *)view
         indexCode:(NSString *)indexCode
         streamType:(NSString *)streamType
Callback:(completeCallback)callback;


@end

NS_ASSUME_NONNULL_END
