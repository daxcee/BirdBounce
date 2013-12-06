#import "kobold2d.h"

@interface Bounce : CCLayer
{
}

//determines whether the game is over or not
@property (nonatomic, assign) int gameOver;

- (void) makeBird;

@end
