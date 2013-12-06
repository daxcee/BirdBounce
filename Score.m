#import "Score.h"
#import "Bounce.h"

@implementation Score
{
    NSString *scoreString;
}

-(id) init
{
    return [self initWithScore: 0];
}

-(id) initWithScore:(int) newScore
{
    if ((self = [super init]))
    {
        self.totalScore = newScore;
        self.position = ccp(320/6*5, 465);
        scoreString = [[NSString alloc] initWithFormat:@"Score: %d", self.totalScore];
        self.scoreLabel = [CCLabelTTF labelWithString:scoreString
                                             fontName:@"Marker Felt"
                                             fontSize:20];
        self.scoreLabel.color = ccc3(255, 0, 0);
        self.scoreSprite = [CCSprite spriteWithSpriteFrame : self.scoreLabel.displayFrame];
        [self addChild:self.scoreLabel];
        [self addChild:self.scoreSprite];
    }
    return self;
}

@end
