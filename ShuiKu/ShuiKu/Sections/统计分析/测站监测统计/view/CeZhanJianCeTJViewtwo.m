//
//  CeZhanJianCeTJView1.m
//  ShuiKu
//
//  Created by Mac on 2020/7/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CeZhanJianCeTJViewtwo.h"


@import Charts;


@interface CeZhanJianCeTJViewtwo () <ChartViewDelegate>
@property (nonatomic , strong) BarChartView *barChartView;

@property (nonatomic,strong) UILabel * markY;
@end


@implementation CeZhanJianCeTJViewtwo

- (UILabel *)markY{
    if (!_markY) {
        _markY = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 25)];
        _markY.font = [UIFont systemFontOfSize:15.0];
        _markY.textAlignment = NSTextAlignmentCenter;
        _markY.text =@"";
        _markY.textColor = [UIColor whiteColor];
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
            make.edges.equalTo(self);
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
//        xAxis.spaceBetweenLabels = 4;//设置label间隔，若设置为1，则如果能全部显示，则每个柱形下面都会显示label
        xAxis.labelTextColor = [UIColor brownColor];//label文字颜色
        
        self.barChartView.rightAxis.enabled = NO;//不绘制右边轴
        
        ChartYAxis *leftAxis = self.barChartView.leftAxis;//获取左边Y轴
        leftAxis.labelCount = 5;
        leftAxis.forceLabelsEnabled = NO;
//        leftAxis.showOnlyMinMaxEnabled = NO;//是否只显示最大值和最小值
//        leftAxis.axisMinValue = 0;//设置Y轴的最小值
//        leftAxis.startAtZeroEnabled = YES;//从0开始绘制
//        leftAxis.axisMaxValue = 105;//设置Y轴的最大值
        leftAxis.inverted = NO;//是否将Y轴进行上下翻转
        leftAxis.axisLineWidth = 0.5;//Y轴线宽
        leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
        
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
        leftAxis.labelTextColor = [UIColor brownColor];//文字颜色
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
        
        leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
        leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//网格线颜色
        leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
        
        ChartLimitLine *limitLine = [[ChartLimitLine alloc] initWithLimit:80 label:@"限制线"];
        limitLine.lineWidth = 2;
        limitLine.lineColor = [UIColor greenColor];
        limitLine.lineDashLengths = @[@5.0f, @5.0f];//虚线样式
//        limitLine.labelPosition = ChartLimitLabelPositionRightTop;//位置
        [leftAxis addLimitLine:limitLine];//添加到Y轴上
        leftAxis.drawLimitLinesBehindDataEnabled = YES;//设置限制线绘制在柱形图的后面
        
        self.barChartView.legend.enabled = NO;//不显示图例说明
        
        self.barChartView.maxVisibleCount = 999;//
        //描述及图例样式
        self.barChartView.legend.enabled = NO;
        
        [self.barChartView animateWithXAxisDuration:1.0f];
        
    }
    return self;
}

-(void)setXzhouValue:(NSMutableArray *)arrX andKeyValue:(NSMutableArray *)arrYValue
{
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
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i y:dtemp];
        [arrchardata addObject:entry];
    }
    
    //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithEntries:arrchardata label:nil];
    set1.drawValuesEnabled = YES;//是否在柱形图上面显示数值
    set1.highlightEnabled = NO;//点击选中柱形图是否有高亮效果，（双击空白处取消选中）
    [set1 setColors:arrcolor];//设置柱形图颜色
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
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
- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * _Nonnull)highlight{
//    NSLog(@"---chartValueSelected---value: %g", entry);
    _markY.text = [NSString stringWithFormat:@"%.2lf",entry.y];
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
