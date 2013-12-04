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
}

-(id) initWithPosition:(int) pathXPos
{
    if ((self = [super init]))
    {
/*<<<<<<< HEAD
        isFalling = TRUE;
        fallingSpeed = 200;
        CCSprite *bird = [CCSprite spriteWithFile:@"upbird.png"];
        bird.position = ccp(pathXPos, 480);
=======*/
        self.isFalling = TRUE;
        self.fallingSpeed = 200;
        self.birdSprite = [CCSprite spriteWithFile:@"upbird.png"];
        self.position = ccp(pathXPos, 480);
        [self addChild:self.birdSprite];
/*>>>>>>> c0742f00241aed57e89ad28788454c173e4b3a92*/
    }
    return self;
}

-(id) init
{
    // by default creates a bird in the middle
    return [self initWithPosition: 320/2];
}

-(void)replaceSprite
{
    
}


@end
