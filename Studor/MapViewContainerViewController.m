//
//  MapViewContainerViewController.m
//  Studor
//
//  Created by Marton Pono on 5/6/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "MapViewContainerViewController.h"
#import "MapViewController.h"

@interface MapViewContainerViewController ()

@end

@implementation MapViewContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{   NSLog(@"Peforming Editable Segue");
    
    if ([[segue identifier] isEqualToString:@"editableSegue"])
    {   NSLog(@"Peforming Editable Segue");
        
        MapViewController *destViewController = segue.destinationViewController;
        destViewController.parentVC = self;
        destViewController.editable = true;
        destViewController.currentLocation = self.currentLocation;
        
    }
    
}


- (IBAction)backButtonPressed:(id)sender {
    self.parentVC.longtitude = self.longtitude;
    self.parentVC.latitude = self.latitude;
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
@end
