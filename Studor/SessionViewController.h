//
//  SessionViewController.h
//  Studor
//
//  Created by Iris Yuan on 5/3/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Helpers.h"

@interface SessionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (retain, strong) NSNumber *wage;


- (IBAction)endSessionButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *stopButton;

- (IBAction)startButtonPressed:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (IBAction)cancelButtonPressed:(id)sender;

- (IBAction)stopButtonPressed:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *endButton;


@end
