
//
//  ShiPinJCDataController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ShiPinJCDataController.h"
#import "HTTPManager.h"
#import "ShiPinJcShuiChangListModel.h"
#import "ShiPinJcShuiChangCamaListModel.h"

@implementation ShiPinJCDataController

+ (void)requestShuiChangListData:(UIView *)view
         name:(NSString *)name
         pageNumber:(int)pageNumber
Callback:(completeCallback)callback
{
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:@"100" forKey:@"pageSize"];
    [dicpush setObject:@(pageNumber) forKey:@"pageNumber"];
    [dicpush setObject:name forKey:@"name"];
    NSLog(@"%@",dicpush);
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/hikapi/GetDevicePage?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
        BOOL state = NO;
        NSString *describle = @"";
        if (responceObjct==nil) {
            describle = @"网络错误";
        }else{
            NSString *str=[[NSString alloc]initWithData:responceObjct encoding:NSUTF8StringEncoding];
            NSDictionary *dicAll=[str JSONValue];
            describle = dicAll[@"message"];
            if ([[NSString nullToString:dicAll[@"errcode"]] intValue] == 0) {
                if([[dicAll objectForKey:@"data"] isKindOfClass:[NSDictionary class]])
                {
                    state = YES;
                }
                else
                {
                    state = NO;
                }
            }
            else
            {
                state = NO;
            }
            if(state==YES)
            {
                callback(error,state,describle,[ShiPinJcShuiChangListModel initDataValue:[[dicAll objectForKey:@"data"] objectForKey:@"list"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
    
}
/// 获取水厂下的视频列表
+ (void)requestShuiChangCamaListData:(UIView *)view
         cameraName:(NSString *)cameraName
         pageNumber:(int)pageNumber
indexCode:(NSString *)indexCode
Callback:(completeCallback)callback
{
    
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:@"100" forKey:@"pageSize"];
    [dicpush setObject:@(pageNumber) forKey:@"pageNumber"];
    [dicpush setObject:cameraName forKey:@"cameraName"];
    [dicpush setObject:indexCode forKey:@"indexCode"];
    NSLog(@"%@",dicpush);
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/hikapi/GetCameraPage?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
        BOOL state = NO;
        NSString *describle = @"";
        if (responceObjct==nil) {
            describle = @"网络错误";
        }else{
            NSString *str=[[NSString alloc]initWithData:responceObjct encoding:NSUTF8StringEncoding];
            NSDictionary *dicAll=[str JSONValue];
            describle = dicAll[@"message"];
            if ([[NSString nullToString:dicAll[@"errcode"]] intValue] == 0) {
                if([[dicAll objectForKey:@"data"] isKindOfClass:[NSDictionary class]])
                {
                    state = YES;
                }
                else
                {
                    state = NO;
                }
            }
            else
            {
                state = NO;
            }
            if(state==YES)
            {
                callback(error,state,describle,[ShiPinJcShuiChangCamaListModel initDataValue:[[dicAll objectForKey:@"data"] objectForKey:@"list"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
    
}
//// 获取视频播放地址
+ (void)requestShuiChangMoveUrlData:(UIView *)view
         indexCode:(NSString *)indexCode
         streamType:(NSString *)streamType
Callback:(completeCallback)callback
{
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:indexCode forKey:@"indexCode"];
    [dicpush setObject:streamType forKey:@"streamType"];
    NSLog(@"%@",dicpush);
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/hikapi/GetPreviweUrl?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
        BOOL state = NO;
        NSString *describle = @"";
        if (responceObjct==nil) {
            describle = @"网络错误";
        }else{
            NSString *str=[[NSString alloc]initWithData:responceObjct encoding:NSUTF8StringEncoding];
            NSDictionary *dicAll=[str JSONValue];
            describle = dicAll[@"message"];
            if ([[NSString nullToString:dicAll[@"errcode"]] intValue] == 0) {
                if([[dicAll objectForKey:@"data"] isKindOfClass:[NSDictionary class]])
                {
                    state = YES;
                }
                else
                {
                    state = NO;
                }
            }
            else
            {
                state = NO;
            }
            if(state==YES)
            {
                callback(error,state,describle,[[dicAll objectForKey:@"data"] objectForKey:@"url"]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
    
}


@end
