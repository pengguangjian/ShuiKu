
//
//  TongJiFenXiDataController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/22.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "TongJiFenXiDataController.h"
#import "HTTPManager.h"
#import "LiuLiangFenXiModel.h"
#import "ZhuoDuFenXiModel.h"
#import "YuLvFenXiModel.h"
#import "PHZhiFenXiModel.h"
#import "WenDuFenXiModel.h"
#import "YuJingFenXiModel.h"
#import "CeDianFenXiModel.h"
@implementation TongJiFenXiDataController
 ////流量分析  type 0日 1月 2年
+ (void)requestLiuLiangFenXiData:(UIView *)view
                                date:(NSString *)date
                                type:(int)type
                                stcd:(NSString *)stcd
                       Callback:(completeCallback)callback
{
    
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:date forKey:@"date"];
    [dicpush setObject:[NSString nullToString:stcd] forKey:@"stcd"];
    NSString *strurl = @"ccbt_zhgs/api/FlowStatistic/GetEchartsDataByDay?";
    if(type==1)
    {
        strurl = @"ccbt_zhgs/api/FlowStatistic/GetEchartsDataByMonth?";
    }
    else if (type==2)
    {
        strurl = @"ccbt_zhgs/api/FlowStatistic/GetEchartsDataByYear?";
    }
    
    
    NSLog(@"%@",dicpush);
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@%@",URL_HR,strurl] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
                callback(error,state,describle,[LiuLiangFenXiModel initDataValue:[[dicAll objectForKey:@"data"] objectForKey:@"rows"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
}
/// 浊度分析
+ (void)requestZhuoDuFenXiData:(UIView *)view
         date:(NSString *)date
         type:(int)type
         stcd:(NSString *)stcd
Callback:(completeCallback)callback
{
    
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:date forKey:@"date"];
    [dicpush setObject:[NSString nullToString:stcd] forKey:@"stcd"];
    NSString *strurl = @"ccbt_zhgs/api/TurbStatistic/GetEchartsDataByDay?";
    if(type==1)
    {
        strurl = @"ccbt_zhgs/api/TurbStatistic/GetEchartsDataByMonth?";
    }
    else if (type==2)
    {
        strurl = @"ccbt_zhgs/api/TurbStatistic/GetEchartsDataByYear?";
    }
    
    
    NSLog(@"%@",dicpush);
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@%@",URL_HR,strurl] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
                callback(error,state,describle,[ZhuoDuFenXiModel initDataValue:[[dicAll objectForKey:@"data"] objectForKey:@"rows"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
}
/// 余氯分析
+ (void)requestYuLvFenXiData:(UIView *)view
         date:(NSString *)date
         type:(int)type
         stcd:(NSString *)stcd
Callback:(completeCallback)callback
{
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:date forKey:@"date"];
    [dicpush setObject:[NSString nullToString:stcd] forKey:@"stcd"];
    NSString *strurl = @"ccbt_zhgs/api/ClStatistic/GetEchartsDataByDay?";
    if(type==1)
    {
        strurl = @"ccbt_zhgs/api/ClStatistic/GetEchartsDataByMonth?";
    }
    else if (type==2)
    {
        strurl = @"ccbt_zhgs/api/ClStatistic/GetEchartsDataByYear?";
    }
    
    
    NSLog(@"%@",dicpush);
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@%@",URL_HR,strurl] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
                callback(error,state,describle,[YuLvFenXiModel initDataValue:[[dicAll objectForKey:@"data"] objectForKey:@"rows"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
}
/// PH分析
+ (void)requestPHZhiFenXiData:(UIView *)view
         date:(NSString *)date
         type:(int)type
         stcd:(NSString *)stcd
Callback:(completeCallback)callback
{
    
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:date forKey:@"date"];
    [dicpush setObject:[NSString nullToString:stcd] forKey:@"stcd"];
    NSString *strurl = @"ccbt_zhgs/api/PhStatistic/GetEchartsDataByDay?";
    if(type==1)
    {
        strurl = @"ccbt_zhgs/api/PhStatistic/GetEchartsDataByMonth?";
    }
    else if (type==2)
    {
        strurl = @"ccbt_zhgs/api/PhStatistic/GetEchartsDataByYear?";
    }
    
    
    NSLog(@"%@",dicpush);
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@%@",URL_HR,strurl] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
                callback(error,state,describle,[PHZhiFenXiModel initDataValue:[[dicAll objectForKey:@"data"] objectForKey:@"rows"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
}
/// 温度分析
+ (void)requestWenDuFenXiData:(UIView *)view
         date:(NSString *)date
         type:(int)type
         stcd:(NSString *)stcd
Callback:(completeCallback)callback
{
    
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:date forKey:@"date"];
    [dicpush setObject:[NSString nullToString:stcd] forKey:@"stcd"];
    NSString *strurl = @"ccbt_zhgs/api/WtStatistic/GetEchartsDataByDay?";
    if(type==1)
    {
        strurl = @"ccbt_zhgs/api/WtStatistic/GetEchartsDataByMonth?";
    }
    else if (type==2)
    {
        strurl = @"ccbt_zhgs/api/WtStatistic/GetEchartsDataByYear?";
    }
    
    
    NSLog(@"%@",dicpush);
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@%@",URL_HR,strurl] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
                callback(error,state,describle,[WenDuFenXiModel initDataValue:[[dicAll objectForKey:@"data"] objectForKey:@"rows"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
}
/// 监测预警统计
+ (void)requestYuJingFenXiData:(UIView *)view
         date:(NSString *)date
         type:(int)type
         stcd:(NSString *)stcd
Callback:(completeCallback)callback
{
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:date forKey:@"date"];
    [dicpush setObject:[NSString nullToString:stcd] forKey:@"stcd"];
    NSString *strurl = @"ccbt_zhgs/api/WarningStatistic/GetEchartsDataByDay?";
    if(type==1)
    {
        strurl = @"ccbt_zhgs/api/WarningStatistic/GetEchartsDataByMonth?";
    }
    else if (type==2)
    {
        strurl = @"ccbt_zhgs/api/WarningStatistic/GetEchartsDataByYear?";
    }
    
    
    NSLog(@"%@",dicpush);
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@%@",URL_HR,strurl] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
                callback(error,state,describle,[YuJingFenXiModel initDataValue:[[dicAll objectForKey:@"data"] objectForKey:@"rows"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
}
/// 测站统计
+ (void)requestCeDianFenXiData:(UIView *)view
         date:(NSString *)date
         type:(int)type
         stcd:(NSString *)stcd
Callback:(completeCallback)callback
{
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:date forKey:@"date"];
    [dicpush setObject:[NSString nullToString:stcd] forKey:@"stcd"];
    NSString *strurl = @"ccbt_zhgs/api/StationStatistic/GetEchartsDataByDay?";
    if(type==1)
    {
        strurl = @"ccbt_zhgs/api/StationStatistic/GetEchartsDataByMonth?";
    }
    else if (type==2)
    {
        strurl = @"ccbt_zhgs/api/StationStatistic/GetEchartsDataByYear?";
    }
    
    
    NSLog(@"%@",dicpush);
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@%@",URL_HR,strurl] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
                callback(error,state,describle,[CeDianFenXiModel initDataValue:[[dicAll objectForKey:@"data"] objectForKey:@"rows"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
}

@end
