

//
//  LiuLiangJCDataController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/21.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LiuLiangJCDataController.h"
#import "HTTPManager.h"
#import "LiuLiangJCListModel.h"
@implementation LiuLiangJCDataController
///流量监测列表
+ (void)requestLiuLiangJianCheListData:(UIView *)view
                                key:(NSString *)key
                                pageNumber:(int)pageNumber
                       Callback:(completeCallback)callback
{
    
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:@"10" forKey:@"pageSize"];
    [dicpush setObject:@(pageNumber) forKey:@"pageNumber"];
    [dicpush setObject:[key stringByURLEncode] forKey:@"key"];
    NSLog(@"%@",dicpush);
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/flow/GetPage?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
                callback(error,state,describle,[LiuLiangJCListModel initDataValue:[dicAll objectForKey:@"data"]]);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
    
}

///详情  ccbt_zhgs/api/flow/GetEchartsData?
+ (void)requestLiuLiangJianCheXiangQingData:(UIView *)view
         sTime:(NSString *)sTime
         eTime:(int)eTime
         stcd:(NSString *)stcd
Callback:(completeCallback)callback
{
    
    
}
@end
