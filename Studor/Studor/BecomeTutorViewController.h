//
//  BecomeTutorViewController.h
//  Studor
//
//  Created by Marton Pono on 5/3/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BecomeTutorViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *rateField;
@property (weak, nonatomic) IBOutlet UITextView *bioField;
- (IBAction)buttonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;


@end
