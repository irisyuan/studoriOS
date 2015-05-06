//
//  SelectSubjectsController.m
//  Studor
//
//  Created by Marton Pono on 5/2/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "SelectSubjectsController.h"
#import <Parse/Parse.h>
#import "Helpers.h"


@interface SelectSubjectsController ()

@property (retain, nonatomic) NSArray *subjects;


@end



@implementation SelectSubjectsController

PFObject *profile;

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    profile = [Helpers getProfile];
    self.subjects = [[NSMutableArray alloc] init];

    PFQuery *profileQuery = [PFQuery queryWithClassName:@"Profile"];
    NSString *currentUser = PFUser.currentUser.username;
    [profileQuery whereKey:@"username" equalTo:currentUser];
    PFObject *profile = [profileQuery getFirstObject];
    NSLog([profile objectId]);
    
    
    PFQuery *subjectQuery = [PFQuery queryWithClassName:@"Subject"];
    self.subjects = [subjectQuery findObjects];
        

    UITableView *tableView = (id)[self.view viewWithTag:1];
    UIEdgeInsets contentInset = tableView.contentInset;
    contentInset.top = 20;
    [tableView setContentInset:contentInset];
}


- (BOOL) userTeachesSubject: (NSInteger)row{
    
    
    NSArray *userSubjects = profile[@"subjects"];
    
    if([userSubjects containsObject:[self.subjects[row] objectId]]){
        return true;
    }
    
    return false;

    
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{

    return [self.subjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
    }
    
    cell.textLabel.text = self.subjects[indexPath.row][@"subject"];
    
   if([self userTeachesSubject:indexPath.row]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([self userTeachesSubject:indexPath.row]){
        [profile removeObject:[self.subjects[indexPath.row] objectId] forKey:@"subjects"];
        [profile save];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    else{
        NSLog([self.subjects[indexPath.row] objectId]);
        [profile addUniqueObject:[self.subjects[indexPath.row] objectId] forKey: @"subjects"];
        [profile save];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }
    
}






@end
