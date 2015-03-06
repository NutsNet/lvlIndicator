//
//  AppDelegate.h
//  LvlIndicator
//
//  Created by Christophe Vichery on 05/03/2015.
//  Copyright (c) 2015 Christophe Vichery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    ViewController *vc;
    UINavigationController *nc;
}

@property (strong, nonatomic) UIWindow *window;

@end