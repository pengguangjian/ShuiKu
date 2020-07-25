//
//  YuJingRengWuListModel.h
//  ShuiKu
//
//  Created by Mac on 2020/7/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuJingRengWuListModel : NSObject
///
@property (nonatomic , strong) NSString *ID;
///任务类型，1 一般任务，2  事件处置，3 预警处置
@property (nonatomic , strong) NSString *TASK_TYPE;
///任务等级， 1 一般; 2 较急; 3 紧急; 4 特急
@property (nonatomic , strong) NSString *TASK_LEVEL;
///任务描述
@property (nonatomic , strong) NSString *DESCRIPTION;
///处理建议
@property (nonatomic , strong) NSString *SUGGEST;
///处置人
@property (nonatomic , strong) NSString *HANDLER;
///创建时间
@property (nonatomic , strong) NSString *CREATEDTIME;
///状态 0：正在处置 1：处置完成
@property (nonatomic , strong) NSString *STATUS;
///创建人
@property (nonatomic , strong) NSString *CREATOR;


+(NSMutableArray *)initDataValue:(NSArray *)value;

@end

NS_ASSUME_NONNULL_END
