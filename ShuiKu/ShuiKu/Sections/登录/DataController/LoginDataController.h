//
//  LoginDataController.h
//  ShuiKu
//
//  Created by Mac on 2020/7/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginDataController : NSObject

/*
 登录
 username 账号
 password 密码
 */
+ (void)requestLoginData:(NSString *)username
                           password:(NSString *)password
                            showview:(UIView *)view
                       Callback:(completeCallback)callback;

/*
 退出登录
 http://222.180.173.75:7118/ccbt_zhgs/api/auth/logout?SessionId=LTuHNNSy5Dd8tEsJ_aBG2Q%3D%3D
 */
/// 退出登录
+ (void)requestLoginOutData:(UIView *)view
Callback:(completeCallback)callback;

/*
 http://222.180.173.75:7118/ccbt_zhgs/api/user/ResetPassword?ID=C2F28C23D76B4375B67DE2BAD55AAB0F&SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&NEW_PASSWORD=3170B8A24015CB425F9DBF484B869C3A777530B7&OLD_PASSWORD=9FAEAD783DB73758AEB3E7000711CE62F506334F
 重设密码
 */
/// 重设密码
+ (void)requestChangePasswordData:(UIView *)view
NEW_PASSWORD:(NSString *)NEW_PASSWORD
OLD_PASSWORD:(NSString *)OLD_PASSWORD
ID:(NSString *)ID
Callback:(completeCallback)callback;

@end

NS_ASSUME_NONNULL_END
