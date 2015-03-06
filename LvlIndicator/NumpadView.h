//
//  NumpadView.h
//  LvlIndicator
//
//  Created by Christophe Vichery on 05/03/2015.
//  Copyright (c) 2015 Christophe Vichery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#define kSfxBuf 5

@interface NumpadView : UIView
{
    // UI
    UILabel *labelTouchpad;
    NSMutableArray *arrayOfTouchpads;
    CGFloat ratioIos;
    
    // Audio
    AVAudioSession *audioSession;
    AVAudioPlayer *soundClick[kSfxBuf];
    NSInteger iBuf;
}

@end