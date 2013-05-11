//
//  STMushroom.m
//  Game
//
//  Created by Ilija Tovilo on 5/10/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STMushroom.h"
#import "STPlayer.h"

@implementation STMushroom

- (id)init
{
    if (self = [super initWithPlistFile:@"Mushroom.plist"]) {
        [self runAnimationWithName:@"default" endless:YES];
    }
    return self;
}

- (void)collisionWithGameObject:(STGameObject *)gameObject
                           edge:(STRectEdge)edge {
    
    
    if ([[gameObject class] isSubclassOfClass:[STPlayer class]]) {
        STPlayer *player = (STPlayer *)gameObject;
        if (player.playerState == STPlayerStateSmall) {
            player.playerState = STPlayerStateLarge;
        }
    }
}

@end
