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
    
    NSString *string1 = @"The following tutors teach ";
    NSString *string2 =  self.subject[@"subject"];
    NSString *string3 = @" in your area.";
    
    string1 = [string1 stringByAppendingString:string2];
    string1 = [string1 stringByAppendingString:string3];

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
    /*static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
    }
    
    // cell.textLabel.text = self.tutors[indexPath.row][@"email"];
    
    // Configure the cell
    PFFile *thumbnail = self.tutors[indexPath.row][@"image"];
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:1];
    thumbnailImageView.image = [UIImage imageNamed:@"default-pic.jpg"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:2];
    UILabel *hourlyRateLabel = (UILabel*) [cell viewWithTag:3];
    
    nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.tutors[indexPath.row][@"firstName"],self.tutors[indexPath.row][@"lastName"]];
    
    NSString *hourlyRate = [self.tutors[indexPath.row][@"hourlyRate"] stringValue];
    hourlyRateLabel.text = [NSString stringWithFormat:@"$%@/hr", hourlyRate];
    
    return cell;*/
    
    PFObject *object = self.tutors[indexPath.row];
    
    static NSString *simpleTableIdentifier = @"TutorCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        // NSLog(@"make a new cell");
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    // Configure the cell
    PFFile *thumbnail = [object objectForKey:@"image"];
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:1];
    thumbnailImageView.image = [UIImage imageNamed:@"default-pic.jpg"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    
   // UILabel *emailLabel = (UILabel*) [cell viewWithTag:101];
    UILabel *name = (UILabel*) [cell viewWithTag:2];
   // UILabel *subjectsLabel = (UILabel*)[cell viewWithTag:1];
    UILabel *hourlyRateLabel = (UILabel*) [cell viewWithTag:3];
    
    name.text = [NSString stringWithFormat:@"%@ %@", [object objectForKey:@"firstName"],[object objectForKey:@"lastName"]];
    //emailLabel.text = [object objectForKey:@"username"];
    //subjectsLabel.text = [object objectForKey:@"subjectsLabel"];
    hourlyRateLabel.text = [NSString stringWithFormat:@"$%@/hr", [[object objectForKey:@"hourlyRate"] stringValue]];
    
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
