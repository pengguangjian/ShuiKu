//
//  ZhiShiKuDataController.h
//  ShuiKu
//
//  Created by Mac on 2020/7/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZhiShiKuDataController : NSObject
/*
知识库分类
 http://222.180.173.75:7118/ccbt_zhgs/api/RepositoryManage/GetKBType?SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D
 */
///知识库分类
+ (void)requestZhiShiKuFenLeiData:(UIView *)view
                       Callback:(completeCallback)callback;

/*
知识库列表
 http://222.180.173.75:7118/ccbt_zhgs/api/RepositoryManage/GetPage?infotype=1&SessionId=SZlT6vEL7FxL3FyUgjdNWQ%3D%3D&pageNumber=1&pageSize=10
 */
///知识库列表
+ (void)requestTongZhiGongLieBiaoData:(UIView *)view
                        infotype:(NSString *)infotype
                        pageNumber:(int)pageNumber
                       Callback:(completeCallback)callback;

@end

NS_ASSUME_NONNULL_END
