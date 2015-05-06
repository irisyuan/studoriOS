//
//  PendingTableViewController.m
//  Studor
//
//  Created by Iris Yuan on 5/2/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "PendingTableViewController.h"
#import "Helpers.h"
#import "StudentRequestDetailViewController.h"
#import "TutorRequestDetailViewController.h"

@implementation PendingTableViewController


NSArray *pending;
NSArray *current;
NSArray *past;
NSString *selectedType;
PFObject *selectedRequest;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

    [self getRequests];
    
    NSLog(self.senderInfo[1]);
    
}

- (void) getRequests {
    
    
    PFQuery *requestQuery = [PFQuery queryWithClassName:@"Request"];
    PFQuery *sessionQuery = [PFQuery queryWithClassName:@"Session"];

    if([self.senderInfo[0] isEqualToString:@"student"]){
        [requestQuery whereKey:@"studentId" equalTo: PFUser.currentUser.username];
        pending = [requestQuery findObjects];
        
        [sessionQuery whereKey:@"studentId" equalTo:PFUser.currentUser.username];
        [sessionQuery whereKey:@"isCompleted" equalTo:@NO];
        current = [sessionQuery findObjects];
        [sessionQuery whereKey:@"isCompleted" equalTo:@YES];
        past = [sessionQuery findObjects];
        
        }
    
    if([self.senderInfo[0] isEqualToString:@"tutor"]){
        
        [requestQuery whereKey:@"tutorId" equalTo: PFUser.currentUser.username];
        pending = [requestQuery findObjects];
        
        [sessionQuery whereKey:@"tutorId" equalTo:PFUser.currentUser.username];
        [sessionQuery whereKey:@"isCompleted" equalTo:@NO];
        current = [sessionQuery findObjects];
    
        }
    
    [self.tableView reloadData];
    
}


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{

    if(section == 0){
        return [pending count];
    }
    if(section == 1){

        return [current count];
    }
    else{

        return [past count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    PFObject *thisRequest;
    PFQuery *profileQuery = [PFQuery queryWithClassName:@"Profile"];
    PFQuery *sessionQuery = [PFQuery queryWithClassName:@"Session"];


    
    if(indexPath.section == 0){
        thisRequest = pending[indexPath.row];
    }
    if(indexPath.section == 1){
        thisRequest = current[indexPath.row];
    }
    if(indexPath.section == 2){
        thisRequest = past[indexPath.row];
    }
    
    PFObject *object;
    
    
    if(indexPath.section == 0){
    if([self.senderInfo[0] isEqualToString:@"student"]){
        [profileQuery whereKey:@"username" equalTo: thisRequest[@"tutorId"]];
         }
         else {
             [profileQuery whereKey:@"username" equalTo: thisRequest[@"studentId"]];
              }
        object = [profileQuery getFirstObject];
    }
    else{
        if([self.senderInfo[0] isEqualToString:@"student"]){
            [profileQuery whereKey:@"username" equalTo: thisRequest[@"tutorId"]];
        }
        else {
            [profileQuery whereKey:@"username" equalTo: thisRequest[@"studentId"]];
        }
        object = [profileQuery getFirstObject];
    
    }
    

    
    static NSString *simpleTableIdentifier = @"TutorCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        // NSLog(@"make a new cell");
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    // Configure the cell
    PFFile *thumbnail = [object objectForKey:@"image"];
    
    
    PFImageView *thumbnailImageView ;
    
    UILabel *emailLabel;
    UILabel *name;
    UILabel *subjectsLabel;
    UILabel *hourlyRateLabel;
    
    thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    emailLabel = (UILabel*) [cell viewWithTag:108];
    name = (UILabel*) [cell viewWithTag:106];
    subjectsLabel = (UILabel*)[cell viewWithTag:110];
    hourlyRateLabel = (UILabel*) [cell viewWithTag:112];

    
    thumbnailImageView.image = [UIImage imageNamed:@"default-pic.jpg"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    
    name.text = [NSString stringWithFormat:@"%@ %@", [object objectForKey:@"firstName"],[object objectForKey:@"lastName"]];
    emailLabel.text = [object objectForKey:@"username"];
    subjectsLabel.text = [object objectForKey:@"subjectsLabel"];
    hourlyRateLabel.text = [NSString stringWithFormat:@"$%@ /hr", [[thisRequest objectForKey:@"rate"] stringValue]];
    NSLog(@"FUCKKKKK%@", hourlyRateLabel.text);
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([[segue identifier] isEqualToString:@"studentSegue"])
    {   NSLog(@"Peforming Student Segue");

        StudentRequestDetailViewController *destViewController = segue.destinationViewController;
        destViewController.type = selectedType;
        destViewController.request = selectedRequest;
        
        
    }
    
    if ([[segue identifier] isEqualToString:@"tutorSegue"])
    {
        NSLog(@"Peforming Tutor Segue");
        TutorRequestDetailViewController *destViewController = segue.destinationViewController;
        destViewController.type = selectedType;
        destViewController.request = selectedRequest;

        
        
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    if([self.senderInfo[0] isEqualToString:@"student"]){
        return 3;
    }
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   NSLog(@"Selected a row in the table -- %@ , %@", self.senderInfo[0], self.senderInfo[1]);
    
    if(indexPath.section == 0){
        
        selectedRequest = pending[indexPath.row];
        selectedType = @"pending";
    }
    if(indexPath.section == 1){
        
        selectedRequest = current[indexPath.row];
        selectedType = @"current";

        
    }
    if(indexPath.section == 2){
        
        selectedRequest = past[indexPath.row];
        selectedType = @"past";
        
    }
    
    if([self.senderInfo[0] isEqualToString:@"student"]){
        
        [self performSegueWithIdentifier:@"studentSegue" sender:self];
        
    }else{
        
        [self performSegueWithIdentifier:@"tutorSegue" sender:self];

    }

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0: return @"Pending Requests";
        case 1: return @"Upcoming Sessions";
        case 2: return @"Past Sessions";
            
            
    }
    return @"Pending Sessions";
}



@end
