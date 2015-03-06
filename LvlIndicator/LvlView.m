//
//  LvlView.m
//  LvlIndicator
//
//  Created by Christophe Vichery on 05/03/2015.
//  Copyright (c) 2015 Christophe Vichery. All rights reserved.
//

#import "LvlView.h"

@implementation LvlView

// Class release
- (void)dealloc
{
    [layerLvl release]; layerLvl = nil;
    [layerLvlBar release]; layerLvlBar = nil;
    [labelLvl release]; labelLvl = nil;
    
    [super dealloc];
}

// Class initialization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(!self) { return nil; }
    
    // Parameters
    level =0;
    
    arrayOfNumbers = [[NSMutableArray alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) { ratioIos = 1.0; } else { ratioIos = 0.5; }
    
    // Notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(feedArrayOfNumbers:) name:@"feedArrayOfNumbers" object:nil];
    
    // Level Indicator
    [self setFrame:frame];
    
    // Level bar
    CGRect rect = CGRectMake(20*ratioIos, 20*ratioIos, [self frame].size.width - 40*ratioIos, [self frame].size.height*2/3 - 20*ratioIos);
    
    layerLvl = [CALayer layer];
    [layerLvl setFrame:rect];
    [layerLvl setOpacity:0.75];
    [layerLvl setMasksToBounds:YES];
    [layerLvl setBackgroundColor:[UIColor lightGrayColor].CGColor];
    [layerLvl setCornerRadius:20.0*ratioIos];
    [layerLvl setBorderWidth: 4.0*ratioIos];
    [[self layer] addSublayer:layerLvl];
    
    rect = CGRectMake(-[layerLvl frame].size.width, 0, [layerLvl frame].size.width, [layerLvl frame].size.height);
    
    layerLvlBar = [CALayer layer];
    [layerLvlBar setFrame:rect];
    [layerLvlBar setOpacity:0.75];
    [layerLvlBar setBackgroundColor:[UIColor greenColor].CGColor];
    [layerLvlBar setBorderWidth: 4.0*ratioIos];
    [layerLvl addSublayer:layerLvlBar];
    
    // Level number
    rect = CGRectMake(20*ratioIos, [self frame].size.height*2/3, [self frame].size.width - 40*ratioIos, [self frame].size.height/3);
    
    labelLvl = [[UILabel alloc] initWithFrame:rect];
    [labelLvl setFont:[UIFont fontWithName:@"Bauhaus 93" size:40*ratioIos]];
    [labelLvl setTextAlignment:NSTextAlignmentCenter];
    [labelLvl setTextColor:[UIColor whiteColor]];
    [labelLvl setAdjustsFontSizeToFitWidth:YES];
    [labelLvl setText:@"Current value: 0"];
    [labelLvl setAlpha:0.75];
    [self addSubview:labelLvl];
    
    return self;
}

// Feed array of numbers
- (void)feedArrayOfNumbers:(NSNotification*)notif
{
    [arrayOfNumbers addObject:[notif object]];
    
    if([arrayOfNumbers count] == 1) { [self animLvlIndicator:[arrayOfNumbers objectAtIndex:0]]; }
}

// Level indicator animation
- (void)animLvlIndicator:(NSNumber*)num
{
    // Update lvl label after 1sec
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, kAnimDuration*NSEC_PER_SEC), dispatch_get_main_queue(), ^(void)
    {
        [labelLvl setText:[@"Current value: " stringByAppendingString:[@(level) stringValue]]];
        
        [arrayOfNumbers removeObjectAtIndex:0];
        
        if([arrayOfNumbers count] >0) { [self animLvlIndicator:[arrayOfNumbers objectAtIndex:0]]; }
    });
    
    // Translation
    CABasicAnimation *translation = [[CABasicAnimation alloc] init];
    [translation setKeyPath:@"transform.translation.x"];
    [translation setRemovedOnCompletion:NO];
    [translation setFillMode:kCAFillModeForwards];
    [translation setDuration:kAnimDuration];
    
    [translation setFromValue:[NSNumber numberWithFloat:level*[layerLvl frame].size.width/9]];
    level = [num unsignedIntegerValue];
    [translation setToValue:[NSNumber numberWithFloat:level*[layerLvl frame].size.width/9]];
    
    // Opacity
    CABasicAnimation *opacity = [[CABasicAnimation alloc] init];
    [opacity setKeyPath:@"opacity"];
    [opacity setRemovedOnCompletion:NO];
    [opacity setFillMode:kCAFillModeForwards];
    [opacity setDuration:kAnimDuration];
    
    [opacity setFromValue:[NSNumber numberWithFloat:0.1]];
    [opacity setToValue:[NSNumber numberWithFloat:0.75]];
    
    // Start animation
    [layerLvlBar addAnimation:opacity forKey:@"opacity"];
    [layerLvlBar addAnimation:translation forKey:@"transform.translation.x"];
    
    // Release animations
    [opacity release]; opacity = nil;
    [translation release]; translation = nil;
}

@end