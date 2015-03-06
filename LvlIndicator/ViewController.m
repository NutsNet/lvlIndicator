//
//  ViewController.m
//  LvlIndicator
//
//  Created by Christophe Vichery on 05/03/2015.
//  Copyright (c) 2015 Christophe Vichery. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// Instances release
- (void)dealloc
{
    [viewLvl release]; viewLvl = nil;
    [viewNumpad release]; viewNumpad = nil;
    [labelTopBar release]; labelTopBar = nil;
    
    [super dealloc];
}

// Class initialization
- (id)init
{
    if(!(self = [super init]))
        return nil;
    
    // Parameters
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) { ratioIos = 1.0; } else { ratioIos = 0.5; }
    
    return self;
}

// First display
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Navigation bar hidden
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    // Background
    [[self view] setBackgroundColor:[UIColor brownColor]];
    
    // Top bar
    CGRect rect = CGRectMake(0, 0, [[self view] frame].size.width, 100*ratioIos);
    
    labelTopBar = [[UILabel alloc] initWithFrame:rect];
    [labelTopBar setBackgroundColor:[UIColor blackColor]];
    [labelTopBar setFont:[UIFont fontWithName:@"Bauhaus 93" size:50*ratioIos]];
    [labelTopBar setTextAlignment:NSTextAlignmentCenter];
    [labelTopBar setTextColor:[UIColor whiteColor]];
    [labelTopBar setAdjustsFontSizeToFitWidth:YES];
    [labelTopBar setText:@".:: Level Indicator ::."];
    [labelTopBar setAlpha:0.75];
    
    [[labelTopBar layer] setShadowOffset:CGSizeMake(4.0*ratioIos, 4.0*ratioIos)];
    [[labelTopBar layer] setShadowColor:[UIColor blackColor].CGColor];
    [[labelTopBar layer] setShadowOpacity:0.5];
    
    // Level indicator
    rect = CGRectMake(0, [labelTopBar frame].size.height, [[self view] frame].size.width, 2*[labelTopBar frame].size.height);
    
    viewLvl = [[LvlView alloc] initWithFrame:rect];
    
    [[self view] addSubview:viewLvl];
    [[[self view] layer] addSublayer:[labelTopBar layer]];
    
    // Numpad
    rect = CGRectMake(20*ratioIos, 3*[labelTopBar frame].size.height, [[self view] frame].size.width - 40*ratioIos,
                      [[self view] frame].size.height - 3*[labelTopBar frame].size.height - 20*ratioIos);
    
    viewNumpad = [[NumpadView alloc] initWithFrame:rect];
    [[self view] addSubview:viewNumpad];
}

// Warning Received
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end