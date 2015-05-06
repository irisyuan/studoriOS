//
//  MapViewController.m
//  Studor
//
//  Created by Marton Pono on 5/6/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "MapViewController.h"


@interface MapViewController ()

@end

@implementation MapViewController

GMSMarker *marker;
GMSMapView *mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                                            longitude:151.2086
                                                                 zoom:16];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    marker = [[GMSMarker alloc] init];
    marker.position = camera.target;
    marker.snippet = @"Hello World";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView;
    mapView.delegate = self;

    
   // [mapView clear];
    
    self.view = mapView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - GMSMapViewDelegate

- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate {
    if(self.editable) { CLLocationCoordinate2D tappedlocation = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
  
    marker.position =  tappedlocation;
        self.parentVC.latitude = [NSNumber numberWithDouble:coordinate.latitude];
        self.parentVC.latitude = [NSNumber numberWithDouble:coordinate.latitude];
    


        NSLog(@"You tapped at %f,%f", coordinate.latitude, coordinate.longitude);}
}


@end
