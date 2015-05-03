//
//  BecomeTutorViewController.m
//  Studor
//
//  Created by Marton Pono on 5/3/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "BecomeTutorViewController.h"
#import "Helpers.h"
#import "SWRevealViewController.h"

@interface BecomeTutorViewController ()

@end

@implementation BecomeTutorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

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


//making the keyboard disapear when clicking an empty space
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (IBAction)buttonPressed:(id)sender {
    PFObject *profile = [Helpers getProfile];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *myNumber = [f numberFromString:self.rateField.text];
    
    
    
    profile[@"hourlyRate"] = myNumber;
    profile[@"isTutor"] = @YES;
    profile[@"bio"] = self.bioField.text;
    [profile save];
    
    
}
@end
