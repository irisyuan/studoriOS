//
//  SessionViewController.h
//  Studor
//
//  Created by Iris Yuan on 5/3/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SessionViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UIButton *sessionEndedButton;
@property (weak, nonatomic) IBOutlet UIButton *sessionStartedButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

-(IBAction)confirmSessionEnded:(id)sender;
-(IBAction)startSession:(id)sender;

@end
