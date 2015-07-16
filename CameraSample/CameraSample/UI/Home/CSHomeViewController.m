//
//  CSHomeViewController.m
//  CameraSample
//
//  Created by Malik Alayli on 16/07/15.
//  Copyright (c) 2015 Malik Alayli. All rights reserved.
//

#import "CSHomeViewController.h"

#import "CSImagePickerService.h"

@implementation CSHomeViewController

#pragma mark - IBAction Method

- (IBAction)openCamera:(UIButton *)sender {
    [[CSImagePickerService sharedInstance] openCamera];
}

@end
