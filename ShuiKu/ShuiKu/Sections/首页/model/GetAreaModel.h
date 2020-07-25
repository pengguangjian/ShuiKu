//
//  GetAreaModel.h
//  ShuiKu
//
//  Created by Mac on 2020/7/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GetAreaModel : NSObject

///
@property (nonatomic , strong) NSString *ID;
///
@property (nonatomic , strong) NSString *NAME;
///
@property (nonatomic , strong) NSString *PARENT_ID;


+(NSMutableArray *)initDataValue:(NSArray *)value;

@end

NS_ASSUME_NONNULL_END
