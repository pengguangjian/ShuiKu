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

@end

NS_ASSUME_NONNULL_END
