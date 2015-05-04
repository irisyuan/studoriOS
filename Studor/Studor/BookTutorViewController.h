//
//  BookTutorViewController.h
//  Studor
//
//  Created by Marton Pono on 5/4/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface BookTutorViewController : UIViewController

@property (nonatomic, strong) PFObject *tutorProfile;

@end