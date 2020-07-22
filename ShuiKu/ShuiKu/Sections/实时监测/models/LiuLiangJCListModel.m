//
//  LiuLiangJCListModel.m
//  ShuiKu
//
//  Created by Mac on 2020/7/21.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LiuLiangJCListModel.h"

@implementation LiuLiangJCListModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"rows": [LiuLiangJCListRowModel class]};
    
}
+(LiuLiangJCListModel *)initDataValue:(NSDictionary *)value
{
    
    return [WYTools initDicValue:value andclassname:@"LiuLiangJCListModel"];
}
@end

@implementation LiuLiangJCListRowModel


@end



