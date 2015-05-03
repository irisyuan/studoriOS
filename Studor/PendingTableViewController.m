//
//  PendingTableViewController.m
//  Studor
//
//  Created by Iris Yuan on 5/2/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "PendingTableViewController.h"

@implementation PendingTableViewController

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // The className to query on
        self.parseClassName = @"Request";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"tutorId";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 10;
    } else {
        NSLog(@"nopenope");
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query whereKey:@"studentId" equalTo:PFUser.currentUser.username];
    //[query orderByDescending:@"createdAt"];
        
        // Found UserStats
        NSString *tutor = [[query getFirstObject] objectForKey:@"tutorId"];
        NSLog(@"got it! %@", tutor);
    
        // Get profile for that tutor
        //PFQuery *profileQuery = [PFQuery queryWithClassName:@"Profile"];
        //[profileQuery whereKey:@"username" equalTo:tutor];

        return query;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
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
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:101];
   // UILabel *hourlyRateLabel = (UILabel*) [cell viewWithTag:102];

    nameLabel.text = [object objectForKey:@"tutorId"];
    //hourlyRateLabel.text = [object objectForKey:@"hourlyRate"];

    
    return cell;
}

- (void) objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    
    NSLog(@"error: %@", [error localizedDescription]);
}

@end
