//
//  SelectSubjectsController.m
//  Studor
//
//  Created by Marton Pono on 5/2/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "SelectSubjectsController.h"
#import <Parse/Parse.h>

@interface SelectSubjectsController ()

@property (retain, nonatomic) NSMutableArray *subjects;


@end



@implementation SelectSubjectsController


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    self.subjects = [[NSMutableArray alloc] init];

    
    PFQuery *query = [PFQuery queryWithClassName:@"Subject"];
    NSArray *objects = [query findObjects];
    
    for (int x = 0; x < [objects count]; x++) {
        NSLog(objects[x][@"subject"]);
        [self.subjects addObject:[NSString stringWithString:objects[x][@"subject"] ]];
    }
    
    for (int x = 0; x < [self.subjects count]; x++) {
        NSLog(self.subjects[x]);
    }
    

    UITableView *tableView = (id)[self.view viewWithTag:1];
    UIEdgeInsets contentInset = tableView.contentInset;
    contentInset.top = 20;
    [tableView setContentInset:contentInset];
}

/*- (void)viewDidLoad {
    
    [super viewDidLoad];

    
    PFUser *currentUser = [PFUser currentUser];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Subject"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            _subjects = [objects copy];
            NSLog([NSString stringWithFormat:@"objects %lu", [objects count]]);

            NSLog([NSString stringWithFormat:@"subjects %lu", [_subjects count]]);

            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    
    UITableView *tableView = (id)[self.view viewWithTag:1];
    UIEdgeInsets contentInset = tableView.contentInset;
    contentInset.top = 20;
    [tableView setContentInset:contentInset];

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSLog([NSString stringWithFormat:@"subjects %lu", [_subjects count]]);

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
    cell.textLabel.text = self.subjects[indexPath.row];
    return cell;
}

@end
