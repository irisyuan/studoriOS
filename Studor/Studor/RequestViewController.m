//
//  RequestViewController.m
//  Studor
//
//  Created by Iris Yuan on 4/14/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestViewController.h"
#import "Helpers.h"

@implementation RequestViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _requestErrorLabel.text = @"";
    _subjectErrorLabel.text = @"";
    _zipCodeErrorLabel.text = @"";
    _generalErrorLabel.text = @"";
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)requestButtonPressed:(id)sender {
    
    _requestErrorLabel.text = @"";
    _subjectErrorLabel.text = @"";
    _zipCodeErrorLabel.text = @"";
    _generalErrorLabel.text = @"";

    
    NSMutableDictionary *errors = [[NSMutableDictionary alloc] init];
    if([_requestBox.text length] < 15){
        
        [errors setObject:@"The request box needs to contain at least 15 characters. " forKey:@"requestBox" ];
    }
    if([_subjectBox.text length] < 3){
        
        [errors setObject:@"The request box needs to contain at least 3 characters. " forKey:@"subjectBox" ];
    }
    if(![Helpers NSStringIsValidZipCode:_zipCodeBox.text]){
        
        [errors setObject:@"Please provide a valid zip code. " forKey:@"zipCodeBox" ];
    }
    
    if([errors count] > 0){
        
        if([errors objectForKey:@"requestBox"]){
            _requestErrorLabel.text = [errors objectForKey:@"requestBox"];
            NSLog(@"Request box contains error");
        }
        if([errors objectForKey:@"subjectBox"]){
            _subjectErrorLabel.text = [errors objectForKey:@"subjectBox"];
            NSLog(@"Subject box contains error");

        }
        if([errors objectForKey:@"zipCodeBox"]){
            _zipCodeErrorLabel.text = [errors objectForKey:@"zipCodeBox"];
            NSLog(@"Zip code box contains error");

        }
        
    }else{
        
        PFObject *request = [PFObject objectWithClassName:@"request"];
        request[@"body"] = _requestBox.text;
        request[@"subject"] = _subjectBox.text;
        request[@"zipCode"] = _zipCodeBox.text;
        
        PFUser *currentUser = [PFUser currentUser];
        request[@"user"] = currentUser.username;
        
        [request saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self performSegueWithIdentifier:@"requestSuccess" sender:nil];

            } else {
                
                _generalErrorLabel.text = [error userInfo][@"error"];
                
                
            }
        }];
    
    }
    
}

@end