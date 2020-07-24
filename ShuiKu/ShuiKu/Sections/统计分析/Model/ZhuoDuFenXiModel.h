//
//  ZhuoDuFenXiModel.h
//  ShuiKu
//
//  Created by Mac on 2020/7/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZhuoDuFenXiModel : NSObject
///04 进水  14出水
@property (nonatomic , strong) NSString *s_type;
///年份
@property (nonatomic , strong) NSString *s_time;
///最大
@property (nonatomic , strong) NSString *max_TURB;
///最小
@property (nonatomic , strong) NSString *min_TURB;



+(NSMutableArray *)initDataValue:(NSArray *)value;
@end

NS_ASSUME_NONNULL_END
