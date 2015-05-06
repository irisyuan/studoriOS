//
//  StudentRequestDetailViewController.m
//  Studor
//
//  Created by Marton Pono on 5/4/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "StudentRequestDetailViewController.h"

@interface StudentRequestDetailViewController ()

@end

@implementation StudentRequestDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFQuery *profileQuery = [PFQuery queryWithClassName:@"Profile"];
    [profileQuery whereKey:@"username" equalTo:self.request[@"tutorId"]];
    
    PFObject *profile = [profileQuery getFirstObject];
    PFFile *imageFile = profile[@"image"];
    if (imageFile) {
        _photo.file = imageFile;
        [_photo loadInBackground];
    } else {
        // Use default picture if there isn't one in Parse
        _photo.image = [UIImage imageNamed:@"default-pic.png"];
    }
    
    [_photo.layer setBorderColor: [[UIColor colorWithRed:15.0f/255.0f green:166.0f/255.0f blue:182.0f/255.0f alpha:1.0] CGColor]];
    [_photo.layer setBorderWidth: 2.0];
    
    _nameLabel.text = [NSString stringWithFormat:@"%@ %@", profile[@"firstName"], profile[@"lastName"]];
    _rateLabel.text = [profile[@"rate"] stringValue];
    _descriptionLabel.text = self.request[@"requestDesc"];

    // hide cancel button if session has past
    
    NSLog(@"the type is now: %@", self.type);
    
    if([self.type isEqualToString:@"pending"]){
        [self.cancelButton setTitle:@"Cancel Request" forState:UIControlStateNormal];}
    else if([self.type isEqualToString:@"current"]){
        [self.cancelButton setTitle:@"Cancel Session" forState:UIControlStateNormal];}
    else if([self.type isEqualToString:@"past"]){
        [self.cancelButton setHidden:TRUE];
    }

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButtonPressed:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Are you sure?" message:@"Please confirm you want to cancel this!" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (IBAction)backButtonPressed:(id)sender {
    
    [self dismissMe];
    
}

-(void) dismissMe {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.35;
    transition.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromLeft;
    
    // NSLog(@"%s: controller.view.window=%@", _func_, controller.view.window);
    UIView *containerView = self.view.window;
    [containerView.layer addAnimation:transition forKey:nil];
    
    [self dismissModalViewControllerAnimated:NO];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        // do stuff
       [self.request delete];
        [self performSegueWithIdentifier:@"cancelledSegue" sender:self];
    }
}
@end
