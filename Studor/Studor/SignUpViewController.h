//
//  SignUpViewController.h
//  Studor
//
//  Created by Marton Pono on 4/20/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *MainErrorLabel;

@property (weak, nonatomic) IBOutlet UITextField *FirstNameField;
@property (weak, nonatomic) IBOutlet UITextField *LastNameField;
@property (weak, nonatomic) IBOutlet UITextField *EmailField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordField;
@property (weak, nonatomic) IBOutlet UITextField *ZipCodeField;
@property (weak, nonatomic) IBOutlet UILabel *FirstNameErrorLabel;
@property (weak, nonatomic) IBOutlet UILabel *LastNameErrorLabel;
@property (weak, nonatomic) IBOutlet UILabel *EmailErrorLabel;
@property (weak, nonatomic) IBOutlet UILabel *PasswordErrorLabel;
@property (weak, nonatomic) IBOutlet UILabel *ZipCodeErrorLabel;

@end
