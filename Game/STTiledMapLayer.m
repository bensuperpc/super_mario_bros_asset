//
//  STTiledMapScene.m
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STTiledMapLayer.h"

@implementation STTiledMapLayer

- (id)initWithTiledMap:(NSString *)tiledMap
{
    self = [super init];
    if (self) {
        self.map = [CCTMXTiledMap tiledMapWithTMXFile:tiledMap];
        self.objectGroup = [self.map objectGroupNamed:@"events"];
        self.objectLayer = [self.map layerNamed:@"objects"];
        
        [self addChild:self.map];
        
        for (int x = 1; x < self.objectLayer.layerSize.width; x++) {
            for (int y = 1; y < self.objectLayer.layerSize.height; y++) {
                CCSprite *tile = [self.objectLayer tileAt:ccp(x, y)];
                NSDictionary *props = [self.map propertiesForGID:[self.objectLayer tileGIDAt:ccp(x, y)]];
                NSString *type = props[@"type"];
                if (type.length) {
                    Class objectClass = NSClassFromString(type);
                    CCNode *node = [objectClass node];
                    [node setPosition:tile.position];
                    
                    [self addChild:node];
                }
            }
        }
        
        /* 
            Würd me ner ire subclass mache
         */
        
        NSDictionary *properties = [self.objectGroup objectNamed:@"marioSpawnPoint"];
        NSLog(@"%@", properties);
        NSLog(@"%@ %@", properties[@"x"], properties[@"y"]);
        
        [self.objectLayer setVisible:NO];
    }
    return self;
}

- (void)setUp {
    
}

+ (id)layerWithTiledMap:(NSString *)tiledMap {
    return [[self alloc] initWithTiledMap:tiledMap];
}

@end
