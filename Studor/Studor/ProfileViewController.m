//
//  ProfileViewController.m
//  Studor
//
//  Created by Iris Yuan on 4/14/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "SWRevealViewController.h"

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    PFQuery *query = [PFQuery queryWithClassName:@"Profile"];
    NSString *currentUser = PFUser.currentUser.username;
    // NSLog(@"%@", currentUser);
    
    [query whereKey:@"username" equalTo:currentUser];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

/* If tutor, display the following information */


/* Move this to profile to save with bio information at the same time?
- (IBAction)save:(id)sender {
    if (self.chosenImageView.image) {
        
        NSData *imageData = UIImagePNGRepresentation(self.chosenImageView.image);
        PFFile *photoFile = [PFFile fileWithData:imageData];
        PFObject *photo = [PFObject objectWithClassName:@"Profile"];
        photo[@"image"] = photoFile;
        photo[@"username"] = [PFUser currentUser].username;
        
        [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!succeeded) {
                [self showError];
            }
        }];
    }
    else {
        [self showError];
    }
    [self clear];
}*/

- (IBAction)logoutButtonPressed:(id)sender {
    
    [PFUser logOut];
    [self performSegueWithIdentifier:@"loggedOut" sender:nil];
}
@end
