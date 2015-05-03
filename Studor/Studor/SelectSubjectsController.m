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

    PFUser *currentUser = [PFUser currentUser];

    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Subject"];
    self.subjects = [query findObjects];
    
    NSLog([NSString stringWithFormat:@"%lu ",[self.subjects count]]);


    [currentUser addUniqueObject:[self.subjects[0] objectId] forKey: @"subject"];
    [currentUser save];
    
    

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
- (BOOL) userTeachesSubject: (NSInteger)row{
    
    
    PFUser *currentUser = [PFUser currentUser];
    NSMutableArray *userSubjects = currentUser[@"subjects"];
    
    NSLog([NSString stringWithFormat:@"%lu count",[userSubjects count]]);
    
    NSLog([self.subjects[row] objectId]);
    
    NSLog(userSubjects[0]);

    
    if([userSubjects containsObject:[self.subjects[row] objectId]]){
        NSLog([self.subjects[row] objectId]);
        NSLog(userSubjects[0]);
        return true;
    }
    
    return false;

    
    
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
    if([self userTeachesSubject : indexPath.row]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;}
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    

    
}

@end
