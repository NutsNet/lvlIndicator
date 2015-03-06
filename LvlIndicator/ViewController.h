//
//  ViewController.h
//  LvlIndicator
//
//  Created by Christophe Vichery on 05/03/2015.
//  Copyright (c) 2015 Christophe Vichery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LvlView.h"
#import "NumpadView.h"

@interface ViewController : UIViewController
{
    // UI
    LvlView *viewLvl;
    NumpadView *viewNumpad;
    
    UILabel *labelTopBar;
    
    CGFloat ratioIos;
}

@end