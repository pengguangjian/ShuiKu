//
//  LiuLiangYJDataController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/21.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LiuLiangYJDataController.h"
#import "HTTPManager.h"
#import "YuJingNewListModel.h"
#import "YuJingRengWuListModel.h"
#import "YuJingRengWuChuZhiJiLuModel.h"

@implementation LiuLiangYJDataController
///最新预警
+ (void)requestZuiXinYuJinGGData:(UIView *)view
       key:(NSString *)key
pageNumber:(int)pageNumber
 Callback:(completeCallback)callback
{
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:[NSString nullToString:key] forKey:@"key"];
    [dicpush setObject:@"100" forKey:@"pageSize"];
    [dicpush setObject:@(pageNumber) forKey:@"pageNumber"];
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/newwarning/GetPage?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
                
                callback(error,state,describle,[YuJingNewListModel initDataValue:[[dicAll objectForKey:@"data"] objectForKey:@"rows"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
    
}
///历史预警
+ (void)requestLiShiYuJinGGData:(UIView *)view
      sTime:(NSString *)sTime
     eTime:(NSString *)eTime
     stcd:(NSString *)stcd
Callback:(completeCallback)callback
{
    
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:[NSString nullToString:sTime] forKey:@"sTime"];
    [dicpush setObject:stcd forKey:@"stcd"];
    [dicpush setObject:eTime forKey:@"eTime"];
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/newwarning/GetItems?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
                
                callback(error,state,describle,[YuJingNewListModel initDataValue:[[dicAll objectForKey:@"data"] objectForKey:@"rows"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
}

////关闭预警
+ (void)requestGuanBiYuJinGGData:(UIView *)view
                             did:(NSString *)did
                       Callback:(completeCallback)callback
{
    
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:[NSString nullToString:did] forKey:@"id"];;
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/newwarning/Delete?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
        BOOL state = NO;
        NSString *describle = @"";
        if (responceObjct==nil) {
            describle = @"网络错误";
        }else{
            NSString *str=[[NSString alloc]initWithData:responceObjct encoding:NSUTF8StringEncoding];
            NSDictionary *dicAll=[str JSONValue];
            describle = dicAll[@"message"];
            if ([[NSString nullToString:dicAll[@"errcode"]] intValue] == 0) {
                state = YES;
            }
            else
            {
                state = NO;
            }
            if(state==YES)
            {
                callback(error,state,describle,nil);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
}

////预警处置
+ (void)requestChuZhiYuJinGGData:(UIView *)view
                             SUGGEST:(NSString *)SUGGEST
                            HANDLER_ID:(NSString *)HANDLER_ID
                            NOTICE:(NSString *)NOTICE
                            DESCRIPTION:(NSString *)DESCRIPTION
                            WARNING_ID:(NSString *)WARNING_ID
                            TASK_LEVEL:(NSString *)TASK_LEVEL
                       Callback:(completeCallback)callback
{
    
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:[NSString nullToString:SUGGEST] forKey:@"SUGGEST"];
    [dicpush setObject:[NSString nullToString:HANDLER_ID] forKey:@"HANDLER_ID"];
    [dicpush setObject:[NSString nullToString:NOTICE] forKey:@"NOTICE"];
    [dicpush setObject:[NSString nullToString:DESCRIPTION] forKey:@"DESCRIPTION"];
    [dicpush setObject:[NSString nullToString:WARNING_ID] forKey:@"WARNING_ID"];
    [dicpush setObject:[NSString nullToString:TASK_LEVEL] forKey:@"TASK_LEVEL"];
    
    
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/newwarning/HandleWarning?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
        BOOL state = NO;
        NSString *describle = @"";
        if (responceObjct==nil) {
            describle = @"网络错误";
        }else{
            NSString *str=[[NSString alloc]initWithData:responceObjct encoding:NSUTF8StringEncoding];
            NSDictionary *dicAll=[str JSONValue];
            describle = dicAll[@"message"];
            if ([[NSString nullToString:dicAll[@"errcode"]] intValue] == 0) {
                state = YES;
            }
            else
            {
                state = NO;
            }
            if(state==YES)
            {
                callback(error,state,describle,nil);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
    
}

/// 获取预警任务分页列表
+ (void)requestYuJingRengWuListData:(UIView *)view
      key:(NSString *)key
     pageNumber:(NSString *)pageNumber
     pageSize:(NSString *)pageSize
Callback:(completeCallback)callback
{
    
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:[NSString nullToString:key] forKey:@"key"];
    [dicpush setObject:@"100" forKey:@"pageSize"];
    [dicpush setObject:pageNumber forKey:@"pageNumber"];
    
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/WarningArrangement/GetPage?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
                
                callback(error,state,describle,[YuJingRengWuListModel initDataValue:[[dicAll objectForKey:@"data"] objectForKey:@"rows"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
    
}

///任务详情（处置记录）
+ (void)requestYuJingRengWuChuZhiJiLuData:(UIView *)view
      ID:(NSString *)ID
Callback:(completeCallback)callback
{
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:[NSString nullToString:ID] forKey:@"id"];
    
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/WarningArrangement/GetTrans?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
        BOOL state = NO;
        NSString *describle = @"";
        if (responceObjct==nil) {
            describle = @"网络错误";
        }else{
            NSString *str=[[NSString alloc]initWithData:responceObjct encoding:NSUTF8StringEncoding];
            NSDictionary *dicAll=[str JSONValue];
            describle = dicAll[@"message"];
            if ([[NSString nullToString:dicAll[@"errcode"]] intValue] == 0) {
                if([[dicAll objectForKey:@"data"] isKindOfClass:[NSArray class]])
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
                
                callback(error,state,describle,[YuJingRengWuChuZhiJiLuModel initDataValue:[dicAll objectForKey:@"data"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
    
}

/// 新增任务处置
+ (void)requestYuJingRengWuChuZhiXinZengData:(UIView *)view
      ID:(NSString *)ID
handler:(NSString *)handler
des:(NSString *)des
Callback:(completeCallback)callback
{
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:[NSString nullToString:ID] forKey:@"id"];
    [dicpush setObject:[NSString nullToString:handler] forKey:@"handler"];
    [dicpush setObject:[[NSString nullToString:des] stringByURLEncode] forKey:@"des"];
    
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/WarningArrangement/HandlerTrans?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
        BOOL state = NO;
        NSString *describle = @"";
        if (responceObjct==nil) {
            describle = @"网络错误";
        }else{
            NSString *str=[[NSString alloc]initWithData:responceObjct encoding:NSUTF8StringEncoding];
            NSDictionary *dicAll=[str JSONValue];
            describle = dicAll[@"message"];
            if ([[NSString nullToString:dicAll[@"errcode"]] intValue] == 0) {
                state = YES;
            }
            else
            {
                state = NO;
            }
            if(state==YES)
            {
                
                callback(error,state,describle,nil);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
    
}
/// 关闭预警（办结）
+ (void)requestYuJingRengWuChuZhiBanJieData:(UIView *)view
      ID:(NSString *)ID
Callback:(completeCallback)callback
{
    
    
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:[NSString nullToString:ID] forKey:@"id"];

    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/WarningArrangement/CloseTask?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
        BOOL state = NO;
        NSString *describle = @"";
        if (responceObjct==nil) {
            describle = @"网络错误";
        }else{
            NSString *str=[[NSString alloc]initWithData:responceObjct encoding:NSUTF8StringEncoding];
            NSDictionary *dicAll=[str JSONValue];
            describle = dicAll[@"message"];
            if ([[NSString nullToString:dicAll[@"errcode"]] intValue] == 0) {
                state = YES;
            }
            else
            {
                state = NO;
            }
            if(state==YES)
            {
                
                callback(error,state,describle,nil);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
}

@end
