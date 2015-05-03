//
//  Helpers.m
//  Studor
//
//  Created by Marton Pono on 4/15/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "Helpers.h"
#import <Parse/Parse.h>
@implementation Helpers


+ (BOOL) NSStringIsValidEmail:(NSString *)checkString

{
    NSString *emailString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailString];
    return [emailTest evaluateWithObject:checkString];
}

+ (BOOL) NSStringIsValidZipCode:(NSString *)checkString

{
    NSString *zipRegex = @"^[0-9]{5}(-/d{4})?$";
    NSPredicate *zipTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zipRegex];
    NSString *error;
    if([zipTest evaluateWithObject:checkString]){
        
     error = @"true"; }
    else { error = @"false";
    }
    NSLog(error);
    return [zipTest evaluateWithObject:checkString];
}

+ (PFObject*) getProfile {
    
    PFQuery *profileQuery = [PFQuery queryWithClassName:@"Profile"];
    NSString *currentUser = PFUser.currentUser.username;
    [profileQuery whereKey:@"username" equalTo:currentUser];
    return [profileQuery getFirstObject];
}

@end
