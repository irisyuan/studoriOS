//
//  SearchResultsViewController.m
//  Studor
//
//  Created by Marton Pono on 5/3/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "Helpers.h"


@interface SearchResultsViewController ()

@property (retain, nonatomic) NSArray *tutors;


@end

@implementation SearchResultsViewController

CLLocationManager *locationManager;
CLLocation *currentLocation;
BOOL found;


- (void)viewDidLoad {
    [super viewDidLoad];
    found = false;
    locationManager = [[CLLocationManager alloc]init]; // initializing locationManager
    locationManager.delegate = self; // we set the delegate of locationManager to self.
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // setting the accuracy
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];  //requesting location updates

    
    // Do any additional setup after loading the view.
}

- (void) updateSearchResults {
    
    UITableView *tableView = (id)[self.view viewWithTag:1];
    [tableView reloadData];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"location found");

    CLLocation *crnLoc = [locations lastObject];
    currentLocation = crnLoc;
    [locationManager stopUpdatingLocation];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Profile"];
    [query whereKey:@"isTutor" equalTo:(@YES)];
    [query whereKey:@"isAvailable" equalTo:@YES];
    [query whereKey:@"subjects" equalTo:[self.subject objectId]];
    [query whereKey:@"location" nearGeoPoint:[PFGeoPoint geoPointWithLocation:currentLocation]];
    
     self.tutors = [query findObjects];
     NSLog([NSString stringWithFormat:@"%lu ", [self.tutors count]]);
     [self updateSearchResults];

    
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSLog([NSString stringWithFormat:@"%lu ", [self.tutors count]]);

    
    return [self.tutors count];
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
    
    cell.textLabel.text = self.tutors[indexPath.row][@"email"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    
    
    
}


@end
