#import "CCSprite.h"

@interface Score : CCSprite {
}


- (id) setScore: (int) newScore;

// player's total score
@property (nonatomic, assign) int totalScore;

// score sprite
@property (nonatomic, weak) CCSprite *scoreSprite;

// score sprite
@property (nonatomic, weak) CCLabelTTF *scoreLabel;

@end
