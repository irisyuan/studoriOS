//
//  TutorCenterViewController.m
//  Studor
//
//  Created by Iris Yuan on 5/2/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "TutorCenterViewController.h"
#import <Parse/Parse.h>
#import "SWRevealViewController.h"



@interface TutorCenterViewController()
@property (retain, nonatomic) NSMutableArray *requests;
@end

@implementation TutorCenterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    
    self.navigationController.navigationBar.hidden = YES;
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }


    self.requests = [[NSMutableArray alloc] init];
    /*
     PFQuery *query = [PFQuery queryWithClassName:@"Request"];
     NSArray *objects = [query whereKey:@"studentId" equalTo:PFUser.currentUser.username];
     
     for (int x = 0; x < [objects count]; x++) {
     
     [self.requests addObject:[NSString stringWithString:objects[x][@"subject"] ]];
     }
     
     for (int x = 0; x < [self.requests count]; x++) {
     NSLog(self.requests[x]);
     }
     
     
     UITableView *tableView = (id)[self.view viewWithTag:1];
     UIEdgeInsets contentInset = tableView.contentInset;
     contentInset.top = 20;
     [tableView setContentInset:contentInset];
     
     
     // if no pending requests, hide label
     [_PendingRequestsLabel setHidden:TRUE];
     // if no past sessions, hide label
     [CurrentSessionsLabel setHidden:TRUE];
     // if no current sessions, hide label
     [_PastSessionsLabel setHidden:TRUE];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
}


@end