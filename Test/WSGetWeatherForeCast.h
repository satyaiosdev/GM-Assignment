//
//  WSGetWeatherForeCast.h
//  Test
//
//  Created by Satya Venkata Krishna Achanta on 11/07/17.
//  Copyright © 2017 Satya Venkata Krishna Achanta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSGetWeatherForeCast : NSObject

-(void)getWeatherForecastOfCity:(NSString *)city ofState:(NSString *)state;

@end
