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
#import "Helpers.h"
#import <CoreLocation/CoreLocation.h>




@interface TutorCenterViewController()
@property (retain, nonatomic) NSMutableArray *requests;
@end

@implementation TutorCenterViewController

CLLocationManager *locationManager;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    self.requests = [[NSMutableArray alloc] init];
    PFObject *profile = [Helpers getProfile];
    if (![profile[@"isAvailable"] boolValue]) {
        NSLog(@"nope not available");
        [_toggleAvailability setOn:NO animated:YES];
    }
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

- (IBAction)toggleAvailable:(id)sender {
    PFObject *profile = [Helpers getProfile];
    if([sender isOn]){
        NSLog(@"available");


        
        locationManager = [[CLLocationManager alloc]init]; // initializing locationManager
        locationManager.delegate = self; // we set the delegate of locationManager to self.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest; // setting the accuracy
        [locationManager requestWhenInUseAuthorization];
        [locationManager startUpdatingLocation];  //requesting location updates
        
        
        profile[@"isAvailable"] = @YES;
    } else {
        NSLog(@"not available");
        profile[@"isAvailable"] = @NO;
    }
    [profile saveInBackground];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"yoyoyo");
    CLLocation *crnLoc = [locations lastObject];
    PFObject *profile = [Helpers getProfile];
    profile[@"location"] = [PFGeoPoint geoPointWithLocation:crnLoc];
    [profile save];
    [locationManager stopUpdatingLocation];
    
    
    
}




@end