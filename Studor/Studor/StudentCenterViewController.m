//
//  StudentCenterViewController.m
//  Studor
//
//  Created by Iris Yuan on 5/2/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "StudentCenterViewController.h"
#import <Parse/Parse.h>


@interface StudentCenterViewController()
    @property (retain, nonatomic) NSMutableArray *requests;
@end

@implementation StudentCenterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.requests = [[NSMutableArray alloc] init];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSLog([NSString stringWithFormat:@"Requests %lu", [_requests count]]);
    return [self.requests count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
    }
    cell.textLabel.text = self.requests[indexPath.row];
    return cell;
}*/


@end
