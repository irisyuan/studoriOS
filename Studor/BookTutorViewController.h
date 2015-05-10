//
//  BookTutorViewController.h
//  Studor
//
//  Created by Marton Pono on 5/4/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <CoreLocation/CoreLocation.h>


@interface BookTutorViewController : UIViewController

@property (nonatomic, strong) PFObject *tutorProfile;

@property (weak, nonatomic) IBOutlet PFImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourlyRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectsLabel;
@property (weak, nonatomic) IBOutlet UITextField *requestDescField;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longtitude;
@property (strong, nonatomic) CLLocation *currentLocation;

/*
// changed this to textfield
 
@property (weak, nonatomic) IBOutlet UITextView *requestDescField;

*/

@property (weak, nonatomic) IBOutlet UIButton *bookButton;
- (IBAction)bookTutor:(id)sender;


@end