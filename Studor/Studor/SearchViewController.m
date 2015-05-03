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
#import "SearchResultsViewController.h"

@interface SearchViewController ()

@property (retain, nonatomic) NSArray *subjects;
@property NSString *selectedSubject;

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"searchResultsSegue"])
    {
        SearchResultsViewController *destViewController = segue.destinationViewController;
        destViewController.subject = self.selectedSubject;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.selectedSubject = self.subjects[indexPath.row];
    [self performSegueWithIdentifier:@"searchResultsSegue" sender:self];

    
    
}

@end