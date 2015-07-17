//
//  CSImagePickerService.m
//  CameraSample
//
//  Created by Malik Alayli on 16/07/15.
//  Copyright (c) 2015 Malik Alayli. All rights reserved.
//

#import "CSImagePickerService.h"

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>

#import "CSPhotoViewController.h"

@interface CSImagePickerService () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) CSPhotoViewController *photoViewController;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;

@end

@implementation CSImagePickerService

#pragma mark - Init Method

- (instancetype)init {
    if (self = [super init]) {
        // Photo View Controller
        
        UIStoryboard *theStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _photoViewController = [theStoryboard instantiateViewControllerWithIdentifier:CSPhotoViewControllerStoryboardID];
        
        // Image Picker Controller
        
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePickerController.showsCameraControls = NO;
        _imagePickerController.navigationBarHidden = NO;
        _imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
        _imagePickerController.cameraOverlayView = _photoViewController.view;
        _imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
        
        // Set Titles
        
        [_photoViewController setToggleFlashTitle:NSLocalizedString(@"flash_off", nil)];
        [_photoViewController setFlipCameraTitle:NSLocalizedString(@"flip_to_front", nil)];

    }
    return self;
}

#pragma mark - Shared Instance Method

+ (instancetype)sharedInstance {
    static CSImagePickerService *sharedMyInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyInstance = [[self alloc] init];
    });
    return sharedMyInstance;
}

#pragma mark - Dealloc Method

- (void)dealloc {
    self.photoViewController = nil;
    self.imagePickerController = nil;
}

#pragma mark - Camera Methods

- (void)openCamera {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIWindow *theWindow = [[UIApplication sharedApplication] keyWindow];
        [theWindow.rootViewController presentViewController:self.imagePickerController animated:YES completion:nil];
        
    } else {
        UIAlertView *theAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"camera_error", nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles:nil];
        [theAlertView show];
    }
}

- (void)flipCamera {
    switch (self.imagePickerController.cameraDevice) {
        case UIImagePickerControllerCameraDeviceRear:
            self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            [self.photoViewController setFlipCameraTitle:NSLocalizedString(@"flip_to_rear", nil)];
            break;
            
        case UIImagePickerControllerCameraDeviceFront:
            self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            [self.photoViewController setFlipCameraTitle:NSLocalizedString(@"flip_to_front", nil)];
            break;
            
        default:
            break;
    }
}

- (void)toggleFlash {
    switch (self.imagePickerController.cameraFlashMode) {
        case UIImagePickerControllerCameraFlashModeOff:
            self.imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
            [self.photoViewController setToggleFlashTitle:NSLocalizedString(@"flash_on", nil)];
            break;
            
        case UIImagePickerControllerCameraFlashModeOn:
            self.imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
            [self.photoViewController setToggleFlashTitle:NSLocalizedString(@"flash_auto", nil)];
            break;
            
        case UIImagePickerControllerCameraFlashModeAuto:
            self.imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
            [self.photoViewController setToggleFlashTitle:NSLocalizedString(@"flash_off", nil)];
            break;
            
        default:
            break;
    }
}

- (void)capturePhoto {
    [self.imagePickerController takePicture];
}

#pragma mark - UIImagePickerControllerDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)anImagePickerController didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // Save Photo
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImageWriteToSavedPhotosAlbum(theImage, nil, nil, nil);
    }
}

@end
