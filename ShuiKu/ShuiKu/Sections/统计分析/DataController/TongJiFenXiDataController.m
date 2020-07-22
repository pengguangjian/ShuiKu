
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
@implementation TongJiFenXiDataController
 ////流量分析  type 0日 1月 2年
+ (void)requestLiuLiangFenXiData:(UIView *)view
                                date:(NSString *)date
                                type:(int)type
                       Callback:(completeCallback)callback
{
    
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[UserInfoModel sharedUserInfo].SessionId] forKey:@"SessionId"];
    [dicpush setObject:date forKey:@"date"];

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
@end
