//
//  DDAnnotation.h
//  MapKitDragAndDrop 3.2 (Released under MIT License)
//
//  Created by digdog on 7/24/09.
//  Copyright 2009-2010 Ching-Lan 'digdog' HUANG. http://digdog.tumblr.com
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//   
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//   
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//



@interface DDAnnotation : BMKPointAnnotation {
//	CLLocationCoordinate2D coordinate_;
//	NSString *title_;
//	NSString *subtitle_;
    NSDictionary *customInfo_;
    NSInteger index;
    
}

// Re-declare MKAnnotation's readonly property 'coordinate' to readwrite. 
//@property (nonatomic, readwrite, assign) CLLocationCoordinate2D coordinate;

//@property (nonatomic, copy) NSString *title;
//@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSDictionary *customInfo;
@property (nonatomic, assign) NSInteger index;
@end
