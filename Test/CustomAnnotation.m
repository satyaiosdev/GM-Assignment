//
//  CustumAnnotaion.m
//  OMBS
//
//  Created by Satya Venkata Krishna Achanta on 11/07/17.
//  Copyright © 2017 Satya Venkata Krishna Achanta. All rights reserved.
//

#import "CustomAnnotation.h"
@implementation CustomAnnotation
-(id) initWithTitle:(NSString *) newTitle  logo:(UIImage *) logo Location:(CLLocationCoordinate2D) location
{
    self=[super init];
    if(self)
    {
        _title=newTitle;
        _coordinate=location;
        _logoimage=logo;
    }
    return self;
}
-(MKAnnotationView *) annotaionView
{
    MKAnnotationView  *annotaionView=[[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"MyCustomAnnotaion"];
    annotaionView.enabled=YES;
    annotaionView.canShowCallout=YES;
    annotaionView.image=_logoimage;

    return annotaionView;
}
@end
