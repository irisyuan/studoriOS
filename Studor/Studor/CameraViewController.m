//
//  ProfileViewController.m
//  Studor
//
//  Created by Iris Yuan on 4/14/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CameraViewController.h"

#import <Parse/Parse.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "SWRevealViewController.h"
#import "Helpers.h"


@interface CameraViewController ()
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIImageView *chosenImageView;
@property (nonatomic, assign) BOOL imagePickerIsDisplayed;
@end

@implementation CameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
}

/* Move this to profile to save with bio information at the same time? */
- (void)save {
    if (self.chosenImageView.image) {
        NSData *imageData = UIImagePNGRepresentation(self.chosenImageView.image);
        PFFile *photoFile = [PFFile fileWithData:imageData];
        
        PFObject *profile = [Helpers getProfile];
        profile[@"image"] = photoFile;
        if (![profile save]) {
            NSLog(@"Image could not be saved");
        }
    } else {
       [self showError];
    }
    [self clear];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self.imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
    
    
    if (!self.imagePickerIsDisplayed) {
        [self presentViewController:self.imagePicker animated:NO completion:nil];
        self.imagePickerIsDisplayed = YES;
    }
    


    [self performSegueWithIdentifier:@"backToProfile" sender:nil];


}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self clear];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    
    
    self.chosenImageView.image = chosenImage;
    
    NSLog(@"this is the chosen image! %@", self.chosenImageView.image);
    //[self save];
    
    NSData *imageData = UIImagePNGRepresentation(chosenImage);
    PFFile *photoFile = [PFFile fileWithData:imageData];
    
    PFObject *profile = [Helpers getProfile];
    profile[@"image"] = photoFile;
    if (![profile save]) {
        NSLog(@"Image could not be saved");
    } else {
        NSLog(@"fuck yeah");
    }

    

    [self dismissViewControllerAnimated:YES completion:^{self.imagePickerIsDisplayed = NO;}];


}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:NO completion:nil];
    self.imagePickerIsDisplayed = NO;
}

- (void)clear {
    self.chosenImageView.image = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showError {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Photo could not be uploaded" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.titleTextField resignFirstResponder];
}

@end
