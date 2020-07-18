//
//  RightBtnSXView.h
//  ShuiKu
//  水厂信息和测站信息筛选页面
//  Created by Mac on 2020/7/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RightBtnSXViewDelegate <NSObject>
///搜索
-(void)serachValueText:(NSString *)strzi andaddress:(NSString *)address;
///页面消失
-(void)dismisView;

@end
@interface RightBtnSXView : UIView

@property (nonatomic , weak) id<RightBtnSXViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
