
//
//  MainHomeDataController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MainHomeDataController.h"
#import "HTTPManager.h"
#import "RenYuanXinXiModel.h"
#import "ZhiBanInfoModel.h"
#import "ZhiBanXiangQingModel.h"
#import "GetAreaModel.h"
#import "ShuiChangListModel.h"
#import "CeZhanListModel.h"
#import "MainHomeChaoBiaoInfoModel.h"


@implementation MainHomeDataController
///水厂的弹窗
+ (void)requestShuiChangAlterData:(UIView *)view
                         parentId:(NSString *)parentId
                         Callback:(completeCallback)callback
{
    
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:parentId forKey:@"parentId"];
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/DataManagement/GetArea?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
                callback(error,state,describle,[GetAreaModel initDataValue:[dicAll objectForKey:@"data"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
}


/*
 首页通知公告
 */
+ (void)requestTongZhiGongGGData:(UIView *)view
                       Callback:(completeCallback)callback
{
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:@"3" forKey:@"pageSize"];
    [dicpush setObject:@"1" forKey:@"pageNumber"];
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/InfoManage/GetAPPNotice?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
                callback(error,state,describle,[dicAll objectForKey:@"data"]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
    
}

/*
获取联系人用户信息
 */
+ (void)requestUserListData:(UIView *)view
                        Callback:(completeCallback)callback
{
    
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/newwarning/GetUserData?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
                callback(error,state,describle,[RenYuanXinXiModel initDataValue:[[dicAll objectForKey:@"data"] objectForKey:@"rows"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
}

/// 值班统计
+ (void)requestZhiBanTongJiData:(UIView *)view
enddate:(NSString *)enddate
startdate:(NSString *)startdate
Callback:(completeCallback)callback
{
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:enddate forKey:@"enddate"];
    [dicpush setObject:startdate forKey:@"startdate"];
    
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/DutyManage/DutyStatistic?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
                callback(error,state,describle,[ZhiBanInfoModel initDataValue:[[dicAll objectForKey:@"data"] objectForKey:@"rows"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
    
}

///值班详情
+ (void)requestZhiBanXiangqingData:(UIView *)view
DUTYTIME:(NSString *)DUTYTIME
Callback:(completeCallback)callback
{
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:DUTYTIME forKey:@"DUTYTIME"];
    
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/DutyManage/GetRecord?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
                callback(error,state,describle,[ZhiBanXiangQingModel initDataValue:[[dicAll objectForKey:@"data"] objectForKey:@"rows"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
}

///水厂列表
+ (void)requestShuiChangListData:(UIView *)view
xzqhbm:(NSString *)xzqhbm
key:(NSString *)key
pageNumber:(int)pageNumber
Callback:(completeCallback)callback
{
    
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:xzqhbm forKey:@"xzqhbm"];
    [dicpush setObject:key forKey:@"key"];
    [dicpush setObject:@(pageNumber) forKey:@"pageNumber"];
    [dicpush setObject:@"200" forKey:@"pageSize"];
    
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/waterwork/GetPage?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
                callback(error,state,describle,[ShuiChangListModel initDataValue:[[dicAll objectForKey:@"data"] objectForKey:@"rows"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
}
/// 监测点列表
+ (void)requestCeDianListData:(UIView *)view
xzqhbm:(NSString *)xzqhbm
key:(NSString *)key
pageNumber:(int)pageNumber
Callback:(completeCallback)callback
{
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:xzqhbm forKey:@"xzqhbm"];
    [dicpush setObject:key forKey:@"key"];
    [dicpush setObject:@(pageNumber) forKey:@"pageNumber"];
    [dicpush setObject:@"200" forKey:@"pageSize"];
    
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/StationManage/GetPage?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
                callback(error,state,describle,[CeZhanListModel initDataValue:[[dicAll objectForKey:@"data"] objectForKey:@"rows"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
    
}

///首页超标数据及列表
+ (void)requestChaoBiaoListData:(UIView *)view
type:(NSString *)type
Callback:(completeCallback)callback
{
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    NSString *strurl = @"";
    if(type.intValue == 1)
    {
        strurl = @"ccbt_zhgs/api/home/GetFLowData?";
    }
    else if(type.intValue == 2)
    {//http://183.230.114.158:8678/ccbt_zhgs/api/home/GetTurbData?SessionId=EwmQtH4kxZklics9KyMePw%3D%3D
        strurl = @"ccbt_zhgs/api/home/GetTurbData?";
    }
    else if(type.intValue == 3)
    {///http://183.230.114.158:8678/ccbt_zhgs/api/home/GetClData?SessionId=EwmQtH4kxZklics9KyMePw%3D%3D
        strurl = @"ccbt_zhgs/api/home/GetClData?";
    }
    else if(type.intValue == 4)
    {///http://183.230.114.158:8678/ccbt_zhgs/api/home/GetPhData?SessionId=EwmQtH4kxZklics9KyMePw%3D%3D
        strurl = @"ccbt_zhgs/api/home/GetPhData?";
    }
    else if(type.intValue == 5)
    {///http://183.230.114.158:8678/ccbt_zhgs/api/home/GetWtData?SessionId=EwmQtH4kxZklics9KyMePw%3D%3D
        strurl = @"ccbt_zhgs/api/home/GetWtData?";
    }
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@%@",URL_HR,strurl] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
        BOOL state = NO;
        NSString *describle = @"";
        if (responceObjct==nil) {
            describle = @"网络错误";
        }else{
            NSString *str=[[NSString alloc]initWithData:responceObjct encoding:NSUTF8StringEncoding];
            NSDictionary *dicAll=[str JSONValue];
            describle = dicAll[@"message"];
            NSLog(@"pgj=%@",dicAll);
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
                callback(error,state,describle,[MainHomeChaoBiaoInfoModel initDataValue:[[dicAll objectForKey:@"data"] objectForKey:@"rows"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
    
}

///扫码授权
+ (void)requestScanCodeData:(UIView *)view
sign:(NSString *)sign
client:(NSString *)client
time:(NSString *)time
Callback:(completeCallback)callback
{
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:[NSString stringWithFormat:@"1001"] forKey:@"type"];
    [dicpush setObject:[NSString stringWithFormat:@"%@",sign] forKey:@"sign"];
    [dicpush setObject:[NSString stringWithFormat:@"%@",client] forKey:@"client"];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[time stringByURLEncode]] forKey:@"time"];
     
     
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/auth/ScanCode?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
        BOOL state = NO;
        NSString *describle = @"";
        if (responceObjct==nil) {
            describle = @"网络错误";
        }else{
            NSString *str=[[NSString alloc]initWithData:responceObjct encoding:NSUTF8StringEncoding];
            NSDictionary *dicAll=[str JSONValue];
            describle = dicAll[@"message"];
            NSLog(@"pgj=%@",dicAll);
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
