//
//  HPAMapManager.h
//  ZHDJ
//
//  Created by 秦正华 on 2017/9/28.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import <Foundation/Foundation.h>
//基础定位类
#import <AMapFoundationKit/AMapFoundationKit.h>
//高德地图基础类
#import <MAMapKit/MAMapKit.h>
//搜索基础类
#import <AMapSearchKit/AMapSearchKit.h>

#import "HPAnnotationView.h"
#import "DJmapTopOrgModel.h"

typedef void(^MapBlock)();

@protocol HPAMapManagerDelegate <NSObject>

-(void)annotationViewDidSelected:(NSInteger)index;

@end

@interface HPAMapManager : NSObject

@property (nonatomic,strong)UIViewController *controller;
//地图对象
@property(nonatomic,strong)MAMapView *mapView;
//一个search对象，用于地理位置逆编码
@property(nonatomic,strong)AMapSearchAPI *search;
//当前定位
@property(nonatomic,strong)CLLocation *currentLocation;
//单独大头针
@property (nonatomic,strong)MAPointAnnotation *anomationPoint;
//目的地图片名
@property (nonatomic,strong)NSString *destinationImgName;
//定位大头针图片名
@property (nonatomic,strong)NSString *locationPointImgName;
/** 需要设置添加的大头针数据 */
@property(nonatomic,strong)NSArray * anomationDataArr;

@property(nonatomic,weak)id<HPAMapManagerDelegate> annotationDelegate;

//初始化单例管理员对象
+(instancetype)sharedManager;
//初始化地图
-(void)initMapViewWithFrame:(CGRect)frame;
//初始化搜索对象
-(void)initSearch;
//带回调的地图初始化方法
-(void)initMapViewFrame:(CGRect)frame WithBlock:(MapBlock)block;
//根据关键字搜索附近
-(void)searchAroundWithKeyWords:(NSString *)keywords;
//添加一个大头针
-(void)addAnomationWithCoor:(CLLocationCoordinate2D)coor;

@end
