//
//  GaoDeMapView.m
//  GaoDeMap
//
//  Created by Mac on 2020/6/1.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "GaoDeMapView.h"

#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

#import <AMapSearchKit/AMapSearchKit.h>

#import "CustomAnnotationView.h"
#import "CommonUtility.h"

#import "MapPointShowAlterView.h"

@interface GaoDeMapView ()<MAMapViewDelegate,AMapSearchDelegate>

@property (nonatomic ,strong) MAMapView *mapView;
@property (nonatomic ,strong) AMapSearchAPI *search;
///移动的点
@property (nonatomic ,strong) MAAnnotationView *pointMove;
///点点击后的提示页面
@property (nonatomic ,strong) MapPointShowAlterView *pointAlterview;

@end

@implementation GaoDeMapView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [AMapServices sharedServices].enableHTTPS = YES;
        [AMapServices sharedServices].apiKey = GaoDeAppKey;
        ///初始化地图
        MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.bounds];
        ///把地图添加至view
        [self addSubview:mapView];
        _mapView = mapView;
        [_mapView setDelegate:self];
        self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.search = [[AMapSearchAPI alloc] init];
        self.search.delegate = self;
        
        ///
        AMapDistrictSearchRequest *dist = [[AMapDistrictSearchRequest alloc] init];
        dist.keywords = @"丰都";
        dist.requireExtension = YES;
        [self.search AMapDistrictSearch:dist];
        
        
        ///用户当前位置
//        mapView.showsUserLocation = YES;
//        mapView.userTrackingMode = MAUserTrackingModeFollow;
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self addMapPoint];
        });
        
        
//    self.mapView.showsIndoorMap = YES; //YES：显示室内地图；NO：不显示；
//    [self.mapView setMapType:MAMapTypeSatellite];///地图类型
    
//    self.mapView.showTraffic = YES; /// 路况图层
    
//    [self.mapView performSelector:NSSelectorFromString(@"setMapLanguage:") withObject:@(1)];///地图语言 0代表中文，1代表英文
    
//    _mapView.logoCenter = CGPointMake(CGRectGetWidth(self.view.bounds)-55, 450); ///地图logo控件
    
//    _mapView.showsCompass= YES; // 设置成NO表示关闭指南针；YES表示显示指南针
//    _mapView.compassOrigin= CGPointMake(_mapView.compassOrigin.x, 22); //设置指南针位置
    
//    _mapView.showsScale= YES; //设置成NO表示不显示比例尺；YES表示显示比例尺
//    _mapView.scaleOrigin= CGPointMake(_mapView.scaleOrigin.x, 22); //设置比例尺位置
    
//    _mapView.zoomEnabled = NO; //NO表示禁用缩放手势，YES表示开启
//    [_mapView setZoomLevel:17.5 animated:YES]; ///地图的缩放级别的范围是[3-19]
    
//    _mapView.scrollEnabled = NO; //NO表示禁用滑动手势，YES表示开启
//    [_mapView setCenterCoordinate:center animated:YES];///地图平移时，缩放级别不变，可通过改变地图的中心点来移动地图
    
//    _mapView.rotateEnabled= NO; //NO表示禁用旋转手势，YES表示开启
//    [_mapView setRotationDegree:60.f animated:YES duration:0.5];///旋转角度的范围是[0.f 360.f]，以逆时针为正向
    
//    _mapView.rotateCameraEnabled= NO; //NO表示禁用倾斜手势，YES表示开启
//    [_mapView setCameraDegree:30.f animated:YES duration:0.5];///倾斜角度范围为[0.f, 45.f]
        
    }
    return self;
}


-(void)searchData
{
    
//    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
//    request.keywords = @"北京大学";
//    request.city = @"北京";
//    request.types = @"高等院校";
//    request.requireExtension = YES; /* 搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
//    request.cityLimit = YES;
//    request.requireSubPOIs = YES;
//    [self.search AMapPOIKeywordsSearch:request];
    
//    ///关键词
//    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
//    request.location = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
//    request.keywords = @"电影院";
//    /* 按照距离排序. */
//    request.sortrule = 0;
//    request.requireExtension = YES;
//    [self.search AMapPOIKeywordsSearch:request];
    
//    //位置
//    NSArray *points = [NSArray arrayWithObjects: [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476], [AMapGeoPoint locationWithLatitude:39.890459 longitude:116.581476], nil];
//    AMapGeoPolygon *polygon = [AMapGeoPolygon polygonWithPoints:points];
//    AMapPOIPolygonSearchRequest *request = [[AMapPOIPolygonSearchRequest alloc] init];
//    request.polygon = polygon;
//    request.keywords = @"Apple";
//    request.requireExtension = YES;
//    [self.search AMapPOIKeywordsSearch:request];
    
    
//    //地址获取坐标
//    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
//    geo.address = @"北京市朝阳区阜荣街10号";
//    [self.search AMapGeocodeSearch:geo];
    
//    ///坐标获取地址
//    CLLocationCoordinate2D coordinate;
//    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
//    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
//    regeo.requireExtension = YES;
//    [self.search AMapReGoecodeSearch:regeo];
}

///根据坐标获取地址信息
-(void)getCoord2DPoingAddress:(CLLocationCoordinate2D)coordinate
{
    
//    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
//    geo.address = @"北京市朝阳区阜荣街10号";
//    [self.search AMapGeocodeSearch:geo];
    
//    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
//    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
//    regeo.requireExtension = YES;
//    [self.search AMapReGoecodeSearch:regeo];
    
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension = YES;
    [self.search AMapReGoecodeSearch:regeo];
    
}

///添加覆盖物
-(void)addMapMACircle
{
    
    
}

///添加线
-(void)addMapLine
{
    CLLocationCoordinate2D commonPolylineCoords[4];
    commonPolylineCoords[0].latitude = 39.832136;
    commonPolylineCoords[0].longitude = 116.34095;
    
    commonPolylineCoords[1].latitude = 39.832136;
    commonPolylineCoords[1].longitude = 116.42095;
    
    commonPolylineCoords[2].latitude = 39.902136;
    commonPolylineCoords[2].longitude = 116.42095;
    
    commonPolylineCoords[3].latitude = 39.902136;
    commonPolylineCoords[3].longitude = 116.44095;
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:4];
    //在地图上添加折线对象
    [_mapView addOverlay: commonPolyline];
    
    
//    MAMapRect bounds = MAMapRectZero;
//    NSString *polylineStr = @"";
//    MAPolyline *polyline = [CommonUtility polylineForCoordinateString:polylineStr];
//    [self.mapView addOverlay:polyline];
//    if(MAMapRectEqualToRect(bounds, MAMapRectZero)) {
//        bounds = polyline.boundingMapRect;
//    } else {
//        bounds = MAMapRectUnion(bounds, polyline.boundingMapRect);
//    }
    
}

///添加点
-(void)addMapPoint
{
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(29.472845, 106.520699);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街6号";
    [_mapView addAnnotation:pointAnnotation];
    
    
    
}
///地图截屏功能
-(void)mapViewScreenImage
{
    __block UIImage *screenshotImage = nil;
    __block NSInteger resState = 0;
    [self.mapView takeSnapshotInRect:CGRectMake(0, 0, 100, 100) withCompletionBlock:^(UIImage *resultImage, NSInteger state) {
        screenshotImage = resultImage;
        resState = state; // state表示地图此时是否完整，0-不完整，1-完整
    }];
}

///自定义定位小蓝点
-(void)userPoint
{
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    r.showsAccuracyRing = NO;///精度圈是否显示，默认YES
    r.showsHeadingIndicator = NO;///是否显示方向指示(MAUserTrackingModeFollowWithHeading模式开启)。默认为YES
    r.fillColor = [UIColor redColor];///精度圈 填充颜色, 默认 kAccuracyCircleDefaultColor
    r.strokeColor = [UIColor blueColor];///精度圈 边线颜色, 默认 kAccuracyCircleDefaultColor
    r.lineWidth = 2;///精度圈 边线宽度，默认0
    r.enablePulseAnnimation = NO;///内部蓝色圆点是否使用律动效果, 默认YES
    r.locationDotBgColor = [UIColor greenColor];///定位点背景色，不设置默认白色
    r.locationDotFillColor = [UIColor grayColor];///定位点蓝色圆点颜色，不设置默认蓝色
//    r.image = [UIImage imageNamed:@"addresspoint"]; ///定位图标, 与蓝色原点互斥(只有一个生效)
    [_mapView updateUserLocationRepresentation:r];
}

///行政区域
#pragma mark - AMapSearchDelegate
- (void)onDistrictSearchDone:(AMapDistrictSearchRequest *)request response:(AMapDistrictSearchResponse *)response
{
    
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self handleDistrictResponse:response];
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}
#pragma mark - Helpers

- (void)handleDistrictResponse:(AMapDistrictSearchResponse *)response
{
    if (response == nil)
    {
        return;
    }
    
    for (AMapDistrict *dist in response.districts)
    {
//        MAPointAnnotation *poiAnnotation = [[MAPointAnnotation alloc] init];
//
//        poiAnnotation.coordinate = CLLocationCoordinate2DMake(dist.center.latitude, dist.center.longitude);
//        poiAnnotation.title      = dist.name;
//        poiAnnotation.subtitle   = dist.adcode;
//
//        [self.mapView addAnnotation:poiAnnotation];
        
        if (dist.polylines.count > 0)
        {
            MAMapRect bounds = MAMapRectZero;
            
            for (NSString *polylineStr in dist.polylines)
            {
                MAPolyline *polyline = [CommonUtility polylineForCoordinateString:polylineStr];
                [self.mapView addOverlay:polyline];
                if(MAMapRectEqualToRect(bounds, MAMapRectZero)) {
                    bounds = polyline.boundingMapRect;
                } else {
                    bounds = MAMapRectUnion(bounds, polyline.boundingMapRect);
                }
            }
            
#if 0 //如果要显示带填充色的polygon，打开此开关
            for (NSString *polylineStr in dist.polylines)
            {
                NSUInteger tempCount = 0;
                CLLocationCoordinate2D *coordinates = [CommonUtility coordinatesForString:polylineStr
                                                                          coordinateCount:&tempCount
                                                                               parseToken:@";"];
                
                
                MAPolygon *polygon = [MAPolygon polygonWithCoordinates:coordinates count:tempCount];
                free(coordinates);
                [self.mapView addOverlay:polygon];
            }
#endif
            
            [self.mapView setVisibleMapRect:bounds animated:YES];
        }
        
        // sub
//        for (AMapDistrict *subdist in dist.districts)
//        {
//            MAPointAnnotation *subAnnotation = [[MAPointAnnotation alloc] init];
//
//            subAnnotation.coordinate = CLLocationCoordinate2DMake(subdist.center.latitude, subdist.center.longitude);
//            subAnnotation.title      = subdist.name;
//            subAnnotation.subtitle   = subdist.adcode;
//
//            [self.mapView addAnnotation:subAnnotation];
//
//        }
        
    }
    
}
#pragma mark - MAMapViewDelegate (点回调)
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    
    NSLog(@"添加标注");
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
       return nil;
    }
    ///点回调
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *poiAnnotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        
        poiAnnotationView.image = [UIImage imageNamed:@"ic_loc_red"];
        
        return poiAnnotationView;
        
    }
    return nil;
    
}
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    if(self.pointAlterview)
    {
        [self.pointAlterview removeFromSuperview];
    }
    
    self.pointAlterview = [[MapPointShowAlterView alloc] init];
    [self addSubview:self.pointAlterview];
    [self.pointAlterview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.offset(200);
    }];
    
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"%@",views);
    
}

#pragma mark - 绘制线的回调
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay {
    
    
    if ([overlay isKindOfClass:[MAPolygon class]])
    { //填充
        MAPolygonRenderer *render = [[MAPolygonRenderer alloc] initWithPolygon:overlay];
        
        render.lineWidth   = 2.f;
        render.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.4];
        render.strokeColor = [UIColor redColor];
        
        return render;
    } else if ([overlay isKindOfClass:[MAPolyline class]])
    { //区域规划 画线
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth   = 4.f;
        polylineRenderer.strokeColor = [UIColor blueColor];
        
        return polylineRenderer;
    }
    return nil;
    
}
#pragma mark - 点移动后的信息
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState
fromOldState:(MAAnnotationViewDragState)oldState
{
    
    _pointMove = view;
    NSLog(@"latitude=%lf;longitude=%lf",view.annotation.coordinate.latitude,view.annotation.coordinate.longitude);
    [self getCoord2DPoingAddress:view.annotation.coordinate];
    
}

#pragma mark - search POI搜索返回
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    NSLog(@"2222");
    if (response.pois.count == 0) {
        return;
    } //解析response获取POI信息，具体解析见 Demo
    
    for(AMapPOI *poi in response.pois)
    {
        NSLog(@"POI搜索：%@",poi.name);
    }
    
    
}
#pragma mark - 根据地址获取坐标信息
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response {
    NSLog(@"111111");
    if (response.geocodes.count == 0) { return; } //解析response获取地理信息，具体解析见 Demo
    
    for(AMapGeocode *code in response.geocodes)
    {
        NSLog(@"地址和坐标：%lf",code.location.latitude);
    }
    
}
/**
 * @brief 逆地理编码查询回调函数 根据坐标获取地址信息
 */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    NSLog(@"333");
    NSLog(@"逆地理编码:%@",response.regeocode.formattedAddress);
    
    _pointMove.annotation.subtitle = response.regeocode.formattedAddress;
    _pointMove.annotation.title = response.regeocode.addressComponent.building;
    
}
@end
