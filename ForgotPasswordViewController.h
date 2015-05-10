//
//  ForgotPasswordViewController.h
//  Studor
//
//  Created by Iris Yuan on 4/29/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ForgotPasswordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *EmailField;
@property (weak, nonatomic) IBOutlet UILabel *EmailErrorLabel;
@property (weak, nonatomic) IBOutlet UIButton *SendEmailButton;
- (IBAction)backButtonPressed:(id)sender;
- (IBAction)sendReset:(id)sender;

@end
