//
//  UIView+LayerProperties.h
//  CameraSample
//
//  Created by Malik Alayli on 16/07/15.
//  Copyright (c) 2015 Malik Alayli. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UIView (LayerProperties)

@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, strong) IBInspectable UIColor *layerBackgroundColor;

@end
