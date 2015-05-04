//
//  PendingTableViewController.m
//  Studor
//
//  Created by Iris Yuan on 5/2/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "PendingTableViewController.h"
#import "Helpers.h"

@implementation PendingTableViewController


NSArray *requests;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

    [self getRequests];
    
    
    
    
    
    
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
    
    UILabel *emailLabel = (UILabel*) [cell viewWithTag:101];
    UILabel *name = (UILabel*) [cell viewWithTag:102];
    UILabel *subjectsLabel = (UILabel*)[cell viewWithTag:104];
    UILabel *hourlyRateLabel = (UILabel*) [cell viewWithTag:105];
    
    name.text = [NSString stringWithFormat:@"%@ %@", [object objectForKey:@"firstName"],[object objectForKey:@"lastName"]];
    emailLabel.text = [object objectForKey:@"username"];
    subjectsLabel.text = [object objectForKey:@"subjectsLabel"];
    hourlyRateLabel.text = [NSString stringWithFormat:@"$%@/hr", [[object objectForKey:@"hourlyRate"] stringValue]];
    
    return cell;
    
}



@end
