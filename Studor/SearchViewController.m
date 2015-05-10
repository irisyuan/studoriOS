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

@property (strong, nonatomic) NSArray *subjects;
@property (strong, nonatomic) NSArray *searchResults;
@property (strong, nonatomic) NSMutableArray *subjectString;
@property PFObject *selectedSubject;

@end


@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.searchResults = [[NSArray alloc] init];
    self.subjects = [[NSMutableArray alloc] init];
    
    PFQuery *subjectQuery = [PFQuery queryWithClassName:@"Subject"];
    [subjectQuery orderByAscending:@"subject"];
    self.subjects = [subjectQuery findObjects];
    self.subjectString = [[NSMutableArray alloc] init];
    for(int x = 0; x < [self.subjects count]; x++){
        [self.subjectString addObject:_subjects[x][@"subject"]];
        
    }
    
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
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_searchResults count];
        
    } else {
        
        return [self.subjects count];
    }
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
        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
        
    }
    cell.textLabel.text = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = self.searchResults[indexPath.row];
    }
    else {
        cell.textLabel.text = self.subjects[indexPath.row][@"subject"];
    }
    
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
    if(self.searchDisplayController.active){
    NSString *subjectName = _searchResults[indexPath.row];
    PFQuery *subjectQuery = [PFQuery queryWithClassName:@"Subject"];
    [subjectQuery whereKey:@"subject" equalTo:subjectName];
        
        self.selectedSubject = [subjectQuery getFirstObject];
    } else {
        self.selectedSubject = self.subjects[indexPath.row];
    }
    
    [self performSegueWithIdentifier:@"searchResultsSegue" sender:self];
}


//size of each cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
//filtering subjects
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"self contains[c] %@", searchText];
    _searchResults = [_subjectString filteredArrayUsingPredicate:resultPredicate];
    

}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSLog(searchString);
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}



@end