//
//  ViewController.m
//  Test
//
//  Created by Satya Venkata Krishna Achanta on 10/07/17.
//  Copyright © 2017 Satya Venkata Krishna Achanta. All rights reserved.
//

#import "ViewController.h"
#import "WSGetDataForLocation.h"
#import "CustomAnnotation.h"
#import "DetailVC.h"
#import "WSGetWeatherForeCast.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
NSString *latitude, *longitude;
CLLocationCoordinate2D locCoord;
NSString *cityState;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [super viewDidLoad];
    _mapView.mapType = MKMapTypeStandard;
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.mapView addGestureRecognizer:longPressGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMapInfo:) name:@"UpdateMap" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentNewScreen:) name:@"PresentNewScreen" object:nil];




}

//
-(void)viewDidAppear:(BOOL)animated{
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        [self showAlertMessage:@"Please long tap on the map to get weather information for that location!"];
    });
    
}

#pragma mark - Web Services Call
-(void)getData{
    
    WSGetDataForLocation *ws = [WSGetDataForLocation new];
    [ws getDataFromWUwithLat:latitude andLongitude:longitude];
    
    
}

-(void)updateMapInfo:(NSNotification *)notification{
    
    NSDictionary *dic = notification.object;
    
    [_mapView removeAnnotations:_mapView.annotations];
    
    cityState = [NSString stringWithFormat:@"%@,%@",[[dic valueForKey:@"location"]valueForKey:@"city"],[[dic valueForKey:@"location"]valueForKey:@"state"]];
    
    WSGetWeatherForeCast *ws = [WSGetWeatherForeCast new];
    [ws getWeatherForecastOfCity:[[dic valueForKey:@"location"]valueForKey:@"city"] ofState:[[dic valueForKey:@"location"]valueForKey:@"state"]];

}

#pragma mark - Prepare for Segue
-(void)presentNewScreen:(NSNotification *)notification{
    
    NSDictionary *dc = notification.object;
    
    if ([dc count] > 0) {
        [self performSegueWithIdentifier:@"gotoDetailVC" sender:notification.object];
    }else{
        [self showAlertMessage:@"No information available for the chosen area. Please choose a different location!"];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"gotoDetailVC"]) {
        DetailVC *dvc = segue.destinationViewController;
        dvc.strTitle = cityState;
        dvc.dictWeatherInfo = sender;
    }
}



#pragma mark - Handle Long Tap
-(void)handleLongPressGesture:(UIGestureRecognizer*)sender {
    // This is important if you only want to receive one tap and hold event
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"Released!");

        [self showAlertMessage:@"Downloading data for this location!"];

        
    }
    else
    {
        // Here we get the CGPoint for the touch and convert it to latitude and longitude coordinates to display on the map
        CGPoint point = [sender locationInView:self.mapView];
        locCoord = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        // Then all you have to do is create the annotation and add it to the map
        NSLog(@"%f-----%f",locCoord.latitude,locCoord.longitude);
        
        latitude = [NSString stringWithFormat:@"%f",locCoord.latitude];
        longitude = [NSString stringWithFormat:@"%f",locCoord.longitude];
        
        [_mapView removeAnnotations:_mapView.annotations];
        
        CustomAnnotation *anno=[[CustomAnnotation alloc] initWithTitle:@"" logo:[UIImage imageNamed:@"pin"] Location:locCoord];
        [_mapView addAnnotation:anno];  
     
    }
}

#pragma mark - MKMapView delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[CustomAnnotation class]])
    {
        CustomAnnotation *myLocation=(CustomAnnotation *) annotation;
        MKAnnotationView *annotationView=[mapView dequeueReusableAnnotationViewWithIdentifier:@"MyCustomAnnotaion"];
        if (annotationView==nil)
            annotationView=myLocation.annotaionView;
        else
            annotationView.annotation=annotation;

        return annotationView;
    }
    else
        return nil;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Alert View
-(void) showAlertMessage:(NSString *)msg{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Message"
                                 message:msg
                                 preferredStyle:UIAlertControllerStyleAlert];
    
   if([msg isEqualToString:@"Downloading data for this location!"]){
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle ok
                                       [self getData];
                                   }];
        [alert addAction:okButton];
    }else{
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle ok
                                       
                                   }];
        [alert addAction:okButton];
    }
   

    [self presentViewController:alert animated:YES completion:nil];
    
}




@end
