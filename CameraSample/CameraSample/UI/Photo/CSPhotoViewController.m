//
//  CSPhotoViewController.m
//  CameraSample
//
//  Created by Malik Alayli on 16/07/15.
//  Copyright (c) 2015 Malik Alayli. All rights reserved.
//

#import "CSPhotoViewController.h"

#import "CSImagePickerService.h"

@interface CSPhotoViewController ()

@property (weak, nonatomic) IBOutlet UIButton *toggleFlashButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *upViewHeightContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downViewHeightContraint;

@end

@implementation CSPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Calculate height for up and down black views
    
    UIWindow *theWindow = [[UIApplication sharedApplication] keyWindow];
    CGFloat theConstant = (theWindow.frame.size.height - theWindow.frame.size.width) / 2;
    self.upViewHeightContraint.constant = theConstant;
    self.downViewHeightContraint.constant = theConstant;
}

#pragma mark - UIViewController Method

- (void)setToggleTitle:(NSString *)aTitle {
    [self.toggleFlashButton setTitle:aTitle forState:UIControlStateNormal];
}

#pragma mark - IBAction Method

- (IBAction)capturePhoto:(UIButton *)sender {
    [[CSImagePickerService sharedInstance] capturePhoto];
}

- (IBAction)flipCameraView:(id)sender {
    [[CSImagePickerService sharedInstance] flipCamera];
}

- (IBAction)toggleFlash:(id)sender {
    [[CSImagePickerService sharedInstance] toggleFlash];
}

@end
