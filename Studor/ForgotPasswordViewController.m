//
//  ForgotPasswordViewController.m
//  Studor
//
//  Created by Iris Yuan on 4/29/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <Parse/Parse.h>
#import "ForgotPasswordViewController.h"
#import "Helpers.h"

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    _EmailErrorLabel.text = @"";
    [super viewDidLoad];
}

- (IBAction)sendReset:(id)sender {
    
    NSString *email = _EmailField.text;
    NSLog(@"%@", email);
    
    // use helpers to test if the email format is valid, but don't display whether email exists for security purposes
    if(![Helpers NSStringIsValidEmail:email]){
        _EmailErrorLabel.text = @"Please provide a valid email.";
    } else {
        // user directed to a special Parse page that will allow them type in a new password
        _EmailErrorLabel.text = @"";
        [PFUser requestPasswordResetForEmailInBackground:email];
        
       [self performSegueWithIdentifier:@"ForgotPasswordConfirmation" sender:nil];
    }
}


@end
