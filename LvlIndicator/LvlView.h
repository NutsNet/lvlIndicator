//
//  LvlView.h
//  LvlIndicator
//
//  Created by Christophe Vichery on 05/03/2015.
//  Copyright (c) 2015 Christophe Vichery. All rights reserved.
//

#import <UIKit/UIKit.h>

// Duration of the animation
#define kAnimDuration 1.0

@interface LvlView : UIView
{
    // UI
    CALayer *layerLvl, *layerLvlBar;
    UILabel *labelLvl;
    CGFloat ratioIos;
    
    // Level reached during the last animation
    NSUInteger level;
    
    // Buffer of all the levels to reach for the further animations
    NSMutableArray *arrayOfNumbers;
}

@end