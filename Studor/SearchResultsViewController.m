//
//  SearchResultsViewController.m
//  Studor
//
//  Created by Marton Pono on 5/3/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "Helpers.h"
#import "BookTutorViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface SearchResultsViewController ()

@property (retain, nonatomic) NSArray *tutors;
@property PFObject *selectedTutor;



@end

@implementation SearchResultsViewController

CLLocationManager *locationManager;
CLLocation *currentLocation;
BOOL found;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
   
    NSString *string1 =  self.subject[@"subject"];
    NSString *string2 = @" tutors in your area.";
    
    string1 = [string1 stringByAppendingString:string2];


    self.resultLabel.text = string1;
    
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

    
    if([self.tutors count]==0){
        tableView.hidden = true;
        self.resultLabel.text = @"There are no tutors in your area.";
    }
    else{
        [tableView reloadData];}
    
    
    
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
    found = true;
    [locationManager stopUpdatingLocation];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Profile"];
    [query whereKey:@"username" notEqualTo: [Helpers getProfile][@"username"]];
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
    /*static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
    }
    
    // cell.textLabel.text = self.tutors[indexPath.row][@"email"]; */
    
    PFObject *object = self.tutors[indexPath.row];
    
    static NSString *simpleTableIdentifier = @"TutorCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        // NSLog(@"make a new cell");
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    PFGeoPoint *tutorpoint = object[@"location"];
    CLLocation *tutorLocation = [[CLLocation alloc ] initWithLatitude:tutorpoint.latitude longitude:tutorpoint.longitude];
    CLLocationDistance distance = [currentLocation distanceFromLocation:tutorLocation];
    
    // Configure the cell
    
        PFFile *thumbnail = [object objectForKey:@"image"];
        PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
        
        thumbnailImageView.image = [UIImage imageNamed:@"default-pic.jpg"];
        thumbnailImageView.file = thumbnail;
        [thumbnailImageView loadInBackground];
    
    [thumbnailImageView.layer setBorderColor: [[UIColor colorWithRed:15.0f/255.0f green:166.0f/255.0f blue:182.0f/255.0f alpha:1.0] CGColor]];
    [thumbnailImageView.layer setBorderWidth: 2.0];
    
        UILabel *name = (UILabel*) [cell viewWithTag:106];
        UILabel *bioLabel = (UILabel*)[cell viewWithTag:133];
        UILabel *hourlyRateLabel = (UILabel*) [cell viewWithTag:112];
        UILabel *distanceLabel = (UILabel*) [cell viewWithTag:155];
    
        bioLabel.text = object[@"bio"];
        distanceLabel.text = [NSString stringWithFormat:@"%d miles", (int)(distance*0.000621371)];
        name.text = [NSString stringWithFormat:@"%@", [object objectForKey:@"firstName"]];
        hourlyRateLabel.text = [NSString stringWithFormat:@"$%@ /hour", [[object objectForKey:@"hourlyRate"] stringValue]];
    // this code would hide a cell
   /*
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.userInteractionEnabled = NO;
    */
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pickTutorSegue"])
    {
        BookTutorViewController *destViewController = segue.destinationViewController;
        destViewController.tutorProfile = self.selectedTutor;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.selectedTutor = self.tutors[indexPath.row];
    [self performSegueWithIdentifier:@"pickTutorSegue" sender:self];
    
    
    
}


@end
