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
#import <AVFoundation/AVFoundation.h>

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
    
    PFFile *imageFile = profile[@"image"];
    
    if (imageFile) {
        _photo.file = imageFile;
        [_photo loadInBackground];
    } else {
        // Use default picture if there isn't one in Parse
     _photo.image = [UIImage imageNamed:@"default-pic.png"];

    }
    
    [_photo.layer setBorderColor: [[UIColor colorWithRed:15.0f/255.0f green:166.0f/255.0f blue:182.0f/255.0f alpha:1.0] CGColor]];
    [_photo.layer setBorderWidth: 2.0];
    
    if (![profile[@"isTutor"] boolValue]) {
        [_bioField setHidden:TRUE];
        [_hourlyRateField setHidden:TRUE];
        [_subjectsButton setHidden:TRUE];
        [_bioLabel setHidden:TRUE];
        [_dollarSign setHidden:TRUE];
        [_perHourLabel setHidden:TRUE];
        [_saveButton setHidden:TRUE];
         
    } else {
        _bioField.text = profile[@"bio"];
        _hourlyRateField.text = [profile[@"hourlyRate"] stringValue];
    }
    
   // _photo.layer.borderWidth = 7;
   // _photo.layer.borderColor = [UIColor colorWithRed:0.22 green:0.22 blue:0.22 alpha:1.0].CGColor;
    
    // this is the key command
    //[_photo setFrame:AVMakeRectWithAspectRatioInsideRect(_photo.size, _photo.frame)];
    
}

// To do: need to add same validation as sign up page here
- (IBAction)saveButtonPressed:(id)sender {
    PFObject *currentProfile = [Helpers getProfile];
    
    // If not tutor, this is blank anyways
    if ([currentProfile[@"isTutor"] boolValue]) {
    currentProfile[@"bio"] = _bioField.text;
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *hourlyRate = [f numberFromString:_hourlyRateField.text];
    currentProfile[@"hourlyRate"] = hourlyRate;
    }

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
