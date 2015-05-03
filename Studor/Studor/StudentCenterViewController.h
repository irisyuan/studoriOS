//
//  StudentCenterViewController.h
//  Studor
//
//  Created by Iris Yuan on 5/2/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentCenterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *PendingRequestsLabel;
@property (weak, nonatomic) IBOutlet UILabel *CurrentSessionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *PastSessionsLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;


@end