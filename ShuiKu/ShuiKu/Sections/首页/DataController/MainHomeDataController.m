
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
@implementation MainHomeDataController

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

@end
