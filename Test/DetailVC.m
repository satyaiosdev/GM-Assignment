//
//  DetailVC.m
//  Test
//
//  Created by Satya Venkata Krishna Achanta on 11/07/17.
//  Copyright © 2017 Satya Venkata Krishna Achanta. All rights reserved.
//

#import "DetailVC.h"
#import "ForeCastTVC.h"


@interface DetailVC ()

@end
NSArray *list;
@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navi.title = _strTitle;
    
    list = [NSArray new];
    
    list = [_dictWeatherInfo valueForKeyPath:@"forecast.txt_forecast.forecastday"];
    NSLog(@"%@",list);
    
    if (list.count==0) {
        [self showAlertMessage:@"Information for the location not found!"];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return list.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentifier = @"cell";
    
    ForeCastTVC *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ForeCastTVC" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSString *strDesc = [NSString stringWithFormat:@"%@/n%@",[[list objectAtIndex:indexPath.row] objectForKey:@"fcttext"],[[list objectAtIndex:indexPath.row] objectForKey:@"fcttext_metric"]];
    cell.lblDesc.text = strDesc;
    
    cell.lblDay.text = [[list objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    cell.imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[list objectAtIndex:indexPath.row] objectForKey:@"icon_url"]]]];
    
    return cell;
    
}

#pragma mark - Alert View
-(void) showAlertMessage:(NSString *)msg{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Message"
                                 message:msg
                                 preferredStyle:UIAlertControllerStyleAlert];
    
 
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle ok
                                       [self goBack:nil];
                                       
                                   }];
        [alert addAction:okButton];

    
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (IBAction)goBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
