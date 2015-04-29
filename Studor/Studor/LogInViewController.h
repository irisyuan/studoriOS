//
//  ViewController.h
//  Studor
//
//  Created by Omid Keypour on 4/8/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface LogInViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *login;

- (IBAction)pressLogin:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *ErrorLabel;



@end

