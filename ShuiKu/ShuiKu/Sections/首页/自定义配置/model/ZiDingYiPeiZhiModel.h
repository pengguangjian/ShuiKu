//
//  ZiDingYiPeiZhiModel.h
//  ShuiKu
//
//  Created by Mac on 2020/7/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZiDingYiPeiZhiModel : NSObject

@property (nonatomic , strong) NSString *name;
///状态 0无 1+ 2- 3勾
@property (nonatomic , assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END
