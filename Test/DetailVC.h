//
//  DetailVC.h
//  Test
//
//  Created by Satya Venkata Krishna Achanta on 11/07/17.
//  Copyright © 2017 Satya Venkata Krishna Achanta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailVC : UIViewController<UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UINavigationItem *navi;

- (IBAction)goBack:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tblView;

@property(nonatomic,strong) NSString * strTitle;
@property(nonatomic,strong) NSDictionary * dictWeatherInfo;

@end
