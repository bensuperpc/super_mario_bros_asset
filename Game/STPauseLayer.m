//
//  STPauseLayer.m
//  Game
//
//  Created by Lukas Seglias on 30.04.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STPauseLayer.h"
#import "CCDirector+Transitions.h"
#import "CCControlExtension.h"
#import "STLevelLayer.h"
#import "STChooseLevelLayer.h"

@implementation STPauseLayer
{}

#pragma mark -
#pragma mark Initialise
-(id)initWithDelegate:(id <STPauseDelegate>)delegate
              worldID:(unsigned short)worldID
              levelID:(unsigned short)levelID {
    self = [super init];
    if (self) {
        [self setUpWithDelegate:delegate worldID:worldID levelID:levelID];
    }
    return self;
}

+(id)layerWithDelegate:(id <STPauseDelegate>)delegate
               worldID:(unsigned short)worldID
               levelID:(unsigned short)levelID {
    return [[self alloc] initWithDelegate:delegate worldID:worldID levelID:levelID];
}

- (void)setUpWithDelegate:(id <STPauseDelegate>)delegate
                  worldID:(unsigned short)worldID
                  levelID:(unsigned short)levelID {
    self.worldID = worldID;
    self.levelID = levelID;
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // Level Information
    NSString *levelInfo = [NSString stringWithFormat:@"%i-%i", worldID, levelID];
    CCLabelTTF *level = [CCLabelTTF labelWithString:levelInfo fontName:kButtonFontName fontSize:kButtonFontSize];
    level.position = ccp(kPadding + level.contentSize.width / 2,
                         winSize.height - level.contentSize.height / 2 - kPadding);
    [self addChild:level];
    
    // Play Button
    CCControlButton *continueButton = [CCControlButton buttonWithTitle:@"Play" fontName:kButtonFontName fontSize:kButtonFontSize];
    [continueButton setAdjustBackgroundImage:NO];
    [continueButton addTarget:delegate action:@selector(play:) forControlEvents:CCControlEventTouchUpInside];
    continueButton.position = ccp(kPadding + continueButton.contentSize.width / 2,
                                  winSize.height - continueButton.contentSize.height / 2
                                  - level.contentSize.height - 2 * kPadding);
    [self addChild:continueButton];
    
    // Retry Button
    CCControlButton *retryButton = [CCControlButton buttonWithTitle:@"Retry" fontName:@"Helvetica" fontSize:30];
    [retryButton setAdjustBackgroundImage:NO];
    [retryButton addTarget:self action:@selector(retryLevel:) forControlEvents:CCControlEventTouchUpInside];
    retryButton.position = ccp(kPadding + retryButton.contentSize.width / 2,
                                kPadding + retryButton.contentSize.height / 2);
    [self addChild:retryButton];
    
    // Level Overview Button
    CCControlButton *levelsButton = [CCControlButton buttonWithTitle:@"Levels" fontName:kButtonFontName fontSize:kButtonFontSize];
    [levelsButton setAdjustBackgroundImage:NO];
    [levelsButton addTarget:self action:@selector(levelOverview:) forControlEvents:CCControlEventTouchUpInside];
    levelsButton.position = ccp(kPadding + levelsButton.contentSize.width / 2,
                                kPadding + levelsButton.contentSize.height / 2 + retryButton.contentSize.height + kPadding);
    [self addChild:levelsButton];
    
    [self addChild:[CCLayerColor layerWithColor:kPausePanelColor
                                          width:levelsButton.contentSize.width + 2 * kPadding
                                         height:[[CCDirector sharedDirector] winSize].height] z:-5];
}

#pragma mark -
#pragma mark Retry Level
- (IBAction)retryLevel:(id)sender {
    [[STGameFlowManager sharedInstance] resume];
    STScene *scene = [STLevelLayer sceneWithWorldID:self.worldID levelID:self.levelID];
    [[CCDirector sharedDirector] replaceScene: scene
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

#pragma mark -
#pragma mark Level Overview
- (IBAction)levelOverview:(id)sender {
    [[STGameFlowManager sharedInstance] resumeWithMusicOn:NO];
    [[CCDirector sharedDirector] replaceScene: [[STChooseLevelLayer layerWithWorldID:self.worldID] scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

@end
