//
//  CSImagePickerService.h
//  CameraSample
//
//  Created by Malik Alayli on 16/07/15.
//  Copyright (c) 2015 Malik Alayli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSImagePickerService : NSObject

// Shared Instance Method

+ (instancetype)sharedInstance;

// Camera Methods

- (void)openCamera;

- (void)flipCamera;

- (void)toggleFlash;

- (void)capturePhoto;

@end
