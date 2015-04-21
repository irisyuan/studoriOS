//
//  Helpers.h
//  Studor
//
//  Created by Marton Pono on 4/15/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helpers : NSObject

+ (BOOL) NSStringIsValidEmail:(NSString *)checkString;
+ (BOOL) NSStringIsValidZipCode:(NSString *)checkString;



@end
