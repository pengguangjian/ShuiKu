//
//  LineZuoBiaoView.m
//  zhexiantuDemo
//
//  Created by Mac on 2020/7/12.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LineZuoBiaoView.h"

@interface LineZuoBiaoView ()

@property (nonatomic , strong) GBLineChart *lineChart;//折线图

@property (nonatomic , strong) NSArray *arrxArr;

@end


@implementation LineZuoBiaoView
///更新页面大小
-(void)setRefLinView:(CGRect)rect
{
    if(_lineChart)
    {
        [_lineChart setFrame:rect];
    }
}

/// xArr：横坐标
-(id)initWithFrame:(CGRect)frame andXArr:(NSArray *)xArr
{
    if(self = [super initWithFrame:frame])
    {
        _arrxArr = xArr;
        
        GBLineChart *chart = [[GBLineChart alloc] initWithFrame:frame];///WithFrame:CGRectMake(0, 100, CGRectGetWidth(self.bounds), 220)
        [self addSubview:chart];
//        [chart mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self);
//        }];
        [chart setPointSelect:^(UILabel *lbselect) {
            NSLog(@"你点击了某个点");
        }];
        
        chart.xLabelTitles = xArr;
        
        chart.xLabelRotationAngle = M_PI/6;
        chart.showCoordinateAxis = YES;
        chart.xLabelAlignmentStyle = GBXLabelAlignmentStyleFitXAxis;
        
        chart.showVerticalLine = NO;
        chart.verticalLineColor = [UIColor cyanColor];
        chart.verticalLineWidth = 1;
        chart.verticalLineXValue = 8.8;
        ///网格是否是虚线
        chart.showYGridsLineDash = YES;
        ///是否动画
        chart.displayAnimated = NO;
        ///是否圆滑曲线
        chart.showSmoothLines = NO;
        _lineChart = chart;
        
        
    }
    return self;
}
///添加折现
-(GBLineChartData *)addLine:(NSArray *)array andlinecolor:(UIColor *)color
{
    GBLineChartData *data = [GBLineChartData new];
    data.lineAlpha = 0.7;
    data.lineColor = color;
    data.lineWidth = 1;
    data.startIndex = 0;
    data.itemCount = array.count; //index+1
    data.lineChartPointStyle = GBLineChartPointStyleCircle;
    
    data.inflexionPointStrokeColor = [UIColor redColor];
    ///圆点填充色
    data.inflexionPointFillColor = [UIColor clearColor];
    
    data.inflexionPointWidth = 1;
    ///是否是虚线
    data.showDash = NO;
    
    ///渐变
    data.showGradientArea = YES;
    data.startGradientColor = [color colorWithAlphaComponent:0.4];
    data.endGradientColor = [UIColor clearColor];
    data.lineDashPattern = @[@1,@1];
    
    data.showPointLabel = YES;
    data.pointLabelFont = [UIFont systemFontOfSize:10];
    data.pointLabelColor = [UIColor colorWithRed:153/255.0 green:153/255.0  blue:153/255.0  alpha:0.6];;
    data.pointLabelFormat = @"%0.1f";
    
    data.dataGetter = ^GBLineChartDataItem *(NSInteger item) {
      
        return [GBLineChartDataItem dataItemWithY:[array[item] floatValue] X:[self->_arrxArr[item] floatValue]];
    };
    
    return data;
    
}
///更新横坐标值
-(void)uploadxArr:(NSArray *)xArr
{
    _arrxArr = xArr;
    
}

///先绘制线然后才调用该方法 展示 arrdatas[<GBLineChartData>];
-(void)showValue:(NSArray *)arrdatas
{
    /////////
    _lineChart.lineChartDatas = arrdatas;
    _lineChart.chartMarginLeft = 25;

    _lineChart.yLabelBlockFormatter = ^NSString *(CGFloat value) {
      
        
        return [NSString stringWithFormat:@"%0.0f", value];
    };
    
    [_lineChart strokeChart];
}


@end
