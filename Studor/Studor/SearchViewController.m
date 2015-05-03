//
//  SearchViewController.m
//  Studor
//
//  Created by Iris Yuan on 4/14/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchViewController.h"
#import "SWRevealViewController.h"

@interface SearchViewController ()

@property (retain, nonatomic) NSArray *subjects;

@end


@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.subjects = [[NSMutableArray alloc] init];
    
    PFQuery *subjectQuery = [PFQuery queryWithClassName:@"Subject"];
    self.subjects = [subjectQuery findObjects];

    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
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
    
    return cell;
}

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFQuery *profileQuery = [PFQuery queryWithClassName:@"Profile"];
    NSString *currentUser = PFUser.currentUser.username;
    [profileQuery whereKey:@"username" equalTo:currentUser];
    PFObject *profile = [profileQuery getFirstObject];
    
    
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
    
    
    
    
}*/

@end