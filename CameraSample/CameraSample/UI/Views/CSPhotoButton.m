//
//  CSPhotoButton.m
//  CameraSample
//
//  Created by Malik Alayli on 17/07/15.
//  Copyright (c) 2015 Malik Alayli. All rights reserved.
//

#import "CSPhotoButton.h"

@implementation CSPhotoButton

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.backgroundColor = [UIColor lightGrayColor];
        
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end
