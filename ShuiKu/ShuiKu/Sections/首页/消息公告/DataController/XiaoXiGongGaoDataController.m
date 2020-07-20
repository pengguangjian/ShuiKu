

//
//  XiaoXiGongGaoDataController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "XiaoXiGongGaoDataController.h"
#import "HTTPManager.h"


@implementation XiaoXiGongGaoDataController
/*
通知公告分类
 http://222.180.173.75:7118/ccbt_zhgs/api/InfoManage/GetNewType?SessionId=mfm9-Eei_I64cKnfExBYSQ%3D%3D
 */
+ (void)requestTongZhiGongFenLeiData:(UIView *)view
                       Callback:(completeCallback)callback
{
    
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/InfoManage/GetNewType?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
通知公告列表
 http://222.180.173.75:7118/ccbt_zhgs/api/InfoManage/GetAPPNotice?SessionId=mfm9-Eei_I64cKnfExBYSQ%3D%3D&NewType=1&pageNumber=1&pageSize=10
 */
+ (void)requestTongZhiGongLieBiaoData:(UIView *)view
                        NewType:(NSString *)NewType
                        pageNumber:(int)pageNumber
                       Callback:(completeCallback)callback
{
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:@"10" forKey:@"pageSize"];
    [dicpush setObject:@(pageNumber) forKey:@"pageNumber"];
    [dicpush setObject:NewType forKey:@"NewType"];
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
通知公告详情
 http://222.180.173.75:7118/ccbt_zhgs/api/InfoManage/GetItem?id=3
 */
+ (void)requestTongZhiGongXiangQingData:(UIView *)view
                        gid:(NSString *)gid
                       Callback:(completeCallback)callback
{
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:gid forKey:@"id"];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/InfoManage/GetItem?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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


@end
