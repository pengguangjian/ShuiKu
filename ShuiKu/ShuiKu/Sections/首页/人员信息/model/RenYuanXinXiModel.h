//
//  RenYuanXinXiModel.h
//  ShuiKu
//  人员信息
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RenYuanXinXiModel : NSObject

@property (nonatomic , assign) BOOL isselect;
@property (nonatomic , strong) NSString *ID;
@property (nonatomic , strong) NSString *USER_NAME;
@property (nonatomic , strong) NSString *CELLPHONE;

+(NSMutableArray *)initDataValue:(NSArray *)value;


@end

NS_ASSUME_NONNULL_END
