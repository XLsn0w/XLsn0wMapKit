

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DKAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;


@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

+ (instancetype)annotationWithPlacemark:(CLPlacemark*)placemark;

@end
