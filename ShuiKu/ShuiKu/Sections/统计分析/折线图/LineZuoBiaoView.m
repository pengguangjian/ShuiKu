//
//  LineZuoBiaoView.m
//  ceshiTu
//
//  Created by Mac on 2020/7/23.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LineZuoBiaoView.h"

#import "SymbolsValueFormatter.h"
#import "DateValueFormatter.h"
#import "SetValueFormatter.h"

@import Charts;

@interface LineZuoBiaoView ()<ChartViewDelegate>
@property (nonatomic,strong) LineChartView * lineView;
@property (nonatomic,strong) UILabel * markY;

@end

@implementation LineZuoBiaoView

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

- (LineChartView *)lineViewtem:(CGRect)rect {
    if (!_lineView) {
        _lineView = [[LineChartView alloc] initWithFrame:rect];
        _lineView.delegate = self;//设置代理
        _lineView.backgroundColor =  [UIColor whiteColor];
        _lineView.noDataText = @"暂无数据";
        _lineView.chartDescription.enabled = YES;
        _lineView.scaleYEnabled = NO;//取消Y轴缩放
        _lineView.doubleTapToZoomEnabled = NO;//取消双击缩放
        _lineView.dragEnabled = YES;//启用拖拽图标
        _lineView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        _lineView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        
        
        //设置滑动时候标签
        ChartMarkerView *markerY = [[ChartMarkerView alloc] init];
        markerY.offset = CGPointMake(-999, -8);
        markerY.chartView = _lineView;
        _lineView.marker = markerY;
        [markerY addSubview:self.markY];
        
        _lineView.rightAxis.enabled = NO;//不绘制右边轴
        ChartYAxis *leftAxis = _lineView.leftAxis;//获取左边Y轴
        leftAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
        leftAxis.forceLabelsEnabled = YES;//不强制绘制指定数量的label
        // leftAxis.axisMinValue = 0;//设置Y轴的最小值
        //leftAxis.axisMaxValue = 105;//设置Y轴的最大值
        leftAxis.inverted = NO;//是否将Y轴进行上下翻转
        leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
        leftAxis.valueFormatter = [[SymbolsValueFormatter alloc]init];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
        leftAxis.labelTextColor = [UIColor blackColor];//文字颜色
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
        leftAxis.gridColor = [UIColor grayColor];//网格线颜色
        leftAxis.gridAntialiasEnabled = NO;//开启抗锯齿
        leftAxis.axisMinimum = 0;///
        
        ChartXAxis *xAxis = _lineView.xAxis;
        xAxis.granularityEnabled = NO;//设置重复的值不显示
        xAxis.labelPosition= XAxisLabelPositionBottom;//设置x轴数据在底部
        xAxis.gridColor = [UIColor clearColor];
        xAxis.labelTextColor = [UIColor blackColor];//文字颜色
        xAxis.axisLineColor = [UIColor blackColor];
        xAxis.labelCount = 3;
        
        _lineView.maxVisibleCount = 999;//
        //描述及图例样式
        _lineView.legend.enabled = NO;
        
        [_lineView animateWithXAxisDuration:1.0f];
    }
    return _lineView;
}
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self lineViewtem:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.lineView];
        
//        ///未设置值
//        _lineView.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithArr:[self arrxnomoData]];
//
//        ///x和y的数量要一样
//        self.lineView.data = [self addline];
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.lineView.data = nil;
//        });
    }
    return self;
}

///设置arrX x轴数据 arrKeyValue:value y轴数据 color:
-(void)setXzhouValue:(NSMutableArray *)arrX andKeyValue:(NSMutableArray *)arrKeyValue
{
    ///未设置值
    _lineView.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithArr:arrX];
    
    NSMutableArray *arrychart = [NSMutableArray new];
    for(NSDictionary *dicitem in arrKeyValue)
    {
        NSMutableArray *arryvalue = [[NSMutableArray alloc ] initWithArray:[dicitem objectForKey:@"value"]];
        if(arrX.count>arryvalue.count)
        {
            NSMutableArray *arritem = [NSMutableArray new];
            for(int i = 0 ; i < arrX.count-arryvalue.count;i++)
            {
                [arritem addObject:@"0"];
                
            }
            [arryvalue insertObjects:arritem atIndex:0];
        }
        if(arryvalue.count>arrX.count)
        {
            [arryvalue removeObjectsInRange:NSMakeRange(arrX.count, arryvalue.count-arrX.count)];
        }
        NSMutableArray *arrlinetemp = [NSMutableArray new];
        for(int i = 0 ; i < arryvalue.count; i++)
        {
            float y = [arryvalue[i] floatValue];
            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:y];
            [arrlinetemp addObject:entry];
        }
        
        UIColor *color = [dicitem objectForKey:@"color"];
        [arrychart addObject:[self setLineValue:arrlinetemp andlinecolor:color]];
        
    }
    //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
    LineChartData *data = [[LineChartData alloc]initWithDataSets:arrychart];
    [data setValueFont:[UIFont systemFontOfSize:10]];//文字字体
    [data setValueTextColor:[UIColor blackColor]];//文字颜色
    self.lineView.data = data;
    
}
//
/////x轴默认数据
//-(NSMutableArray *)arrxnomoData
//{
//    NSInteger xVals_count = 10;//X轴上要显示多少条数据
//    //X轴上面需要显示的数据
//    NSMutableArray *xVals = [[NSMutableArray alloc] init];
//
//    for (int i = 1; i <= xVals_count; i++) {
//        if (i<30) {
//        [xVals addObject: [NSString stringWithFormat:@"02-%d",i]];
//        }else{
//        [xVals addObject: [NSString stringWithFormat:@"03-%d",i-29]];
//        }
//    }
//    return xVals;
//}
/////y轴默认数据
//-(NSMutableArray *)arrYvalueDemo
//{
//    NSInteger xVals_count = 10;//X轴上要显示多少条数据
//    //对应Y轴上面需要显示的数据
//    NSMutableArray *yVals = [[NSMutableArray alloc] init];
//    for (int i = 0; i < xVals_count; i++) {
//        int a = arc4random() % 100;
//        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:a];
//        [yVals addObject:entry];
//    }
//    return yVals;
//}
//
/////
//-(LineChartData *)addline
//{
//    NSMutableArray *arrtemp = [NSMutableArray new];
//
//    [arrtemp addObject:[self setLineValue:[self arrYvalueDemo] andlinecolor:[UIColor redColor]]];
//    [arrtemp addObject:[self setLineValue:[self arrYvalueDemo] andlinecolor:[UIColor brownColor]]];
//    [arrtemp addObject:[self setLineValue:[self arrYvalueDemo] andlinecolor:[UIColor yellowColor]]];
//    [arrtemp addObject:[self setLineValue:[self arrYvalueDemo] andlinecolor:[UIColor blueColor]]];
//
//
//    //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
//    LineChartData *data = [[LineChartData alloc]initWithDataSets:arrtemp];
//
//    [data setValueFont:[UIFont systemFontOfSize:10]];//文字字体
//    [data setValueTextColor:[UIColor blackColor]];//文字颜色
//    return data;
//}
//

-(LineChartDataSet *)setLineValue:(NSMutableArray *)yVals andlinecolor:(UIColor *)color
{
    LineChartDataSet *set1 = nil;
    
    //创建LineChartDataSet对象
    set1 = [[LineChartDataSet alloc]initWithEntries:yVals label:@""];
    //设置折线的样式
    set1.lineWidth = 2.0/[UIScreen mainScreen].scale;//折线宽度
    
    
//    set1.valueFormatter = [[SetValueFormatter alloc]initWithArr:yVals];
    
    set1.valueColors = @[[UIColor blackColor]];//折线拐点处显示数据的颜色
    set1.drawValuesEnabled = NO;//是否在拐点处显示数据
    [set1 setColor:color];//折线颜色
    set1.highlightColor = [UIColor redColor];
    set1.drawFilledEnabled = NO;//是否开启绘制阶梯样式的折线图
    //折线拐点样式
    set1.drawCirclesEnabled = NO;//是否绘制拐点
    set1.circleHoleRadius = 1;
    set1.fillAlpha = 0.1;
    set1.fillColor = color;
    set1.drawFilledEnabled = YES;//是否填充颜色
    set1.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
    set1.valueFont = [UIFont systemFontOfSize:6];
    return set1;
}

- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight {
    
    _markY.text = [NSString stringWithFormat:@"%.2lf",entry.y];
    //将点击的数据滑动到中间
    [_lineView centerViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[_lineView.data getDataSetByIndex:highlight.dataSetIndex].axisDependency duration:1.0];

    
}
- (void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView {
    
    
}

@end
