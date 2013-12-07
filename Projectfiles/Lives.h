#import "CCSprite.h"

@interface Lives : CCSprite {
}

-(id) initWithLives:(int) newLives;

// player's total lives
@property (nonatomic, assign) int totalLives;

// lives sprite
@property (nonatomic, weak) CCSprite *livesSprite;

// lives label
@property (nonatomic, weak) CCLabelTTF *livesLabel;


// lives sprite 1
@property (nonatomic, weak) CCSprite *livesSprite1;

// lives sprite 2
@property (nonatomic, weak) CCSprite *livesSprite2;

// lives sprite 3
@property (nonatomic, weak) CCSprite *livesSprite3;

@end
