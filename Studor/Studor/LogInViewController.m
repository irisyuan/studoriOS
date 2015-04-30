//
//  ViewController.m
//  Studor
//
//  Created by Omid Keypour on 4/8/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "LogInViewController.h"
#import <Parse/Parse.h>

@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) { // goes to tab bar controller automatically if there is already a user logged in
        [self performSegueWithIdentifier:@"loginSuccessful" sender:nil];
    }
    
    _ErrorLabel.text = @"";
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressLogin:(id)sender {

    
    [PFUser logInWithUsernameInBackground:_usernameTextField.text password:_passwordTextField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) { //login successful
                                            /*
                                            UIStoryboard *HomeStoryboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
                                            UIViewController *HomeViewController = [HomeStoryboard instantiateInitialViewController];
                                          
                                            
                                            [self.navigationController pushViewController:HomeViewController animated:YES];*/
                                            
                                            
                                            [self performSegueWithIdentifier:@"loginSuccessful" sender:nil];

                                        } else { //login failed
                                            _ErrorLabel.text = @"You entered the incorrect username or password.";
                                        }
                                    }];

}

//making the keyboard disapear when clicking an empty space
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}




@end
