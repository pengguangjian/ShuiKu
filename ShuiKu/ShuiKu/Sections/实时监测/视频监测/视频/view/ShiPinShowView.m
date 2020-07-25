//
//  ShiPinShowView.m
//  ShuiKu
//
//  Created by Mac on 2020/7/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ShiPinShowView.h"
#import "PGGMoviePlayer.h"

#import "AppDelegate.h"

@interface ShiPinShowView ()<PGGMoviePlayerDelegate>
@property (nonatomic , strong) UIImageView *imgvback;
@property (nonatomic , strong) UILabel *lbtitle;
@property (nonatomic , strong) PGGMoviePlayer *playerview;
@property (nonatomic , strong) NSString *strplayerurl;
@end

@implementation ShiPinShowView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UIImageView *imgv = [[UIImageView alloc] init];
        [imgv setBackgroundColor:[UIColor grayColor]];
        [self addSubview:imgv];
        [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.offset(kMainScreenW);
        }];
        _imgvback = imgv;
        
        
        UIButton *btplay = [[UIButton alloc] init];
        [btplay setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
        [self addSubview:btplay];
        [btplay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.offset(60);
            make.center.equalTo(imgv);
        }];
        [btplay addTarget:self action:@selector(bofangAction) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lbtitle = [[UILabel alloc] init];
        [lbtitle setTextColor:RGB(30, 30, 30)];
        [lbtitle setTextAlignment:NSTextAlignmentLeft];
        [lbtitle setFont:[UIFont systemFontOfSize:15]];
        [lbtitle setNumberOfLines:2];
        [self addSubview:lbtitle];
        [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.equalTo(imgv.mas_bottom).offset(15);
            make.right.equalTo(self).offset(-10);
        }];
        _lbtitle = lbtitle;
        
        UIButton *btquanping = [[UIButton alloc] init];
        [btquanping setTitle:@"全屏查看" forState:UIControlStateNormal];
        [btquanping setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btquanping.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [btquanping.layer setMasksToBounds:YES];
        [btquanping.layer setCornerRadius:2];
        [btquanping setBackgroundColor:RGB(73, 72, 76)];
        [self addSubview:btquanping];
        [btquanping mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.top.equalTo(lbtitle.mas_bottom).offset(20);
            make.height.offset(40);
            make.width.offset(70);
        }];
        [btquanping addTarget:self action:@selector(bofangAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [_lbtitle setText:self.strtitle];
    
}

-(void)bofangAction
{
    if(self.strplayerurl==nil)return;
    PGGMoviePlayer *pplayer = [[PGGMoviePlayer alloc] init];
    [pplayer setDelegate:self];
    [self.window addSubview:pplayer];
    [pplayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.width.offset(kMainScreenH);
        make.height.offset(kMainScreenW);
    }];
    self.playerview = pplayer;
//    NSString *strfile = [[NSBundle mainBundle] pathForResource:@"trailer" ofType:@"mp4"];
//    [pplayer playUrl:@"http://vjs.zencdn.net/v/oceans.mp4"];
    [pplayer playUrl:self.strplayerurl];
    pplayer.playerViewOriginalRect = pplayer.frame;
    pplayer.playerSuperView = self;
    pplayer.playerpoint = pplayer.center;
    pplayer.strtitle = @"";
    
    
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.allowRotate = 1;
    self.viewController.navigationController.navigationBarHidden = YES;
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {

            SEL selector = NSSelectorFromString(@"setOrientation:");

            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];

            [invocation setSelector:selector];

            [invocation setTarget:[UIDevice currentDevice]];

            int val = UIInterfaceOrientationLandscapeRight;

            [invocation setArgument:&val atIndex:2];

            [invocation invoke];
    }
    
}
-(void)backAction
{
    [self guanbiquanping];
}
///关闭全屏
-(void)guanbiquanping
{
    [self.playerview removeFromSuperview];
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.allowRotate = 0;
    self.viewController.navigationController.navigationBarHidden = NO;
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {

            SEL selector = NSSelectorFromString(@"setOrientation:");

            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];

            [invocation setSelector:selector];

            [invocation setTarget:[UIDevice currentDevice]];

            int val = UIInterfaceOrientationPortrait;

            [invocation setArgument:&val atIndex:2];

            [invocation invoke];
    }
    
}

-(void)setUrlshipin:(NSString *)urlshipin
{
    UIImage *image = [self getThumbnailImage:urlshipin];
    [_imgvback setImage:image];
    self.strplayerurl = urlshipin;
    
}

- (UIImage*)getThumbnailImage:(NSString*)videoURL{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videoURL] options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
   
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = 0.01;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    
    return thumbnailImage;
    
}

@end
