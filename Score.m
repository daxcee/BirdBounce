#import "Score.h"
#import "Bounce.h"

@implementation Score
{
    CCLabelTTF *scoreLabel;
}

-(id) init
{
    if ((self = [super init]))
    {
        self.totalScore = 0;
        self.position = ccp(320/7*6, 400);
//        self.scoreLabel = [CCLabelTTF labelWithString:@"My string"
//                                             fontName:@"Marker Felt"
//                                        fontSize:50];
//        self.scoreLabel.position = ccp(160,280);
//        self.scoreLabel.color = ccc3(255, 0, 0);
        //self.scoreSprite = [CCSprite spriteWithSpriteFrame : scoreLabel.displayFrame];
        [self addChild:self.scoreLabel];
        //[self addChild:self.scoreSprite];
    }
    return self;
}

-(id) setScore: (int) newScore
{
    
}

@end
