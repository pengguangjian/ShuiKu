//
//  MainHomeChaoBiaoInfoModel.h
//  ShuiKu
//
//  Created by Mac on 2020/7/27.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainHomeChaoBiaoInfoModel : NSObject
///数量
@property (nonatomic , strong) NSString *CBCS;
///
@property (nonatomic , strong) NSString *CODE;

///
@property (nonatomic , strong) NSString *NAME;



+(NSMutableArray *)initDataValue:(NSArray *)value;
@end

NS_ASSUME_NONNULL_END
