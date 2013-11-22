//
//  Trampoline.h
//  Bounce
//
//  Created by Tsion Behailu on 11/20/13.
//
//

#import "CCSprite.h"

@interface Trampoline : CCSprite {
    
}

-(id) initWithPosition:(int) pathXPos;

// sprite respresenting trampoline
@property (nonatomic, weak) CCSprite *trampolineSprite;

@end
