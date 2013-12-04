//
//  Score.h
//  Bounce
//
//  Created by Tsion Behailu on 12/4/13.
//
//

#import "CCSprite.h"

@interface Score : CCSprite {
}


// player's total score
@property (nonatomic, assign) int totalScore;

// score sprite
@property (nonatomic, weak) CCSprite *scoreSprite;

//// score sprite
//@property (nonatomic, weak) CCLabelTTF *scoreLabel;

@end
