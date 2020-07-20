
//
//  UserInfoModel.m
//  ZHProperty
//
//  Created by Mac on 2020/7/20.
//  Copyright © 2020 yx. All rights reserved.
//

#import "UserInfoModel.h"

static UserInfoModel *userinfomodel;

@implementation UserInfoModel
+(UserInfoModel *)sharedUserInfo
{
    if(userinfomodel==nil)
    {
        ///shuku
        userinfomodel = [[UserInfoModel alloc] init];
        userinfomodel.SessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"shukuSessionId"];
        userinfomodel.uArea = [[NSUserDefaults standardUserDefaults] objectForKey:@"shukuuArea"];
        userinfomodel.uCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"shukuuCode"];
        userinfomodel.uID = [[NSUserDefaults standardUserDefaults] objectForKey:@"shukuuID"];
        userinfomodel.uJob = [[NSUserDefaults standardUserDefaults] objectForKey:@"shukuuJob"];
        userinfomodel.uName = [[NSUserDefaults standardUserDefaults] objectForKey:@"shukuuName"];
        userinfomodel.uPhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"shukuuPhone"];
        userinfomodel.uSex = [[NSUserDefaults standardUserDefaults] objectForKey:@"shukuuSex"];
        userinfomodel.uType = [[NSUserDefaults standardUserDefaults] objectForKey:@"shukuuType"];
        userinfomodel.uUnit = [[NSUserDefaults standardUserDefaults] objectForKey:@"shukuuUnit"];
        
        
    }
    
    return userinfomodel;
}

///设置信息
-(void)setuserinfo:(NSDictionary *)dicvalue
{
    self.SessionId = [NSString nullToString:[dicvalue objectForKey:@"SessionId"]];
    NSDictionary *dicdata = [dicvalue objectForKey:@"data"];
    self.uArea = [NSString nullToString:[dicdata objectForKey:@"uArea"]];
    self.uCode = [NSString nullToString:[dicdata objectForKey:@"uCode"]];
    self.uID = [NSString nullToString:[dicdata objectForKey:@"uID"]];
    self.uJob = [NSString nullToString:[dicdata objectForKey:@"uJob"]];
    self.uName = [NSString nullToString:[dicdata objectForKey:@"uName"]];
    self.uPhone = [NSString nullToString:[dicdata objectForKey:@"uPhone"]];
    self.uSex = [NSString nullToString:[dicdata objectForKey:@"uSex"]];
    self.uType = [NSString nullToString:[dicdata objectForKey:@"uType"]];
    self.uUnit = [NSString nullToString:[dicdata objectForKey:@"uUnit"]];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:self.SessionId forKey:@"shukuSessionId"];
    [[NSUserDefaults standardUserDefaults] setObject:self.uArea forKey:@"shukuuArea"];
    [[NSUserDefaults standardUserDefaults] setObject:self.uCode forKey:@"shukuuCode"];
    [[NSUserDefaults standardUserDefaults] setObject:self.uID forKey:@"shukuuID"];
    [[NSUserDefaults standardUserDefaults] setObject:self.uJob forKey:@"shukuuJob"];
    [[NSUserDefaults standardUserDefaults] setObject:self.uName forKey:@"shukuuName"];
    [[NSUserDefaults standardUserDefaults] setObject:self.uPhone forKey:@"shukuuPhone"];
    [[NSUserDefaults standardUserDefaults] setObject:self.uSex forKey:@"shukuuSex"];
    [[NSUserDefaults standardUserDefaults] setObject:self.uType forKey:@"shukuuType"];
    [[NSUserDefaults standardUserDefaults] setObject:self.uUnit forKey:@"shukuuUnit"];
}
///退出登录
-(void)loginOut
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shukuSessionId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shukuuArea"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shukuuCode"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shukuuID"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shukuuJob"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shukuuName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shukuuPhone"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shukuuSex"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shukuuType"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shukuuUnit"];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"userislogin"];
}


@end
