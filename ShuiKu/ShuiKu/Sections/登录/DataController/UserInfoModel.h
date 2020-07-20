//
//  UserInfoModel.h
//  ZHProperty
//
//  Created by Mac on 2020/7/20.
//  Copyright © 2020 yx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : NSObject

@property (nonatomic , retain) NSString *SessionId;
@property (nonatomic , retain) NSString *uArea;
@property (nonatomic , retain) NSString *uCode;

@property (nonatomic , retain) NSString *uID;
@property (nonatomic , retain) NSString *uJob;
@property (nonatomic , retain) NSString *uName;
@property (nonatomic , retain) NSString *uPhone;
@property (nonatomic , retain) NSString *uSex;
@property (nonatomic , retain) NSString *uType;
@property (nonatomic , retain) NSString *uUnit;


+(UserInfoModel *)sharedUserInfo;

///设置信息
-(void)setuserinfo:(NSDictionary *)dicvalue;

///退出登录
-(void)loginOut;

@end

NS_ASSUME_NONNULL_END
