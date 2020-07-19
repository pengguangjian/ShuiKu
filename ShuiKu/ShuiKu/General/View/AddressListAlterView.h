//
//  AddressListAlterView.h
//  ZHProperty
//
//  Created by Mac on 2020/7/16.
//  Copyright © 2020 yx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AddressListAlterViewDelegate <NSObject>
///返回选中的数组
-(void)backAddressListAlterViewArr:(NSMutableArray *)arrvalue;

@end

@interface AddressListAlterView : UIView

@property (nonatomic , weak) id<AddressListAlterViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
