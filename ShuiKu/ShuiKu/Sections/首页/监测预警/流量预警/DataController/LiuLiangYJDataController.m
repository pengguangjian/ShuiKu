//
//  LiuLiangYJDataController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/21.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LiuLiangYJDataController.h"
#import "HTTPManager.h"
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
    [dicpush setObject:@"10" forKey:@"pageSize"];
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
                callback(error,state,describle,[dicAll objectForKey:@"data"]);
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

@end
