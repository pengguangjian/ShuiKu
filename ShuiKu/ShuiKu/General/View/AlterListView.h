//
//  AlterListView.h
//  ZHProperty
//
//  Created by Mac on 2020/7/16.
//  Copyright © 2020 yx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AlterListViewDelegate <NSObject>

-(void)ListAlterViewItemSelect:(id)value andviewtag:(NSInteger)tag;

@end

@interface AlterListView : UIView
@property (nonatomic , weak) id<AlterListViewDelegate>delegate;
@property (nonatomic , strong) NSString *strtitle;
///选项NSString
@property (nonatomic , strong) NSArray *arrdata;

@end

NS_ASSUME_NONNULL_END
