#import "Trampoline.h"
#import "Bird.h"
#import "Bounce.h"

#define TRAMPOLINEYPOS 420/8

@implementation Trampoline {
    
}

-(id) initWithPosition:(int) pathXPos
{
    if ((self = [super init]))
    {
        self.position = ccp(pathXPos, TRAMPOLINEYPOS);
    }
    return self;
}

-(id) init
{
    //by default creates a trampoline in the middle
    return [self initWithPosition: 320/2];
}


@end
