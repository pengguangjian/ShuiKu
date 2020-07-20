
//
//  LoginDataController.m
//  ShuiKu
//
//  Created by Mac on 2020/7/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LoginDataController.h"
#import "HTTPManager.h"
@implementation LoginDataController

/*
 登录
 username 账号
 password 密码
 */
+ (void)requestLoginData:(NSString *)username
                           password:(NSString *)password
                            showview:(UIView *)view
                       Callback:(completeCallback)callback
{
    NSMutableDictionary  *dicpush = [NSMutableDictionary new];
    [dicpush setObject:[NSString stringWithFormat:@"%@",username] forKey:@"user"];
    [dicpush setObject:[NSString stringWithFormat:@"%@",[WYTools stringWithSha1Encode:password]] forKey:@"pswd"];
    
    [HTTPManager sendRequestUrlToService:[NSString stringWithFormat:@"%@ccbt_zhgs/api/auth/login?",URL_HR] withParametersDictionry:dicpush view:view completeHandle:^(NSURLSessionTask *opration, id responceObjct, NSError *error) {
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
                callback(error,state,describle,dicAll);
            }
        }
        if(state==NO)
        {
            callback(error,state,describle,nil);
        }
    }];
    
}

@end
