//
//  BookTutorViewController.m
//  Studor
//
//  Created by Marton Pono on 5/4/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "BookTutorViewController.h"
#import "Helpers.h"
#import "MapViewContainerViewController.h"

@interface BookTutorViewController ()

@end

@implementation BookTutorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog([self.tutorProfile objectId]);
    
    // Do any additional setup after loading the view.
    
    NSString *firstName = self.tutorProfile[@"firstName"];
    
    PFFile *imageFile = self.tutorProfile[@"image"];
    if (imageFile) {
        _image.file = imageFile;
        [_image loadInBackground];
    } else {
        _image.image = [UIImage imageNamed:@"default-pic.png"];
    }
    
    [_image.layer setBorderColor: [[UIColor colorWithRed:15.0f/255.0f green:166.0f/255.0f blue:182.0f/255.0f alpha:1.0] CGColor]];
    [_image.layer setBorderWidth: 2.0];
    
    _nameLabel.text = [NSString stringWithFormat:@"%@", firstName];
    _hourlyRateLabel.text = [NSString stringWithFormat:@"$%@ per hour", [self.tutorProfile[@"hourlyRate"] stringValue]];
    _bioLabel.text = self.tutorProfile[@"bio"];
    
    _subjectsLabel.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bookTutor:(id)sender {
    
    PFObject *request = [PFObject objectWithClassName:@"Request"];
    request[@"tutorId"] = self.tutorProfile[@"username"];
    request[@"studentId"] = [Helpers getProfile][@"email"];
    request[@"requestDesc"] = _requestDescField.text;
    request[@"rate"] = self.tutorProfile[@"hourlyRate"];
    
    //Location
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[self.latitude doubleValue] longitude:[self.longtitude doubleValue]];
    
    PFGeoPoint *geolocation = [PFGeoPoint geoPointWithLocation:location];
    
    request[@"location"] = geolocation;
    
    //request[@"subjectId"] = _subjectsLabel.text;
    
    [request saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // segue to Student Center
            [self performSegueWithIdentifier:@"bookToStudentCenter" sender:nil];
        } else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Error booking session. Please try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{   NSLog(@"Peforming Editable Segue");
    
    if ([[segue identifier] isEqualToString:@"segueToMap"])
    {

        MapViewContainerViewController *destViewController = segue.destinationViewController;
        destViewController.currentLocation = self.currentLocation; 
        destViewController.parentVC = self;
        
    }
    
}

@end
