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

@implementation PendingTableViewController


NSArray *requests;
PFObject *selectedRequest;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

    [self getRequests];
    
    NSLog(self.senderInfo[1]);
    
    
    
    
}

- (void) getRequests {
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Request"];

    if([self.senderInfo[0] isEqualToString:@"student"]){
        [query whereKey:@"studentId" equalTo: [PFUser currentUser].username];
    
     }
    if([self.senderInfo[0] isEqualToString:@"tutor"]){
        [query whereKey:@"tutorId" equalTo: [PFUser currentUser].username];
        
    }
    
    requests = [query findObjects];
    
    [self.tableView reloadData];
    
    
    
}





- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSLog([NSString stringWithFormat:@"%lu ", [requests count]]);
    
    
    return [requests count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    PFObject *thisRequest = requests[indexPath.row];
    
    PFQuery *profileQuery = [PFQuery queryWithClassName:@"Profile"];
    
    if([self.senderInfo[0] isEqualToString:@"student"]){
        [profileQuery whereKey:@"username" equalTo: requests[indexPath.row][@"tutorId"]];
         }
         else {
             [profileQuery whereKey:@"username" equalTo: requests[indexPath.row][@"studentId"]];
              }

    
    PFObject *object = [profileQuery getFirstObject];
    
    static NSString *simpleTableIdentifier = @"TutorCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        // NSLog(@"make a new cell");
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    // Configure the cell
    PFFile *thumbnail = [object objectForKey:@"image"];
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    thumbnailImageView.image = [UIImage imageNamed:@"default-pic.jpg"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    
    UILabel *emailLabel = (UILabel*) [cell viewWithTag:108];
    UILabel *name = (UILabel*) [cell viewWithTag:106];
    UILabel *subjectsLabel = (UILabel*)[cell viewWithTag:110];
    UILabel *hourlyRateLabel = (UILabel*) [cell viewWithTag:112];
    
    name.text = [NSString stringWithFormat:@"%@ %@", [object objectForKey:@"firstName"],[object objectForKey:@"lastName"]];
    emailLabel.text = [object objectForKey:@"username"];
    subjectsLabel.text = [object objectForKey:@"subjectsLabel"];
    hourlyRateLabel.text = [NSString stringWithFormat:@"$%@ /hr", [[object objectForKey:@"hourlyRate"] stringValue]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([[segue identifier] isEqualToString:@"studentPendingDetail"])
    {
        StudentRequestDetailViewController *destViewController = segue.destinationViewController;
        destViewController.type = @"pending";
        destViewController.request = selectedRequest;
        
        
    }
    
    if ([[segue identifier] isEqualToString:@"studentCurrentDetail"])
    {
        StudentRequestDetailViewController *destViewController = segue.destinationViewController;
        destViewController.type = @"current";
        destViewController.request = selectedRequest;

        
        
    }
    if ([[segue identifier] isEqualToString:@"studentPastDetail"])
    {
        StudentRequestDetailViewController *destViewController = segue.destinationViewController;
        destViewController.type = @"past";
        destViewController.request = selectedRequest;

        
    }
    
    if ([[segue identifier] isEqualToString:@"tutorPendingDetail"])
    {
        StudentRequestDetailViewController *destViewController = segue.destinationViewController;
        destViewController.type = @"pending";
        destViewController.request = selectedRequest;
        
        
    }
    
    if ([[segue identifier] isEqualToString:@"tutorCurrentDetail"])
    {
        StudentRequestDetailViewController *destViewController = segue.destinationViewController;
        destViewController.type = @"current";
        destViewController.request = selectedRequest;
        
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    selectedRequest = requests[indexPath.row];
    
    if([self.senderInfo[0] isEqualToString:@"student"] && [self.senderInfo[1] isEqualToString:@"pending"]){
        [self performSegueWithIdentifier:@"studentPendingDetail" sender:self];
    }
    if([self.senderInfo[0] isEqualToString:@"student"] && [self.senderInfo[1] isEqualToString:@"current"]){
        [self performSegueWithIdentifier:@"studentCurrentDetail" sender:self];
    }
    if([self.senderInfo[0] isEqualToString:@"student"] && [self.senderInfo[1] isEqualToString:@"past"]){
        [self performSegueWithIdentifier:@"studentPastDetail" sender:self];
    }
    if([self.senderInfo[0] isEqualToString:@"tutor"] && [self.senderInfo[1] isEqualToString:@"pending"]){
        [self performSegueWithIdentifier:@"tutorPendingDetail" sender:self];
    }
    if([self.senderInfo[0] isEqualToString:@"tutor"] && [self.senderInfo[1] isEqualToString:@"current"]){
        [self performSegueWithIdentifier:@"tutorCurrentDetail" sender:self];
    }

    
    
}



@end
