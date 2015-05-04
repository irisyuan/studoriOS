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
#import "Helpers.h"

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

-(void)viewWillAppear:(BOOL)animated {
    
    PFObject *profile = [Helpers getProfile];
    _nameLabel.text = [NSString stringWithFormat:@"%@ %@", profile[@"firstName"], profile[@"lastName"]];
    _emailLabel.text = profile[@"email"];
    _zipCodeField.text = profile[@"zipCode"];
    
    PFFile *imageFile = profile[@"image"];
    if (imageFile) {
        _photo.file = imageFile;
        [_photo loadInBackground];
    } else {
        // Use default picture if there isn't one in Parse
        _photo.image = [UIImage imageNamed:@"default-pic.png"];
    }
    
    if (![profile[@"isTutor"] boolValue]) {
        [_bioField setHidden:TRUE];
        [_hourlyRateField setHidden:TRUE];
    } else {
        _bioField.text = profile[@"bio"];
        _hourlyRateField.text = [profile[@"hourlyRate"] stringValue];
    }
}

// To do: need to add same validation as sign up page here
- (IBAction)saveButtonPressed:(id)sender {
    PFObject *currentProfile = [Helpers getProfile];
    currentProfile[@"zipCode"] = _zipCodeField.text;
    
    // If not tutor, this is blank anyways
    currentProfile[@"bio"] = _bioField.text;
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *hourlyRate = [f numberFromString:_hourlyRateField.text];
    currentProfile[@"hourlyRate"] = hourlyRate;

    if ([currentProfile saveInBackground]) {
        _successLabel.text = @"Profile saved!";
    } else {
        _successLabel.text = @"Oops, try again later.";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)editButtonPressed:(id)sender {
}

//making the keyboard disapear when clicking an empty space
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
