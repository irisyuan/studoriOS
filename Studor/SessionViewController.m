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

// So user can press start button to continue without resetting time.
bool paused;
    
NSTimeInterval finalTime;
NSNumber *price;

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Entering viewDidLoad in session view controller");
    
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

        if (paused != YES) {
        // Gets the current time.
        time = [NSDate timeIntervalSinceReferenceDate];
        } else {
            NSTimeInterval elapsed = finalTime;

            int mins = (int) (elapsed / 60.0)-1;
            elapsed -= mins*60;
            int secs = (int) (elapsed);
            elapsed -= secs;
            int fraction = elapsed * 10.0;
            
            _timeLabel.text = [NSString stringWithFormat:@"%u:%02u.%u", mins, secs, fraction];
        }
        
        [self update];

    }
    
}
- (IBAction)cancelButtonPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"cancelSegue" sender:nil];
    
}

- (IBAction)stopButtonPressed:(id)sender {
    
    start = false;
    self.endButton.enabled=YES;
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    finalTime = currentTime - time;

    paused = YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"endSessionSegue"])
    {
        NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
        NSTimeInterval elapsedTime = currentTime - time;
        ShowPriceViewController *destViewController = segue.destinationViewController;
        
        destViewController.price = price;
        
        NSLog(@"Price sent to show price page -- %@", destViewController.price);
        
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
    
    
    //calculate price of session
    double wage = [self.wage doubleValue];
    price = [NSNumber numberWithDouble:((finalTime/3600.0) * wage)];
    
    self.session[@"price"] = price;
    
    //create string to store length
    double elapsed = finalTime;
    int mins = (int) (elapsed / 60.0);
    elapsed -= mins*60;
    int secs = (int) (elapsed);
    elapsed -= secs;
    int fraction = elapsed * 10.0;
    self.session[@"length"] = [NSString stringWithFormat:@"%u:%02u.%u", mins, secs, fraction];
    
    self.session[@"isCompleted"] = @YES;
    [self.session save];
    
    if(!start){
        [self performSegueWithIdentifier:@"endSessionSegue" sender:nil];}
    
}

- (IBAction)backButtonPressed:(id)sender {
    
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