//
//  CeZhanJianCeTJView.m
//  ShuiKu
//
//  Created by Mac on 2020/7/12.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CeZhanJianCeTJView.h"

#import "AppDelegate.h"

#import "DateValueFormatter.h"
#import "SymbolsValueFormatter.h"

@import Charts;

@interface CeZhanJianCeTJView ()<ChartViewDelegate>

@property (nonatomic , strong) UIView *viewquanping;

@property (nonatomic , strong) UILabel *lbY;

@property (nonatomic , strong) UILabel *lbX;

@property (nonatomic, strong) NSMutableArray *arrxZhouData;
@property (nonatomic, strong) NSMutableArray *arrYData;

@property (nonatomic , strong) BarChartView *barChartView;

@property (nonatomic,strong) UILabel * markY;


@end


@implementation CeZhanJianCeTJView

- (UILabel *)markY{
    if (!_markY) {
        _markY = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 45)];
        _markY.font = [UIFont systemFontOfSize:15.0];
        _markY.textAlignment = NSTextAlignmentCenter;
        _markY.text =@"";
        _markY.textColor = [UIColor whiteColor];
        [_markY setNumberOfLines:2];
        _markY.backgroundColor = [UIColor grayColor];
    }
    return _markY;
}

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.barChartView = [[BarChartView alloc] init];
        self.barChartView.delegate = self;//设置代理
        [self addSubview:self.barChartView];
        [self.barChartView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self);
            make.left.right.top.equalTo(self);
            make.bottom.equalTo(self).offset(-20);
        }];
        
        self.barChartView.backgroundColor = [UIColor whiteColor];
        self.barChartView.noDataText = @"暂无数据";
        self.barChartView.chartDescription.enabled = YES;
        self.barChartView.scaleYEnabled = NO;//取消Y轴缩放
        self.barChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
        self.barChartView.dragEnabled = YES;//启用拖拽图标
        self.barChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        self.barChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        
        //设置滑动时候标签
        ChartMarkerView *markerY = [[ChartMarkerView alloc] init];
        markerY.offset = CGPointMake(-999, -8);
        markerY.chartView = self.barChartView;
        self.barChartView.marker = markerY;
        [markerY addSubview:self.markY];
        
        ChartXAxis *xAxis = self.barChartView.xAxis;
        xAxis.axisLineWidth = 1;//设置X轴线宽
        xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
        xAxis.drawGridLinesEnabled = NO;//不绘制网格线
        xAxis.labelTextColor = [UIColor brownColor];//label文字颜色
        
        self.barChartView.rightAxis.enabled = NO;//不绘制右边轴
        
        ChartYAxis *leftAxis = self.barChartView.leftAxis;//获取左边Y轴
        leftAxis.labelCount = 5;
        leftAxis.forceLabelsEnabled = NO;
        leftAxis.inverted = NO;//是否将Y轴进行上下翻转
        leftAxis.axisLineWidth = 0.5;//Y轴线宽
        leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
        leftAxis.valueFormatter = [[SymbolsValueFormatter alloc]init];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
        leftAxis.labelTextColor = [UIColor brownColor];//文字颜色
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
        
        leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
        leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//网格线颜色
        leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
        
//        ChartLimitLine *limitLine = [[ChartLimitLine alloc] initWithLimit:80 label:@"限制线"];
//        limitLine.lineWidth = 2;
//        limitLine.lineColor = [UIColor greenColor];
//        limitLine.lineDashLengths = @[@5.0f, @5.0f];//虚线样式
//        [leftAxis addLimitLine:limitLine];//添加到Y轴上
//        leftAxis.drawLimitLinesBehindDataEnabled = YES;//设置限制线绘制在柱形图的后面
        
        self.barChartView.legend.enabled = NO;//不显示图例说明
        
        self.barChartView.maxVisibleCount = 999;//
        //描述及图例样式
        self.barChartView.legend.enabled = NO;
        
        [self.barChartView animateWithXAxisDuration:1.0f];
        
        
        UIView *viewtop = [[UIView alloc] init];
        [self addSubview:viewtop];
        [viewtop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).offset(30);
            make.height.offset(30);
            make.top.equalTo(self);
        }];
        [viewtop setClipsToBounds:YES];
        [self drawtopView:viewtop andarrline:@[@"流量在线率",@"流量畅通率",@"流量异常率",@"水质在线率",@"水质畅通率",@"水质异常率"]];
        
        
        UIButton *btquanping = [[UIButton alloc] init];
        [btquanping setImage:[UIImage imageNamed:@"ic_fulll"] forState:UIControlStateNormal];
        [self addSubview:btquanping];
        [btquanping mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.top.offset(10);
            make.width.height.offset(30);
        }];
        [btquanping addTarget:self action:@selector(quanPingAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *lbY = [[UILabel alloc] init];
        [lbY setTextColor:RGB(30, 30, 30)];
        [lbY setTextAlignment:NSTextAlignmentLeft];
        [lbY setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:lbY];
        [lbY mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.offset(10);
        }];
        _lbY = lbY;
        
        
        UILabel *lbX = [[UILabel alloc] init];
        [lbX setTextColor:RGB(30, 30, 30)];
        [lbX setTextAlignment:NSTextAlignmentRight];
        [lbX setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:lbX];
        [lbX mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.bottom.equalTo(self.barChartView.mas_bottom).offset(-25);
        }];
        _lbX = lbX;
        
    }
    return self;
}

-(void)setStrYValue:(NSString *)strYValue
{
    _strYValue = strYValue;
    
    [_lbY setText:strYValue];
    
}

-(void)setStrXValue:(NSString *)strXValue
{
    _strXValue = strXValue;
    [_lbX setText:strXValue];
}


-(NSMutableArray *)backSuiJiShu
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        [array addObject:[NSNumber numberWithInteger:arc4random() % 100]];
    }
    return array;
}

-(void)drawtopView:(UIView *)view andarrline:(NSArray *)arrtitle
{
    UIView *viewlsat = nil;
    for(int i = 0 ; i < arrtitle.count; i++)
    {
        UIView *viewline = [[UIView alloc] init];
        [viewline setBackgroundColor:RGB(254, 106, 55)];
        [view addSubview:viewline];
        [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
            if(viewlsat == nil)
            {
                make.left.offset(0);
            }
            else
            {
                make.left.equalTo(viewlsat.mas_right).offset(10);
            }
            make.size.sizeOffset(CGSizeMake(15, 3));
            make.centerY.equalTo(view);
        }];
        
        UILabel *lbtext = [[UILabel alloc] init];
        [lbtext setText:arrtitle[i]];
        [lbtext setTextColor:RGB(30, 30, 30)];
        [lbtext setTextAlignment:NSTextAlignmentLeft];
        [lbtext setFont:[UIFont systemFontOfSize:12]];
        [view addSubview:lbtext];
        [lbtext mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(viewline.mas_right).offset(5);
            make.centerY.equalTo(view);
            
        }];
        viewlsat = lbtext;
        if(i>=arrtitle.count/2)
        {
            [viewline setBackgroundColor:RGB(35, 78, 152)];
        }
    }
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewlsat.mas_right);
    }];
    
    
}





#pragma mark - 全屏
-(void)quanPingAction
{
    UIView *viewback = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenH, kMainScreenW)];
    [viewback setBackgroundColor:[UIColor whiteColor]];
    [self.viewController.view.window addSubview:viewback];
    _viewquanping = viewback;
    
    ///必须先有值才可以绘制柱状图
    BarChartView *view = [[BarChartView alloc] initWithFrame:CGRectMake(0, 10, kMainScreenH, kMainScreenW-60)];
    view.delegate = self;//设置代理
    [viewback addSubview:view];
    
    view.backgroundColor = [UIColor whiteColor];
    view.noDataText = @"暂无数据";
    view.chartDescription.enabled = YES;
    view.scaleYEnabled = NO;//取消Y轴缩放
    view.doubleTapToZoomEnabled = NO;//取消双击缩放
    view.dragEnabled = YES;//启用拖拽图标
    view.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
    view.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    
    //设置滑动时候标签
    ChartMarkerView *markerY = [[ChartMarkerView alloc] init];
    markerY.offset = CGPointMake(-999, -8);
    markerY.chartView = view;
    view.marker = markerY;
    [markerY addSubview:self.markY];
    
    
    ChartXAxis *xAxis = view.xAxis;
    xAxis.axisLineWidth = 1;//设置X轴线宽
    xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
    xAxis.drawGridLinesEnabled = NO;//不绘制网格线
    xAxis.labelTextColor = [UIColor brownColor];//label文字颜色
    
    
    view.rightAxis.enabled = NO;//不绘制右边轴
    
    ChartYAxis *leftAxis = view.leftAxis;//获取左边Y轴
    leftAxis.labelCount = 5;
    leftAxis.forceLabelsEnabled = NO;
    leftAxis.inverted = NO;//是否将Y轴进行上下翻转
    leftAxis.axisLineWidth = 0.5;//Y轴线宽
    leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
    leftAxis.valueFormatter = [[SymbolsValueFormatter alloc]init];
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
    leftAxis.labelTextColor = [UIColor brownColor];//文字颜色
    leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
    
    leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
    leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//网格线颜色
    leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
    
//    ChartLimitLine *limitLine = [[ChartLimitLine alloc] initWithLimit:80 label:@""];
//    limitLine.lineWidth = 2;
//    limitLine.lineColor = [UIColor greenColor];
//    limitLine.lineDashLengths = @[@5.0f, @5.0f];//虚线样式
//    [leftAxis addLimitLine:limitLine];//添加到Y轴上
//    leftAxis.drawLimitLinesBehindDataEnabled = YES;//设置限制线绘制在柱形图的后面
    
    view.legend.enabled = NO;//不显示图例说明
    
    view.maxVisibleCount = 999;//
    //描述及图例样式
    view.legend.enabled = NO;
    
    [view animateWithXAxisDuration:1.0f];

    view.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithArr:self.arrxZhouData];
    
    NSMutableArray *dataSets = [self setXzhouValueData:self.arrxZhouData andKeyValue:self.arrYData];
    
    //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];//文字字体
    [data setValueTextColor:[UIColor blackColor]];
    
    //为柱形图提供数据
     view.data = data;
    //设置动画效果，可以设置X轴和Y轴的动画效果
    [view animateWithYAxisDuration:1.0f];
    
    
    UIView *viewtop = [[UIView alloc] init];
    [viewback addSubview:viewtop];
    [viewtop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewback).offset(30);
        make.height.offset(30);
        make.top.equalTo(view.mas_bottom).offset(10);
    }];
    [viewtop setClipsToBounds:YES];
    [self drawtopView:viewtop andarrline:@[@"流量在线率",@"流量畅通率",@"流量异常率",@"水质在线率",@"水质畅通率",@"水质异常率"]];
    
    
    UIButton *btquanping = [[UIButton alloc] init];
    [btquanping setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
    [viewback addSubview:btquanping];
    [btquanping mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewback).offset(10);
        make.top.equalTo(view.mas_bottom).offset(10);
        make.width.height.offset(30);
    }];
    [btquanping addTarget:self action:@selector(quanPingCancleAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *lbY = [[UILabel alloc] init];
    [lbY setTextColor:RGB(30, 30, 30)];
    [lbY setTextAlignment:NSTextAlignmentLeft];
    [lbY setFont:[UIFont systemFontOfSize:12]];
    [viewback addSubview:lbY];
    [lbY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(10);
    }];
    [lbY setText:_strYValue];
    
    
    UILabel *lbX = [[UILabel alloc] init];
    [lbX setTextColor:RGB(30, 30, 30)];
    [lbX setTextAlignment:NSTextAlignmentRight];
    [lbX setFont:[UIFont systemFontOfSize:12]];
    [viewback addSubview:lbX];
    [lbX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewback).offset(-10);
        make.bottom.equalTo(view.mas_bottom).offset(-10);
    }];
    [lbX setText:_strXValue];
    
    UILabel *lbtitle = [[UILabel alloc] init];
    [lbtitle setTextColor:RGB(153, 153, 153)];
    [lbtitle setTextAlignment:NSTextAlignmentRight];
    [lbtitle setFont:[UIFont systemFontOfSize:12]];
    [viewback addSubview:lbtitle];
    [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewback).offset(-10);
        make.top.equalTo(viewback).offset(10);
    }];
    [lbtitle setText:_strtitle];
    
    UILabel *lbtitle1 = [[UILabel alloc] init];
    [lbtitle1 setTextColor:RGB(30, 30, 30)];
    [lbtitle1 setTextAlignment:NSTextAlignmentLeft];
    [lbtitle1 setFont:[UIFont systemFontOfSize:12]];
    [viewback addSubview:lbtitle1];
    [lbtitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewback).offset(10);
        make.top.equalTo(view.mas_bottom);
    }];
    [lbtitle1 setText:_strtitle1];
    
    
    
    
    
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

-(void)quanPingCancleAction:(UIButton *)sender
{
    [_viewquanping removeFromSuperview];
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



-(NSMutableArray *)setXzhouValueData:(NSMutableArray *)arrX andKeyValue:(NSMutableArray *)arrYValue
{
//    ChartXAxis *xAxis = self.barChartView.xAxis;
//    BarxAxisFormatter *xFormatter = [BarxAxisFormatter new];
//    xFormatter.titles = arrX;
//    xAxis.valueFormatter = xFormatter;
    
    NSMutableArray *arrcolor = [NSMutableArray new];
    NSInteger iline = arrYValue.count/3;
    for(int i = 0 ; i < iline; i++)
    {
        NSArray *arrtempco = @[MenuColor1,MenuColor1,MenuColor1];
        NSArray *arrtempco1 = @[MenuColor,MenuColor,MenuColor];
        if(i%2==0)
        {
            [arrcolor addObjectsFromArray:arrtempco1];
        }
        else
        {
            [arrcolor addObjectsFromArray:arrtempco];
        }
    }
    NSMutableArray *arrchardata = [NSMutableArray new];
    for(int i = 0 ; i < arrYValue.count; i++)
    {
        double dtemp = [arrYValue[i] doubleValue];
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i y:dtemp data:arrX[i]];
        
        [arrchardata addObject:entry];
    }
    
    //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithEntries:arrchardata label:nil];
    set1.drawValuesEnabled = NO;//是否在柱形图上面显示数值
    set1.highlightEnabled = YES;//点击选中柱形图是否有高亮效果，（双击空白处取消选中）
    
    [set1 setColors:arrcolor];//设置柱形图颜色
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    return dataSets;
}

-(void)setXzhouValue:(NSMutableArray *)arrX andKeyValue:(NSMutableArray *)arrYValue
{
    self.barChartView.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithArr:arrX];
    
    self.arrxZhouData = arrX;
    self.arrYData = arrYValue;
    
    NSMutableArray *dataSets = [self setXzhouValueData:arrX andKeyValue:arrYValue];
    
    //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];//文字字体
    [data setValueTextColor:[UIColor blackColor]];
    
    //为柱形图提供数据
     self.barChartView.data = data;
    //设置动画效果，可以设置X轴和Y轴的动画效果
    [self.barChartView animateWithYAxisDuration:1.0f];
}

#pragma mark - 代理
-(void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight
{
    NSLog(@"---chartValueSelected---value: %.2lf", entry.y);
    
    
    _markY.text = [NSString stringWithFormat:@"%@\n%.2lf",self.arrxZhouData[(int)entry.x],entry.y];
    //将点击的数据滑动到中间
    [self.barChartView centerViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[self.barChartView.data getDataSetByIndex:highlight.dataSetIndex].axisDependency duration:1.0];
}

- (void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView{
    NSLog(@"---chartValueNothingSelected---");
}
- (void)chartScaled:(ChartViewBase * _Nonnull)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY{
    NSLog(@"---chartScaled---scaleX:%g, scaleY:%g", scaleX, scaleY);
}
- (void)chartTranslated:(ChartViewBase * _Nonnull)chartView dX:(CGFloat)dX dY:(CGFloat)dY{
    NSLog(@"---chartTranslated---dX:%g, dY:%g", dX, dY);
}


@end
