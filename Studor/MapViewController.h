//
//  MapViewController.h
//  Studor
//
//  Created by Marton Pono on 5/6/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "MapViewContainerViewController.h"



@interface MapViewController : UIViewController <GMSMapViewDelegate>


@property (nonatomic, assign) BOOL editable;
@property (strong, nonatomic) MapViewContainerViewController *parentVC;

@property (strong, nonatomic) CLLocation *currentLocation;



@end
