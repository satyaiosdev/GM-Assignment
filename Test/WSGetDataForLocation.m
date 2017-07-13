//
//  WSGetDataForLocation.m
//  Test
//
//  Created by Satya Venkata Krishna Achanta on 10/07/17.
//  Copyright © 2017 Satya Venkata Krishna Achanta. All rights reserved.
//

#import "WSGetDataForLocation.h"
#import "Global.h"

@implementation WSGetDataForLocation

-(void)getDataFromWUwithLat:(NSString *)lat andLongitude:(NSString *)lng{

    
    NSString *urlAsString = [NSString stringWithFormat:@"http://api.wunderground.com/api/%@/geolookup/q/%@,%@.json",API_KEY,lat,lng];
    
    
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
    
    NSLog(@"Response:%@",dic);
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateMap" object:dic];
    
}

@end
