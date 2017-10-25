//
//  HPAMapManager.m
//  ZHDJ
//
//  Created by 秦正华 on 2017/9/28.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import "HPAMapManager.h"


static CLLocationCoordinate2D distinateCoor;//目的地坐标

@interface HPAMapManager()<MAMapViewDelegate,AMapSearchDelegate>

@property (nonatomic,strong)NSMutableArray *searchResultArr;

@end

@implementation HPAMapManager

#pragma mark --创建一个单例类对象
+(instancetype)sharedManager{
    static HPAMapManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //初始化单例对象
        instance = [[HPAMapManager alloc]init];
    });
    return instance;
}
#pragma mark --初始化地图对象
-(void)initMapViewWithFrame:(CGRect)frame{
    [self initSearch];
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:frame];
    ///把地图添加至view
    [self.controller.view addSubview:_mapView];
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
//    _mapView.showsUserLocation = YES;
//    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    //设置地图缩放比例，即显示区域
//    [_mapView setZoomLevel:9 animated:YES];
    _mapView.delegate = self;
    //设置定位精度
//    _mapView.desiredAccuracy = kCLLocationAccuracyBest;
    //设置定位距离
//    _mapView.distanceFilter = 5.0f;
    _mapView.showsScale = NO;
    _mapView.showsCompass = NO;
}

#pragma mark serach初始化
-(void)initSearch{
    _search =[[AMapSearchAPI alloc] init];
    _search.delegate=self;
}

#pragma mark --带block的地图初始化方法
-(void)initMapViewFrame:(CGRect)frame WithBlock:(MapBlock)block{
    [self initSearch];
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:frame];
    ///把地图添加至view
    [self.controller.view addSubview:_mapView];
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    //设置地图缩放比例，即显示区域
    [_mapView setZoomLevel:15.1 animated:YES];
    _mapView.delegate = self;
    //设置定位精度
    _mapView.desiredAccuracy = kCLLocationAccuracyBest;
    //设置定位距离
    _mapView.distanceFilter = 5.0f;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

#pragma mark --标记添加大头针
-(void)addAnomationWithCoor:(CLLocationCoordinate2D)coor{
    //地理坐标反编码为文字
    AMapReGeocodeSearchRequest *request =[[AMapReGeocodeSearchRequest alloc] init];
    request.location =[AMapGeoPoint locationWithLatitude:coor.latitude longitude:coor.longitude];
    [_search AMapReGoecodeSearch:request];
    _anomationPoint = [[MAPointAnnotation alloc]init];
    _anomationPoint.coordinate = coor;
    [self.mapView addAnnotation:_anomationPoint];
    //将标记点的位置放在地图的中心
//    _mapView.centerCoordinate = coor;
}

#pragma mark --设置大头针上方气泡的内容的代理方法
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    //大头针标注
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {//判断是否是自己的定位气泡，如果是自己的定位气泡，不做任何设置，显示为蓝点，如果不是自己的定位气泡，比如大头针就会进入
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        HPAnnotationView * annotationView = (HPAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[HPAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
            [annotationView setSelected:YES animated:YES];
        }
        annotationView.image = [UIImage imageNamed:@"faxian_djdt"];
        annotationView.canShowCallout = NO;
        
        for (int i = 0; i < self.anomationDataArr.count; ++i)
        {
            DJmapTopOrgModel *model = self.anomationDataArr[i];
            NSArray *locations = [model.org_location componentsSeparatedByString:@","];
            if ([locations[1] doubleValue] == annotation.coordinate.latitude && [locations[0] doubleValue] == annotation.coordinate.longitude){
                
                annotationView.calloutView.member.text = [NSString stringWithFormat:@"党员 %ld",model.member_count];
                annotationView.calloutView.active.text = [NSString stringWithFormat:@"活动 %ld",model.activity_count];
                annotationView.calloutView.ogrName.text = model.org_name;
                annotationView.calloutView.tag = 100+i;
                DEBUGLog(@"%ld",annotationView.calloutView.tag);
                [annotationView.calloutView addTarget:self action:@selector(annotationViewTap:)];
            }
        }
        
        return annotationView;
    }
    return nil;
}

#pragma mark 搜索请求发起后的回调,用于标记自己当前的位置
/**失败回调*/
-(void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    
    DEBUGLog(@"request: %@------error:  %@",request,error);
}
//*成功回调
-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    //我们把编码后的地理位置，显示到 大头针的标题和子标题上
    NSString *title =response.regeocode.addressComponent.city;
    DEBUGLog(@"%@",title);
    if (title.length == 0) {
        title = response.regeocode.addressComponent.province;
    }
        DEBUGLog(@"=====%@",request.location);
//    if (request.location.latitude == _currentLocation.coordinate.latitude&&request.location.longitude == _currentLocation.coordinate.longitude) {
//        _mapView.userLocation.title = title;
//        _mapView.userLocation.subtitle = response.regeocode.formattedAddress;
//    }else{
//        self.anomationPoint.title = title;
//        self.anomationPoint.subtitle = response.regeocode.formattedAddress;
//    }
}
#pragma mark 定位更新回调
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //        取出当前位置的坐标
        //        DEBUGLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
    self.currentLocation = [userLocation.location copy];
    
}
-(void)setCurrentLocation:(CLLocation *)currentLocation{
    _currentLocation = currentLocation;
    _mapView.centerCoordinate = currentLocation.coordinate;
    [self reGeoCoding];
}
#pragma mark 逆地理编码,经纬度编码成地址
-(void)reGeoCoding{
    if (_currentLocation) {
        AMapReGeocodeSearchRequest *request =[[AMapReGeocodeSearchRequest alloc] init];
        request.location =[AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
        [_search AMapReGoecodeSearch:request];
    }
}
#pragma mark --地址编码成经纬度
-(void)GeocodingWithAddress:(NSString *)address{
    AMapGeocodeSearchRequest *request = [[AMapGeocodeSearchRequest alloc]init];
    request.address = address;
    [_search AMapGeocodeSearch:request];
}
#pragma mark --地址编码回调
-(void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    AMapGeoPoint *point = response.geocodes[0].location;
    DEBUGLog(@"----%lf====%lf",point.latitude,point.latitude);
}
#pragma mark --选中某个大头针后回调的方法
-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
        DEBUGLog(@"%lf------%lf",view.annotation.coordinate.latitude,view.annotation.coordinate.longitude);
    distinateCoor = view.annotation.coordinate;
}

#pragma mark --周边搜索方法
-(void)searchAroundWithKeyWords:(NSString *)keywords{
    if (_currentLocation==nil||_search==nil) {
        DEBUGLog(@"location = %@---search=%@",_currentLocation,_search);
        DEBUGLog(@"搜索失败,定位或搜索对象未初始化");
        return;
    }
    AMapPOIAroundSearchRequest  *request=[[AMapPOIAroundSearchRequest alloc] init];
    //设置搜索范围，以显示在地图上
    request.radius = 10000;
    request.location=[AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
    request.keywords = keywords;
    [_search AMapPOIAroundSearch:request];
}
#pragma mark 周边搜索回调
-(void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    
    if (response.pois.count>0) {
        
        self.searchResultArr = [response.pois mutableCopy];
        DEBUGLog(@"%@",self.searchResultArr);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self setupPointAnotation:self.searchResultArr];
            
        });
    }else{
        DEBUGLog(@"搜索失败，附近暂无搜索内容");
    }
}

#pragma mark --搜索附近成功后设置大头针
-(void)setupPointAnotation:(NSMutableArray *)array{
    [_mapView setZoomLevel:13.1 animated:YES];
    for (int i = 0; i < array.count; i++) {
        CLLocationCoordinate2D coor;
        AMapPOI *poi = self.searchResultArr[i];
        coor.latitude = poi.location.latitude;
        coor.longitude = poi.location.longitude;
        MAPointAnnotation *point = [[MAPointAnnotation alloc]init];
        point.coordinate = coor;
        point.title = poi.name;
        [self.mapView addAnnotation:point];
    }
}

/** 气泡点击方法 */
-(void)annotationViewTap:(UITapGestureRecognizer *)tap
{
    CustomCalloutView *annotationview = (CustomCalloutView *)tap.view;
    DEBUGLog(@"%ld",annotationview.tag);
//    [self.mapView setZoomLevel:17 animated:YES];
    if ([self.annotationDelegate respondsToSelector:@selector(annotationViewDidSelected:)]) {
        [self.annotationDelegate annotationViewDidSelected:annotationview.tag-100];
    }
}

/** get数据添加大头针 */
-(void)setAnomationDataArr:(NSArray *)anomationDataArr
{
    _anomationDataArr = anomationDataArr;
    
    NSMutableArray *anomations = [NSMutableArray array];
    
    for (DJmapTopOrgModel *model in _anomationDataArr) {
        NSArray *locations = [model.org_location componentsSeparatedByString:@","];
        CLLocationDegrees latitude = [locations[1] doubleValue];
        CLLocationDegrees longitude = [locations[0] doubleValue];
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake(latitude,longitude);
        MAPointAnnotation *anomationPoint = [[MAPointAnnotation alloc]init];
        anomationPoint.coordinate = location;
        [anomations addObject:anomationPoint];
    }
    
    /** 设置地图使其可以显示数组中所有的annotation, 如果数组中只有一个则直接设置地图中心为annotation的位置 */
    [self.mapView showAnnotations:anomations edgePadding:UIEdgeInsetsMake(50, 50, 50, 50) animated:YES];
    
    /** 向地图窗口添加一组标注 */
    [self.mapView addAnnotations:anomations];
    
    
    
    
}

@end
