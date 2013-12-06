//
//  Lives.h
//  Bounce
//
//  Created by Linda He on 12/6/13.
//
//

#import "CCSprite.h"

@interface Lives : CCSprite

// player's total score
@property (nonatomic, assign) int totalLives;

// score sprite
@property (nonatomic, weak) CCSprite *livesSprite;

// score sprite
@property (nonatomic, weak) CCLabelTTF *livesLabel;

@end
