//
//  TutorRequestDetailViewController.m
//  Studor
//
//  Created by Marton Pono on 5/4/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "TutorRequestDetailViewController.h"

@interface TutorRequestDetailViewController ()

@end

@implementation TutorRequestDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFQuery *profileQuery = [PFQuery queryWithClassName:@"Profile"];
    [profileQuery whereKey:@"username" equalTo:self.request[@"studentId"]];
    
    PFObject *profile = [profileQuery getFirstObject];
    
    _nameLabel.text = [NSString stringWithFormat:@"%@ %@", profile[@"firstName"], profile[@"lastName"]];
    _rateLabel.text = profile[@"rate"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)startButtonPressed:(id)sender {
    
    
    
    
}
@end
