#import "CCSprite.h"

@interface Bird : CCSprite
{   
}

- (id) initWithPosition:(int) pathXPos;

//determines whether the bird is falling
@property (nonatomic, assign) BOOL isFalling;

//determines whether the bird is out of screen
@property (nonatomic, assign) BOOL isOutofScreen;

//changing velocity of the bird as it falls
@property (nonatomic, assign) int fallingSpeed;

// sprite respresenting bird
@property (nonatomic, weak) CCSprite *birdSprite;

@end



