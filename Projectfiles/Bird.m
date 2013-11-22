//
//  Bird.m
//  Bounce
//
//  Created by Linda He on 11/20/13.
//
//

#import "Bird.h"
#import "Trampoline.h"
#import "Bounce.h"

@implementation Bird
{
//    //determines whether the bird is falling
//    BOOL isFalling;
//    //changing velocity of the bird as it falls
//    int fallingSpeed;
}

-(id) initWithPosition:(int) pathXPos
{
    if ((self = [super init]))
    {
        self.isFalling = TRUE;
        self.fallingSpeed = 200;
        self.birdSprite = [CCSprite spriteWithFile:@"upbird.png"];
        self.position = ccp(pathXPos, 480);
        [self addChild:self.birdSprite];
    }
    return self;
}

-(id) init
{
    //by default creates a bird in the middle
    return [self initWithPosition: 320/2];
}


@end
