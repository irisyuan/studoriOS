//
//  SessionViewController.m
//  Studor
//
//  Created by Iris Yuan on 5/3/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "SessionViewController.h"
#import "ShowPriceViewController.h"

@interface SessionViewController ()

@property (weak, nonatomic) IBOutlet UILabel *display;

- (IBAction)buttonPressed:(id)sender;

@end



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
    self.timeLabel.text = @"0:00";
    self.endButton.enabled=NO;
    
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
    self.timeLabel.text = [NSString stringWithFormat:@"%u:%02u", minutes, seconds];
    
    // We recursively call update to get the new time.
    [self performSelector:@selector(update) withObject:self afterDelay:0.1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)startButtonPressed:(id)sender {
    if (start == false) {
        
        // Since it is false we need to reset it back to true.
        start = true;
        self.endButton.enabled=NO;

        // Gets the current time.
        time = [NSDate timeIntervalSinceReferenceDate];
        
        [self update];

    
    }
    
}
- (IBAction)cancelButtonPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"cancelSegue" sender:nil];
    
}

- (IBAction)stopButtonPressed:(id)sender {
    
    start = false;
    self.endButton.enabled=YES;

    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pickTutorSegue"])
    {
        NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
        NSTimeInterval elapsedTime = currentTime - time;
        ShowPriceViewController *destViewController = segue.destinationViewController;
        double wage = [self.wage doubleValue];

        destViewController.price = [NSNumber numberWithDouble:((elapsedTime/360) * wage)];
        
    }
}

-(void) updateTime {
    if (!start) return;
    
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = currentTime - time;
    
    int mins = (int) (elapsed / 60.0);
    elapsed -= mins*60;
    int secs = (int) (elapsed);
    elapsed -= secs;
    int fraction = elapsed * 10.0;
    
    _timeLabel.text = [NSString stringWithFormat:@"%u:%02u.%u", mins, secs, fraction];
    
    [self performSelector:@selector(updateTime) withObject:self afterDelay:0.1];
}
- (IBAction)endSessionButtonPressed:(id)sender {

    if(!start){
        [self performSegueWithIdentifier:@"endSessionSegue" sender:nil];}
    
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