//
//  WSGetWeatherForeCast.m
//  Test
//
//  Created by Satya Venkata Krishna Achanta on 11/07/17.
//  Copyright © 2017 Satya Venkata Krishna Achanta. All rights reserved.
//

#import "WSGetWeatherForeCast.h"
#import "Global.h"

@implementation WSGetWeatherForeCast

-(void)getWeatherForecastOfCity:(NSString *)city ofState:(NSString *)state{
    
    
    NSString *urlAsString = [NSString stringWithFormat:@"http://api.wunderground.com/api/%@/forecast/q/%@/%@.json",API_KEY,state,city];
    
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];

    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSLog(@"URL>>>>>>>>>>>>>%@",url);
    
    NSDictionary *dictionaryLocal = [NSDictionary new];
    if (data) {
        dictionaryLocal = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
        NSLog(@"ResponseCity:%@",dictionaryLocal);
        
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"PresentNewScreen" object:dictionaryLocal];
    

}

@end

