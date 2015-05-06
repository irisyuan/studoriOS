//
//  SelectSubjectsController.h
//  Studor
//
//  Created by Marton Pono on 5/2/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SelectSubjectsController : UIViewController
<UITableViewDataSource, UITableViewDelegate>

- (BOOL) userTeachesSubject: (NSInteger)row;

- (IBAction)backButtonPressed:(id)sender;

@end
