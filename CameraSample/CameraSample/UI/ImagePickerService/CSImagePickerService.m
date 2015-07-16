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
        
        self.imagePickerController = [[UIImagePickerController alloc] init];
        self.imagePickerController.delegate = self;
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePickerController.showsCameraControls = NO;
        self.imagePickerController.navigationBarHidden = NO;
        self.imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
        self.imagePickerController.cameraOverlayView = self.photoViewController.view;
        self.imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;

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
            break;
            
        case UIImagePickerControllerCameraDeviceFront:
            self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            break;
            
        default:
            break;
    }
}

- (void)toggleFlash {
    switch (self.imagePickerController.cameraFlashMode) {
        case UIImagePickerControllerCameraFlashModeOff:
            self.imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
            [self.photoViewController setToggleTitle:@"Flash On"];
            break;
            
        case UIImagePickerControllerCameraFlashModeOn:
            self.imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
            [self.photoViewController setToggleTitle:@"Flash Auto"];
            break;
            
        case UIImagePickerControllerCameraFlashModeAuto:
            self.imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
            [self.photoViewController setToggleTitle:@"Flash Off"];
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
