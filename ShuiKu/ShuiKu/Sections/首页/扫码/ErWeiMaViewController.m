//
//  ErWeiMaViewController.m
//  CamraDemo
//
//  Created by Mac on 2020/6/2.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ErWeiMaViewController.h"
#import <AVFoundation/AVFoundation.h>//原生二维码扫描必须导入这个框架
#import "MainHomeDataController.h"

#define QRCodeWidth 260.0 //正方形二维码的边长

#define SCREENWidth [UIScreen mainScreen].bounds.size.width //设备屏幕的宽度

#define SCREENHeight [UIScreen mainScreen].bounds.size.height //设备屏幕的高度


@interface ErWeiMaViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic,strong)AVCaptureSession *session;
///登录扫码信息
@property (nonatomic,strong) NSDictionary *disdenglusaoma;

@end

@implementation ErWeiMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMaskView];//设置扫描区域之外的阴影视图
    [self setupScanWindowView];//设置扫描二维码区域的视图
    [self beginScanning];//开始扫二维码
}

-(void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupMaskView

{

    UIView *viewback = [[UIView alloc] init];
    [viewback setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:viewback];
    [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
       if (@available(iOS 11.0, *)) {
           make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
           make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
           make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
           make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
       }else{
           make.edges.equalTo(self.view).insets(kPaddingNav);
       }
        
    }];
    
     //设置统一的视图颜色和视图的透明度

     UIColor *color = [UIColor blackColor];

     float alpha = 0.7;



     //设置扫描区域外部上部的视图

     UIView *topView = [[UIView alloc]init];

     topView.frame = CGRectMake(0, 0, SCREENWidth, (SCREENHeight-64-QRCodeWidth)/2.0);

     topView.backgroundColor = color;

     topView.alpha = alpha;


    //设置扫描区域外部左边的视图

     UIView *leftView = [[UIView alloc]init];

     leftView.frame = CGRectMake(0, topView.frame.size.height, (SCREENWidth-QRCodeWidth)/2.0,QRCodeWidth);

     leftView.backgroundColor = color;

     leftView.alpha = alpha;



     //设置扫描区域外部右边的视图

     UIView *rightView = [[UIView alloc]init];

     rightView.frame = CGRectMake((SCREENWidth-QRCodeWidth)/2.0+QRCodeWidth,topView.frame.size.height, (SCREENWidth-QRCodeWidth)/2.0,QRCodeWidth);

     rightView.backgroundColor = color;

     rightView.alpha = alpha;


    //设置扫描区域外部底部的视图

     UIView *botView = [[UIView alloc]init];

     botView.frame = CGRectMake(0, QRCodeWidth+topView.frame.size.height,SCREENWidth,SCREENHeight-QRCodeWidth-topView.frame.size.height);

     botView.backgroundColor = color;

     botView.alpha = alpha;



     //将设置好的扫描二维码区域之外的视图添加到视图图层上

     [viewback addSubview:topView];

     [viewback addSubview:leftView];

     [viewback addSubview:rightView];

     [viewback addSubview:botView];

}

- (void)setupScanWindowView

{

     //设置扫描区域的位置(考虑导航栏和电池条的高度为64)

     UIView *scanWindow = [[UIView alloc]initWithFrame:CGRectMake((SCREENWidth-QRCodeWidth)/2.0,(SCREENHeight-QRCodeWidth-64)/2.0,QRCodeWidth,QRCodeWidth)];

     scanWindow.clipsToBounds = YES;

     [self.view addSubview:scanWindow];
     //设置扫描区域的动画效果

     CGFloat scanNetImageViewH = 241;

     CGFloat scanNetImageViewW = scanWindow.frame.size.width;

     UIImageView *scanNetImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scan_net"]];

     scanNetImageView.frame = CGRectMake(0, -scanNetImageViewH, scanNetImageViewW, scanNetImageViewH);

     CABasicAnimation *scanNetAnimation = [CABasicAnimation animation];

     scanNetAnimation.keyPath =@"transform.translation.y";

     scanNetAnimation.byValue = @(QRCodeWidth);

     scanNetAnimation.duration = 1.0;

     scanNetAnimation.repeatCount = MAXFLOAT;

     [scanNetImageView.layer addAnimation:scanNetAnimation forKey:nil];

     [scanWindow addSubview:scanNetImageView];
     //设置扫描区域的四个角的边框

     CGFloat buttonWH = 18;

     UIButton *topLeft = [[UIButton alloc]initWithFrame:CGRectMake(0,0, buttonWH, buttonWH)];

     [topLeft setImage:[UIImage imageNamed:@"scan_1"]forState:UIControlStateNormal];

     [scanWindow addSubview:topLeft];
     UIButton *topRight = [[UIButton alloc]initWithFrame:CGRectMake(QRCodeWidth - buttonWH,0, buttonWH, buttonWH)];

     [topRight setImage:[UIImage imageNamed:@"scan_2"]forState:UIControlStateNormal];

     [scanWindow addSubview:topRight];
     UIButton *bottomLeft = [[UIButton alloc]initWithFrame:CGRectMake(0,QRCodeWidth - buttonWH, buttonWH, buttonWH)];

     [bottomLeft setImage:[UIImage imageNamed:@"scan_3"]forState:UIControlStateNormal];

     [scanWindow addSubview:bottomLeft];

     UIButton *bottomRight = [[UIButton alloc]initWithFrame:CGRectMake(QRCodeWidth-buttonWH,QRCodeWidth-buttonWH, buttonWH, buttonWH)];

     [bottomRight setImage:[UIImage imageNamed:@"scan_4"]forState:UIControlStateNormal];

     [scanWindow addSubview:bottomRight];

}



- (void)beginScanning

{

     //获取摄像设备

     AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

     //创建输入流

     AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];

     if (!input) return;

     //创建输出流

     AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
     //特别注意的地方：有效的扫描区域，定位是以设置的右顶点为原点。屏幕宽所在的那条线为y轴，屏幕高所在的线为x轴

     CGFloat x = ((SCREENHeight-QRCodeWidth-64)/2.0)/SCREENHeight;

     CGFloat y = ((SCREENWidth-QRCodeWidth)/2.0)/SCREENWidth;

     CGFloat width = QRCodeWidth/SCREENHeight;

     CGFloat height = QRCodeWidth/SCREENWidth;

     output.rectOfInterest = CGRectMake(x, y, width, height);
     //设置代理在主线程里刷新

     [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

     //初始化链接对象

     _session = [[AVCaptureSession alloc]init];

     //高质量采集率

     [_session setSessionPreset:AVCaptureSessionPresetHigh];
     [_session addInput:input];

     [_session addOutput:output];

     //设置扫码支持的编码格式(如下设置条形码和二维码兼容)

     output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code];

     AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];

     layer.videoGravity=AVLayerVideoGravityResizeAspectFill;

     layer.frame=self.view.layer.bounds;

     [self.view.layer insertSublayer:layer atIndex:0];

     //开始捕获

     [_session startRunning];
}


#pragma mark - 获取到扫描数据
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{

     if (metadataObjects.count>0) {

          [_session stopRunning];

          //得到二维码上的所有数据

          AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex :0 ];

          NSString *str = metadataObject.stringValue;
         NSDictionary *dicinfo = [str JSONValue];
         NSLog(@"%@",dicinfo);
         
         if([[NSString nullToString:[dicinfo objectForKey:@"type"]] isEqualToString:@"1001"])
         {
             self.disdenglusaoma = dicinfo;
             [self saomaYesAction];
         }
         else
         {
             [WYTools showNotifyHUDwithtext:str inView:self.view];
         }
     }

}

///扫码登录
-(void)saomaYesAction
{
    UIView *viewback = [[UIView alloc] init];
    [viewback setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewback];
    [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.edges.equalTo(self.view).insets(kPaddingNav);
        }
    }];
    
    
    UIImageView *imgvhd = [[UIImageView alloc] init];
    [imgvhd setImage:[UIImage imageNamed:@"ic_scanner_result_login"]];
    [imgvhd setContentMode:UIViewContentModeScaleAspectFit];
    [viewback addSubview:imgvhd];
    [imgvhd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewback);
        make.top.offset(50);
        make.width.offset(kScale*200);
        make.height.offset(kScale*120);
    }];
    
    UILabel *lbshouquan = [[UILabel alloc] init];
    [lbshouquan setText:@"授权您的账号进行快速登录"];
    [lbshouquan setTextColor:[UIColor blackColor]];
    [lbshouquan setTextAlignment:NSTextAlignmentCenter];
    [lbshouquan setFont:[UIFont boldSystemFontOfSize:16]];
    [viewback addSubview:lbshouquan];
    [lbshouquan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgvhd.mas_bottom).offset(30);
        make.centerX.equalTo(viewback);
    }];
    
    
    UIButton *btlogin = [[UIButton alloc] init];
    [btlogin setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [btlogin setBackgroundColor:MenuColor];
    [btlogin setTitle:@"登录" forState:UIControlStateNormal];
    [btlogin.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btlogin.layer setMasksToBounds:YES];
    [btlogin.layer setCornerRadius:3];
    [viewback addSubview:btlogin];
    [btlogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.equalTo(viewback).offset(-30);
        make.bottom.equalTo(viewback).offset(-110);
        make.height.offset(40);
    }];
    [btlogin setTag:0];
    [btlogin addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btcancle = [[UIButton alloc] init];
    [btcancle setTitleColor:MenuColor forState:UIControlStateNormal];
    [btcancle setTitle:@"取消" forState:UIControlStateNormal];
    [btcancle.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btcancle.layer setMasksToBounds:YES];
    [btcancle.layer setCornerRadius:3];
    [btcancle.layer setBorderColor:MenuColor.CGColor];
    [btcancle.layer setBorderWidth:1];
    [viewback addSubview:btcancle];
    [btcancle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(btlogin);
        make.top.equalTo(btlogin.mas_bottom).offset(15);
    }];
    [btcancle setTag:1];
    [btcancle addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)bottomAction:(UIButton *)sender
{
    if(sender.tag==0)
    {///登录
        [MainHomeDataController requestScanCodeData:self.view sign:[self.disdenglusaoma objectForKey:@"sign"] client:[self.disdenglusaoma objectForKey:@"client"] time:[self.disdenglusaoma objectForKey:@"time"] Callback:^(NSError *error, BOOL state, NSString *describle, id value) {
            if(state)
            {
                [WYTools showNotifyHUDwithtext:@"登录成功" inView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            }
            else
            {
                [WYTools showNotifyHUDwithtext:describle inView:self.view];
            }
        }];
        
        
    }
    
    
    
}

@end
