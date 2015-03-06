//
//  NumpadView.m
//  LvlIndicator
//
//  Created by Christophe Vichery on 05/03/2015.
//  Copyright (c) 2015 Christophe Vichery. All rights reserved.
//

#import "NumpadView.h"

@implementation NumpadView


// Class release
- (void)dealloc
{
    [arrayOfTouchpads release]; arrayOfTouchpads = nil;
    [audioSession release]; audioSession = nil;
    
    for(int i=0; i<5; i++)
    {
        [soundClick[i] release];
        soundClick[i] = nil;
    }
    
    [super dealloc];
}

// Class initialization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(!self) { return nil; }
    
    // Parameters
    arrayOfTouchpads = [[NSMutableArray alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) { ratioIos = 1.0; } else { ratioIos = 0.5; }
    
    // Numpad
    [self setFrame:frame];
    
    // Touchpads
    CGRect rect;
    NSUInteger nb;
    CGFloat sizePad, xDelta, yDelta;
    
    if([self frame].size.width/3 > [self frame].size.height/4)
    {
        sizePad = [self frame].size.height/4;
        xDelta = ([self frame].size.width - 3*sizePad)/2;
        yDelta = 0;
        
        sizePad -= 30*ratioIos/4;
        rect = CGRectMake(0, 0, sizePad, sizePad);
    }
    else
    {
        sizePad = [self frame].size.width/3;
        xDelta = 0;
        yDelta = ([self frame].size.height - 4*sizePad)/2;
        
        sizePad -= 20*ratioIos/3;
        
        rect = CGRectMake(0, 0, sizePad, sizePad);
    }
    
    for(NSUInteger i=0; i<12; i++)
    {
        if(i != 9 && i!= 11)
        {
            nb = 7-3*(i/3)+(i%3);
            
            rect.origin.x = (i%3)*sizePad + 10*(i%3)*ratioIos + xDelta;
            rect.origin.y = (i/3)*sizePad + 10*(i/3)*ratioIos + yDelta;
            
            labelTouchpad = [[UILabel alloc] init];
            [labelTouchpad setFrame:rect];
            [labelTouchpad setAlpha:0.75];
            [labelTouchpad setBackgroundColor:[UIColor lightGrayColor]];
            [labelTouchpad setFont:[UIFont fontWithName:@"Bauhaus 93" size:50*ratioIos]];
            [labelTouchpad setTextAlignment:NSTextAlignmentCenter];
            [labelTouchpad setAdjustsFontSizeToFitWidth:YES];
            
            if(i == 10) { nb = 0;}
            
            [labelTouchpad setTag:nb];
            [labelTouchpad setText:[@(nb) stringValue]];
            
            [[labelTouchpad layer] setMasksToBounds:YES];
            [[labelTouchpad layer] setCornerRadius:25.0*ratioIos];
            [[labelTouchpad layer] setBorderWidth:6.0*ratioIos];
            [[labelTouchpad layer] setName:[@(nb) stringValue]];
            
            [self addSubview:labelTouchpad];
            
            [arrayOfTouchpads addObject:labelTouchpad];
        }
    }
    
    // Position 5 initialization
    [[NSNotificationCenter defaultCenter] postNotificationName:@"feedArrayOfNumbers"
                                                        object:[NSNumber numberWithUnsignedInteger:5]];
    
    // Sound initialization
    [self initSound];
    
    return self;
}

// We touch the screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pointHit  = [[touches anyObject] locationInView:self];
    
    pointHit.x += [self frame].origin.x;
    pointHit.y += [self frame].origin.y;
    
    CALayer *layerHit = [[[self layer] presentationLayer] hitTest:pointHit];
    
    for(UILabel *label in arrayOfTouchpads)
    {
        if([[layerHit name] isEqualToString:[[label layer] name]])
        {
            [self playSoundClick];
            [label setBackgroundColor:[UIColor darkGrayColor]];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"feedArrayOfNumbers"
                                                                object:[NSNumber numberWithUnsignedInteger:[label tag]]];
        }
    }
}

// We stop to touch the screen
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for(UILabel *label in arrayOfTouchpads) { [label setBackgroundColor:[UIColor lightGrayColor]]; }
}

// Sound initialization
- (void)initSound
{
    // Audio session initialization
    audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:nil];
    [audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:nil];
    [audioSession setActive:YES error:nil];
    
    // Sounds initialization
    iBuf = 0;
    
    for(int i=0; i<kSfxBuf; i++)
    {
        soundClick[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:
                         [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"click" ofType:@"mp3"]] error:NULL];
        [soundClick[i] prepareToPlay];
        [soundClick[i] setVolume:1.0f];
    }
}

// Play sound of a touchpad
- (void)playSoundClick
{
    [soundClick [iBuf] play]; iBuf++;
    if(iBuf == kSfxBuf) { iBuf=0; }
}

@end