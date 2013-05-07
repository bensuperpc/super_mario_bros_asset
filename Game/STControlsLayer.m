//
//  STControlsLayer.m
//  Game
//
//  Created by Lukas Seglias on 30.04.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STControlsLayer.h"
#import "CCControlExtension.h"

@implementation STControlsLayer
{}

#pragma mark -
#pragma mark Initialise
- (id)initWithDelegate:(id <STControlsDelegate>)delegate {
    self = [super init];
    if (self) {
        [self setDelegate:delegate];
        [self setUpWithDelegate:delegate];
    }
    return self;
}

+ (id)layerWithDelegate:(id <STControlsDelegate>)delegate {
    return [[self alloc] initWithDelegate:delegate];
}

- (void)setUpWithDelegate:(id <STControlsDelegate>)delegate {
    [super setUp];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // Joystick
    SneakyJoystickSkinnedBase *leftJoy = [[SneakyJoystickSkinnedBase alloc] init];
    leftJoy.position = kJoystickPosition;
    leftJoy.backgroundSprite = [ColoredCircleSprite circleWithColor:kJoystickBaseColor radius:kJoystickBaseRadius];
    leftJoy.thumbSprite = [ColoredCircleSprite circleWithColor:kJoystickColor radius:kJoystickRadius];
    leftJoy.joystick = [[SneakyJoystick alloc] initWithRect:kJoystickRect];
    self.joystick = leftJoy.joystick;
    [self addChild:leftJoy];
    
    // Pause Button
    CCControlButton *pauseButton = [CCControlButton buttonWithTitle:@"II" fontName:kButtonFontName fontSize:kButtonFontSize];
    [pauseButton setAdjustBackgroundImage:NO];
    [pauseButton addTarget:delegate action:@selector(pause:) forControlEvents:CCControlEventTouchUpInside];
    pauseButton.position = ccp(kPadding + pauseButton.contentSize.width / 2,
                               winSize.height - pauseButton.contentSize.height / 2 - kPadding);
    [self addChild:pauseButton];
    
    // A Button
    CCControlButton *aButton = [CCControlButton buttonWithTitle:@"A" fontName:kButtonFontName fontSize:kButtonFontSize];
    [aButton setAdjustBackgroundImage:NO];
    [aButton addTarget:delegate action:@selector(a:) forControlEvents:CCControlEventTouchUpInside];
    aButton.position = ccp(winSize.width - aButton.contentSize.width - kPadding,
                           aButton.contentSize.height / 2 + kPadding);
    [self addChild:aButton];
    
    // B Button
    CCControlButton *bButton = [CCControlButton buttonWithTitle:@"B" fontName:kButtonFontName fontSize:kButtonFontSize];
    [bButton setAdjustBackgroundImage:NO];
    [bButton addTarget:delegate action:@selector(b:) forControlEvents:CCControlEventTouchUpInside];
    bButton.position = ccp(winSize.width - bButton.contentSize.width - aButton.contentSize.width - 2 * kPadding,
                           bButton.contentSize.height / 2 + kPadding);
    [self addChild:bButton];
}

#pragma mark -
#pragma mark Update
- (BOOL)needsUpdate {
    return YES;
}

- (void)update:(ccTime)delta {
    if([self delegate]) {
        [[self delegate] joystick:self.joystick delta:delta];
    }
}

@end
