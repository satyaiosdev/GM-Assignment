//
//  CustumAnnotaion.h
//  OMBS
//
//  Created by Satya Venkata Krishna Achanta on 11/07/17.
//  Copyright © 2017 Satya Venkata Krishna Achanta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface CustomAnnotation : NSObject <MKAnnotation>
@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) UIImage *logoimage;
-(id) initWithTitle:(NSString *) newTitle  logo:(UIImage *) logo Location:(CLLocationCoordinate2D) location;
-(MKAnnotationView *) annotaionView;
@end
