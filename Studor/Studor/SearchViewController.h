//
//  SearchViewController.h
//  Studor
//
//  Created by Iris Yuan on 4/14/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface SearchViewController : UIViewController
 <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;


@end