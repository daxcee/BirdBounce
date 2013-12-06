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
        /*self.totalScore = 0;
        self.position = ccp(320/7*6, 480);
        scoreLabel = [CCLabelTTF labelWithString:@"My string."
                                           dimensions:CGSizeMake(200, 120)
                                           hAlignment:kCCTextAlignmentCenter
                                        lineBreakMode:kCCLineBreakModeWordWrap
                                             fontName:@"EngraversMT" fontSize:14];
        
        self.scoreSprite = [CCSprite spriteWithCGImage:scoreLabel];*/
        
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
