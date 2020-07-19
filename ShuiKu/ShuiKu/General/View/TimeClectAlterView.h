//
//  TimeClectAlterView.h
//  ZHProperty
//
//  Created by Mac on 2020/7/16.
//  Copyright © 2020 yx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TimeClectAlterViewDelegate <NSObject>
///开始时间-结束时间
-(void)changetimeValue:(NSString *)strvalue;

@end

@interface TimeClectAlterView : UIView

@property (nonatomic , weak) id<TimeClectAlterViewDelegate>deletate;

@end

NS_ASSUME_NONNULL_END
