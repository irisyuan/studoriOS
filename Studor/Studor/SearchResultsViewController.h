//
//  SearchResultsViewController.h
//  Studor
//
//  Created by Marton Pono on 5/3/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SearchResultsViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) PFObject *subject;


@end
