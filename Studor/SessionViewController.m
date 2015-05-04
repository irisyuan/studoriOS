//
//  SessionViewController.m
//  Studor
//
//  Created by Iris Yuan on 5/3/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "SessionViewController.h"
#import "Parse/Parse.h"
#import "Helpers.h"

@interface SessionViewController () {

bool running;
NSTimeInterval startTime;
    
}
@end

@implementation SessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _timeLabel.text = @"0:00.0";
    running = false;
}

-(IBAction)startSession:(id)sender {
    if (running == false) {
    startTime = [NSDate timeIntervalSinceReferenceDate];
    [sender setTitle:@"STOP" forState:UIControlStateNormal];
    [self updateTime];
    } else {
        [sender setTitle:@"STOP" forState:UIControlStateNormal];
        running = false;
    }
}

-(void) updateTime {
    if (running == false) return;
    
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = currentTime - startTime;
    
    int mins = (int) (elapsed / 60.0);
    elapsed -= mins*60;
    int secs = (int) (elapsed);
    elapsed -= secs;
    int fraction = elapsed * 10.0;
    
    _timeLabel.text = [NSString stringWithFormat:@"%u:%02u.%u", mins, secs, fraction];
    
    [self performSelector:@selector(updateTime) withObject:self afterDelay:0.1];
}

-(IBAction)confirmSessionEnded:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Confirm" message:@"Please confirm session has ended!" delegate:nil cancelButtonTitle:@"Yes" otherButtonTitles:nil, nil];
    [alert show];
    
    
    // call save session at end
}

-(void)saveSession {
    
    
}



-(void)viewWillAppear:(BOOL)animated {
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
