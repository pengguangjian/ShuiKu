//
//  TimeClectAlterView.m
//  ZHProperty
//
//  Created by Mac on 2020/7/16.
//  Copyright © 2020 yx. All rights reserved.
//

#import "TimeClectAlterView.h"
#import "PGGDataStartAndEndPickView.h"
@interface TimeClectAlterView ()<PGGDataStartAndEndPickViewDelegate>

@end

@implementation TimeClectAlterView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:RGBAlpha(0, 0, 0, 0.4)];
        
        
        PGGDataStartAndEndPickView *view = [[PGGDataStartAndEndPickView alloc] init];
        view.iline = 3;
        view.isNotnowtime = NO;
        [view setDegelate:self];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.offset(280);
        }];
        
        
    }
    return self;
}
///返回值
-(void)changetimeValue:(NSString *)strvalue
{
    if(self.deletate)
    {
        [self.deletate changetimeValue:strvalue];
    }
    [self removeFromSuperview];
}

-(void)dismisAction
{
    [self removeFromSuperview];
}

@end
