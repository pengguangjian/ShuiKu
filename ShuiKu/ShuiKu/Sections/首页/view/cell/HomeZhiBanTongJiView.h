//
//  HomeZhiBanTongJiView.h
//  ShuiKu
//
//  Created by Mac on 2020/7/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HomeZhiBanTongJiViewDelegate <NSObject>
///返回值班信息model
-(void)selectZhiBanInfoModel:(id)model;

@end
@interface HomeZhiBanTongJiView : UIView

@property (nonatomic , weak) id<HomeZhiBanTongJiViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
