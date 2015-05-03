//
//  ProfileViewController.m
//  Studor
//
//  Created by Iris Yuan on 4/14/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "SWRevealViewController.h"

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    _successLabel.text = @"";
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}


// To do: need to add same validation as sign up page here
- (IBAction)saveButtonPressed:(id)sender {
    PFQuery *updateProfile = [PFQuery queryWithClassName:@"Profile"];
    [updateProfile whereKey:@"username" equalTo:PFUser.currentUser.username];
    
    [updateProfile getFirstObjectInBackgroundWithBlock:^(PFObject *currentProfile, NSError *error) {
        if (!error) {
            currentProfile[@"firstName"] = _firstNameField.text;
            currentProfile[@"lastName"] = _lastNameField.text;
            currentProfile[@"email"] = _emailField.text;
            currentProfile[@"zipCode"] = _zipCodeField.text;
    
            // If not tutor, this is blank anyways
            currentProfile[@"bio"] = _bioField.text;
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            f.numberStyle = NSNumberFormatterDecimalStyle;
            NSNumber *hourlyRate = [f numberFromString:_hourlyRateField.text];
            
            currentProfile[@"hourlyRate"] = hourlyRate;
            
            [currentProfile saveInBackground];
            _successLabel.text = @"Profile saved!";
        } else {
            _successLabel.text = @"Oops, try again later.";
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)editButtonPressed:(id)sender {
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    
    // Get current user information
    PFQuery *query = [PFQuery queryWithClassName:@"Profile"];
    NSString *currentUser = PFUser.currentUser.username;
    
    NSLog(@"%@", currentUser);
    [query whereKey:@"username" equalTo:currentUser];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object) {
            NSLog(@"The getFirstObject request failed.");
        } else {
            NSLog(@"Successfully retrieved the object.");
            
            NSString *isTutor = [object objectForKey:@"isTutor"];
            if (!isTutor) {
                [_bioField setHidden:TRUE];
                [_hourlyRateField setHidden:TRUE];
            } else {
                _bioField.text = [object objectForKey:@"bio"];
                // add later
                // _hourlyRateField.text = [object objectForKey:@"hourlyRate"];
            }
            
            // Populate fields on default non-editing mode
            NSString *firstName = [object objectForKey:@"firstName"];
            NSString *lastName = [object objectForKey:@"lastName"];
            NSString *zipCode = [object objectForKey:@"zipCode"];
            NSString *email = [object objectForKey:@"email"];
            
            _firstNameField.text = firstName;
            _lastNameField.text = lastName;
            _emailField.text = email;
            _zipCodeField.text = zipCode;
        }
    }];

}

@end
