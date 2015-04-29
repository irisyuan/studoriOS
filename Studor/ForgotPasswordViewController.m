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
    [super viewDidLoad];
}

- (IBAction)sendReset:(id)sender {
    // user directed to a special Parse page that will allow them type in a new password
    // test email valid
    NSString *email = _emailField.text;
    

    [PFUser requestPasswordResetForEmailInBackground:email];
    
    
}


@end
