

#import "DKAnnotation.h"

@implementation DKAnnotation

+ (instancetype)annotationWithPlacemark:(CLPlacemark *)placemark{
    DKAnnotation *startAnnotation = [[DKAnnotation alloc]init];
    startAnnotation.coordinate = placemark.location.coordinate;
    startAnnotation.title = placemark.name;
    startAnnotation.subtitle = placemark.locality;
    return startAnnotation;
}

@end
