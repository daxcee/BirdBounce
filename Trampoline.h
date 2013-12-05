#import "CCSprite.h"

@interface Trampoline : CCSprite {
    
}

-(id) initWithPosition:(int) pathXPos;

// sprite respresenting trampoline
@property (nonatomic, weak) CCSprite *trampolineSprite;

@end
