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



@implementation SessionViewController {

// Keeps track of if the timer is started.
bool start;

// Gets the exact time when the button is pressed.
NSTimeInterval time;

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Sets the text of our Label to a default time of 0.
    self.display.text = @"0:00";
    
    // We set start to false because we don't want the time to be on until we press the button.
    start = false;
    
}

-(void)update {
    
    
    // If start is false then we shouldn't be updateing the time se we return out of the method.
    if (start == false) {
        
        return;
        
    }
    
    // We get the current time and then use that to calculate the elapsed time.
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsedTime = currentTime - time;
    
    // We calculate the minutes.
    int minutes = (int)(elapsedTime / 60.0);
    
    // We calculate the seconds.
    int seconds = (int)(elapsedTime = elapsedTime - (minutes * 60));
    
    // We update our Label with the current time.
    self.display.text = [NSString stringWithFormat:@"%u:%02u", minutes, seconds];
    
    // We recursively call update to get the new time.
    [self performSelector:@selector(update) withObject:self afterDelay:0.1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    
    // If start is false then we need to start update the Label with the new time.
    if (start == false) {
        
        // Since it is false we need to reset it back to true.
        start = true;
        
        // Gets the current time.
        time = [NSDate timeIntervalSinceReferenceDate];
        
        // Changes the title of the button to Stop!
        [sender setTitle:@"Stop!" forState:UIControlStateNormal];
        
        // Calls the update method.
        [self update];
        
    }else {
        
        // Since it is false we need to reset it back to false.
        start = false;
        
        // Changes the title of the button back to Start.
        [sender setTitle:@"Start" forState:UIControlStateNormal];
        
    }
    
}


@end
/*
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
*/