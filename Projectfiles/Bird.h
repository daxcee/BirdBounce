//
//  Bird.h
//  Bounce
//
//  Created by Linda He on 11/20/13.
//
//

#import "CCSprite.h"

@interface Bird : CCSprite
{   
}

- (id) initWithPosition:(int) pathXPos;

//determines whether the bird is falling
@property (nonatomic, assign) BOOL isFalling;

//changing velocity of the bird as it falls
@property (nonatomic, assign) int fallingSpeed;

// sprite respresenting bird
@property (nonatomic, weak) CCSprite *birdSprite;


+(id) initWithPosition: (int) PathXPos;
@end



