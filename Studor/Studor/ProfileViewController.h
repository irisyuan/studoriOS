//
//  ProfileViewController.h
//  Studor
//
//  Created by Iris Yuan on 4/14/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

- (IBAction)logoutButtonPressed:(id)sender;

@end

