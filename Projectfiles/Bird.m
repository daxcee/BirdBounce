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
        self.isFalling = TRUE;
        self.isOutofScreen = false;
        self.fallingSpeed = 200;
        self.birdSprite = [CCSprite spriteWithFile:@"downbird.png"];
        self.position = ccp(pathXPos, 480);
        [self addChild:self.birdSprite];
    }
    return self;
}

-(id) init
{
    // by default creates a bird in the middle
    return [self initWithPosition: 320/2];
}


@end
