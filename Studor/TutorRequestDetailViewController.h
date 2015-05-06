//
//  TutorRequestDetailViewController.h
//  Studor
//
//  Created by Marton Pono on 5/4/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface TutorRequestDetailViewController : UIViewController

@property (retain, strong) NSString *type;
@property (retain, strong) PFObject *request;

@property (weak, nonatomic) IBOutlet PFImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
- (IBAction)cancelButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
- (IBAction)startButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;


- (IBAction)acceptButtonPressed:(id)sender;

@end
