//
//  TutorRequestDetailViewController.m
//  Studor
//
//  Created by Marton Pono on 5/4/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "TutorRequestDetailViewController.h"
#import "SessionViewController.h"

@interface TutorRequestDetailViewController ()

@end

@implementation TutorRequestDetailViewController

NSNumber *wage;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFQuery *profileQuery = [PFQuery queryWithClassName:@"Profile"];
    [profileQuery whereKey:@"username" equalTo:self.request[@"studentId"]];
    
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
    
    _descriptionLabel.text = self.request[@"requestDesc"];
    
    if([self.type isEqualToString:@"pending"]){
        [self.cancelButton setTitle:@"Cancel Request" forState:UIControlStateNormal];
        self.startButton.hidden = YES;
        }
    
    else if([self.type isEqualToString:@"current"]){
        [self.cancelButton setTitle:@"Cancel Session" forState:UIControlStateNormal];
        self.acceptButton.hidden = YES;
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"startSessionSegue"])
    {
        NSLog(@"Performing start session segue");
        
        SessionViewController *destViewController = segue.destinationViewController;
        
        
        destViewController.session = self.request;
        destViewController.wage = wage;
    }

}



- (IBAction)startButtonPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"startSessionSegue" sender:self];
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


- (IBAction)acceptButtonPressed:(id)sender {
    
    PFObject *session = [PFObject objectWithClassName:@"Session"];
    session[@"isCanceled"] = @NO;
    session[@"isCompleted"] = @NO;
    session[@"studentId"] = self.request[@"studentId"];
    session[@"tutorId"] = self.request[@"tutorId"];
    session[@"rate"] = self.request[@"rate"];
    [session saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self.request delete];
            [self performSegueWithIdentifier:@"acceptedRequestSegue" sender:self];
        }
    }];
}

- (IBAction)cancelButtonPressed:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Are you sure?" message:@"Please confirm you want to cancel this request." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
       // don't delete yet because you still need the rate information

      //  [self.request delete];
        // change this to a 'canceledSegue' later but for now they do the same thing
        [self performSegueWithIdentifier:@"acceptedRequestSegue" sender:self];
    }
}

@end
