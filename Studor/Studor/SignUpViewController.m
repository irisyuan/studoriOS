//
//  SignUpViewController.m
//  Studor
//
//  Created by Marton Pono on 4/20/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "SignUpViewController.h"
#import "Helpers.h"
#import <Parse/Parse.h>


@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    _MainErrorLabel.text = @"";
    _FirstNameErrorLabel.text = @"";
    _LastNameErrorLabel.text = @"";
    _PasswordErrorLabel.text = @"";
    _ZipCodeErrorLabel.text = @"";
    _EmailErrorLabel.text = @"";

    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)signUpButtonPressed:(id)sender {
    
    
    
    NSMutableDictionary *errors = [[NSMutableDictionary alloc] init];
    NSString *firstName = _FirstNameField.text;
    if([firstName length] == 0){
        [errors setObject:@"Please provide a valid first Name" forKey:@"FirstName"];
    }
    NSString *lastName =  _LastNameField.text;
    if([lastName length] == 0){
        [errors setObject:@"Please provide a valid last Name" forKey: @"LastName"];
    }
    NSString *email = _EmailField.text;
    if(![Helpers NSStringIsValidEmail:email]){
        [errors setObject:@"Please provide a valid email" forKey:@"Email"];
    }
    
    NSString *password = _PasswordField.text;
    if([password length] < 8){
        [errors setObject:@"Password must contain at least 8 characters." forKey: @"Password"];
    }
    NSString *zipCode = _ZipCodeField.text;
    if(![Helpers NSStringIsValidZipCode:zipCode]){
        [errors setObject:@"Please provide a valid zip code" forKey: @"ZipCode"];
    }
    
    
    PFUser *user = [PFUser user];
    user.username = email;
    user.password = password;
    user[@"firstName"] = firstName;
    user[@"lastName"] = lastName;
    user[@"zipCode"] = zipCode;
    
    if([errors count]!=0){
    for(NSString *key in errors){
        NSString *value = [errors objectForKey:key];
        
        if([key isEqualToString:@"FirstName"]){
            _FirstNameErrorLabel.text = value;
        }
        if([key isEqualToString:@"LastName"]){
            _LastNameErrorLabel.text = value;

            }
        if([key isEqualToString:@"Email"]){
            _EmailErrorLabel.text = value;

        }
        if([key isEqualToString:@"Password"]){
            _PasswordErrorLabel.text = value;

        }
        if([key isEqualToString:@"ZipCode"]){
            _ZipCodeErrorLabel.text = value;
        }
    }
    }
    else{
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                [self performSegueWithIdentifier:@"ifSignUpSuccess" sender:nil];

                
            } else {
                NSString *errorString = [error userInfo][@"error"];
                _MainErrorLabel.text = errorString;
            }
        }];
    }
}


//making the keyboard disapear when clicking an empty space
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
