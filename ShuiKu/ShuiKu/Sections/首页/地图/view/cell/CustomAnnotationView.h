//
//  CustomAnnotationView.h
//  WisdomSchool
//
//  Created by Resuming on 2018/11/4.
//  Copyright © 2018年 Resuming. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"

@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, readonly) CustomCalloutView *calloutView;

@end
