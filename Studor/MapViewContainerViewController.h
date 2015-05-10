//
//  MapViewContainerViewController.h
//  Studor
//
//  Created by Marton Pono on 5/6/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface MapViewContainerViewController : UIViewController

@property (strong, nonatomic) MapViewContainerViewController *parentVC;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longtitude;
@property (strong, nonatomic) CLLocation *currentLocation;

- (IBAction)backButtonPressed:(id)sender;
@end
