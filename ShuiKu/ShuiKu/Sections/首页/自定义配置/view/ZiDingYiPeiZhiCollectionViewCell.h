//
//  ZiDingYiPeiZhiCollectionViewCell.h
//  ShuiKu
//
//  Created by Mac on 2020/7/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "HomeCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ZiDingYiPeiZhiCollectionViewCelltAction)(void);

@interface ZiDingYiPeiZhiCollectionViewCell : HomeCollectionViewCell

@property (nonatomic , strong) ZiDingYiPeiZhiCollectionViewCelltAction btaction;

@property (nonatomic , assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END
