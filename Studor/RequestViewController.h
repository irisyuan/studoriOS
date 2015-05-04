//
//  RequestViewController.h
//  Studor
//
//  Created by Iris Yuan on 4/14/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface RequestViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *requestButton;

@property (weak, nonatomic) IBOutlet UITextField *requestBox;
@property (weak, nonatomic) IBOutlet UITextField *subjectBox;
@property (weak, nonatomic) IBOutlet UITextField *zipCodeBox;
- (IBAction)requestButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *requestErrorLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectErrorLabel;
@property (weak, nonatomic) IBOutlet UILabel *zipCodeErrorLabel;

@property (weak, nonatomic) IBOutlet UILabel *generalErrorLabel;


@end
