//
//  Mapcoding.h
//  MaoDemo
//
//  Created by enway_liang on 16/1/18.
//  Copyright © 2016年 wangbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^latitudeStr)(NSString *lat);//纬度
typedef void(^longitudeStr)(NSString *lon);//经度
typedef void(^getMapcoding)(NSMutableDictionary *mapCodDic);//存放获取到的信息的字典
typedef void(^getAddressName)(NSString *addressName);

@interface Mapcoding : NSObject
@property (nonatomic,copy) latitudeStr getlatitudeStr;
@property (nonatomic,copy) longitudeStr getlongitudeStr;
@property (nonatomic,copy) getMapcoding getMapcoding;
@property (nonatomic,copy) getAddressName addressName;
@property (nonatomic,strong) CLGeocoder *geocoder;

//根据输入的地址,得到地址相关<存在mapCoding字典中>
-(void)getMapcoding:(NSString *)mapcod getMapcoding:(getMapcoding)mapCoding;

//如果只需要得到经纬度,只需要传入mapcod(输入地址的字符串)  latitude<返回的纬度> longitude<返回的经度>
-(void)getMapcoding:(NSString *)mapcod getlatitude:(latitudeStr)latitude getlongitudeStr:(longitudeStr)longitude;
/*----------------------------------------------*/
//根据输入的经纬度,得到地址相关<存在mapCoding字典中>
-(void)getAddressName:(NSString *)latitudeStr longitudeStr:(NSString *)longitudeStr getMapcoding:(getMapcoding)mapCoding;
//如果只需要地址,只需要传入<latitude(纬度),longitude(经度)>    返回addressName<返回的地址>
-(void)getAddressName:(NSString *)latitude getlongitudeStr:(NSString *)longitude backAddressName:(getAddressName)addressName;


@end
