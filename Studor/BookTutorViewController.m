//
//  BookTutorViewController.m
//  Studor
//
//  Created by Marton Pono on 5/4/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import "BookTutorViewController.h"
#import "Helpers.h"

@interface BookTutorViewController ()

@end

@implementation BookTutorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog([self.tutorProfile objectId]);
    
    // Do any additional setup after loading the view.
    
    NSString *firstName = self.tutorProfile[@"firstName"];
    NSString *lastName =  self.tutorProfile[@"lastName"];
    
    PFFile *imageFile = self.tutorProfile[@"image"];
    if (imageFile) {
        _image.file = imageFile;
        [_image loadInBackground];
    } else {
        _image.image = [UIImage imageNamed:@"default-pic.png"];
    }
    
    _nameLabel.text = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    _hourlyRateLabel.text = [NSString stringWithFormat:@"$%@ per hour", [self.tutorProfile[@"hourlyRate"] stringValue]];
    _bioLabel.text = self.tutorProfile[@"bio"];
    
    _subjectsLabel.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bookTutor:(id)sender {
    
    PFObject *request = [PFObject objectWithClassName:@"Request"];
    request[@"tutorId"] = self.tutorProfile[@"username"];
    request[@"studentId"] = [Helpers getProfile][@"email"];
    request[@"requestDesc"] = _requestDescField.text;
    request[@"rate"] = self.tutorProfile[@"hourlyRate"];
    
    //request[@"subjectId"] = _subjectsLabel.text;
    
    [request saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // segue to Student Center
            [self performSegueWithIdentifier:@"bookToStudentCenter" sender:nil];
        } else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Error booking session. Please try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//making the keyboard disapear when clicking an empty space
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
