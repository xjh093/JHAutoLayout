//
//  JHLocationManager.m
//  Advise
//
//  Created by Lightech on 16/5/13.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import "JHLocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface JHLocationManager ()<CLLocationManagerDelegate>
@property (strong,  nonatomic) CLLocationManager        *lManager;
@property (strong,  nonatomic) CLGeocoder               *geocoder;
@property (copy,    nonatomic) void (^locationBlock)(NSString *city);
@end

@implementation JHLocationManager

+ (instancetype)manager
{
    static JHLocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JHLocationManager alloc] init];
    });
    return manager;
}

- (CLLocationManager *)lManager
{
    if (!_lManager) {
        _lManager = [[CLLocationManager alloc] init];
        _lManager.delegate = self;
        _lManager.distanceFilter = 10; //位置间隔10后重新定位
        _lManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;//定位的精确度-误差
    }
    return _lManager;
}

- (void)startLocation:(void(^)(NSString *city))success
{
    if (![CLLocationManager locationServicesEnabled]) {
        //NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        //NSLog(@"1！");
        [self.lManager requestWhenInUseAuthorization];
    }else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
        //NSLog(@"2！");
        [self.lManager startUpdatingLocation];
    }
    
    self.locationBlock = success;
}

#pragma mark CLLocationManagerDelegate 2016/5/13
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //获取用户位置的对象
    CLLocation *location = [locations lastObject];
    
    _geocoder = [[CLGeocoder alloc] init];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count == 0 || error) return;
        
        CLPlacemark *pm = [placemarks lastObject];
        if (pm.locality) {
            NSLog(@"location city:%@,%@",pm.locality,pm.administrativeArea);//城市
            NSString *tt=[NSString stringWithFormat:@"%@,%@",pm.administrativeArea,pm.locality];
            self.locationBlock(tt);
        }else{
            //NSLog(@"location city:%@",pm.administrativeArea);//直辖市
            self.locationBlock(pm.administrativeArea);
        }
        //NSLog(@"location name:%@",pm.name);//详细地址
    }];
    
    [manager stopUpdatingLocation];
}

@end
