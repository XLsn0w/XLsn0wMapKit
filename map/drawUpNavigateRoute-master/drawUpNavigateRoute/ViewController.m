//
//  ViewController.m
//  drawUpNavigateRoute
//
//  Created by devzkn on 07/10/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DKMapViewController.h"

#define weakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *endTextField;
@property (weak, nonatomic) IBOutlet UITextField *startTextField;

@property (strong, nonatomic)  CLGeocoder *geoCoder;

@end



@implementation ViewController

- (CLGeocoder *)geoCoder{
    if (nil == _geoCoder) {
        CLGeocoder *tmpView = [[CLGeocoder alloc]init];
        _geoCoder = tmpView;
    }
    return _geoCoder;
}

- (IBAction)go:(id)sender {
    NSString *startStr = self.startTextField.text;
    NSString *endStr = self.endTextField.text;
    if (startStr.length == 0 || endStr.length == 0) {
        return;
    }
    
    weakSelf(weakSelf);
    //反地理编码
    [self.geoCoder geocodeAddressString:startStr completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count==0) {
            return ;
        }
        
        CLPlacemark *startPlaceMark = [placemarks firstObject];
        
        [self.geoCoder geocodeAddressString:endStr completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (placemarks.count==0) {
                return ;
            }
            CLPlacemark *endPlaceMark = [placemarks firstObject];
            //开始请求服务器端的路线信息
            [weakSelf goDrawUpNavigateRouteWithStartCLPlaceMark:startPlaceMark endPlacemark:endPlaceMark];
        }];
        
    }];
}

- (MKMapItem*)mapItemWithCLPlacemark:(CLPlacemark*)placemark{
    return [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithPlacemark:placemark]];
}

- (MKDirections*)directionsWirhStartCLPlaceMark:(CLPlacemark*)startPlacemark endPlacemark:(CLPlacemark*)endPlacemark{
    MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc]init];
    directionsRequest.source = [self mapItemWithCLPlacemark:startPlacemark];
    directionsRequest.destination = [self mapItemWithCLPlacemark:endPlacemark];
    MKDirections *directions = [[MKDirections alloc]initWithRequest:directionsRequest];
    return directions;
}

- (void)goDrawUpNavigateRouteWithStartCLPlaceMark:(CLPlacemark*)startPlacemark endPlacemark:(CLPlacemark*)endPlacemark{
    MKDirections *directions = [self directionsWirhStartCLPlaceMark:startPlacemark endPlacemark:endPlacemark];
    //开始请求数据
    weakSelf(weakself);
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return ;
        }
        //获取返回的数据 MKDirectionsResponse
        NSLog(@"%@",response);//response.routes  MKRoute
        DKMapViewController *mapViewController= [[DKMapViewController alloc]init];
        mapViewController.response = response;
        [weakself.navigationController pushViewController:mapViewController animated:YES];
    }];
    
    
}


@end
