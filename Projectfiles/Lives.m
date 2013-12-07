//
//  Lives.m
//  Bounce
//
//  Created by Linda He on 12/6/13.
//
//

#import "Lives.h"
#import "Bounce.h"

@implementation Lives
{
    NSString *livesString;
}

-(id) init
{
    return [self initWithLives: 3];
}

-(id) initWithLives:(int) newLives //newScore
{
    if ((self = [super init]))
    {

        /*
        self.totalLives = newLives;
        self.position = ccp(320/6*5, 465-20);
        livesString = [[NSString alloc] initWithFormat:@"Lives Left: %d", self.totalLives];
        self.livesLabel = [CCLabelTTF labelWithString:livesString
                                             fontName:@"Marker Felt"
                                             fontSize:18];
        self.livesLabel.color = ccc3(255, 0, 0);
        self.livesSprite = [CCSprite spriteWithSpriteFrame : self.livesLabel.displayFrame];
        [self addChild:self.livesLabel];
        [self addChild:self.livesSprite];
         
         */
        
        self.totalLives = newLives;
        self.position = ccp(320/6*5, 465-20);
        livesString = [[NSString alloc] initWithFormat:@"Lives Left: %d", self.totalLives];
        self.livesLabel = [CCLabelTTF labelWithString:livesString
                                             fontName:@"Marker Felt"
                                             fontSize:18];
        self.livesLabel.color = ccc3(255, 0, 0);
        self.livesSprite1 = [CCSprite spriteWithFile:@"heart.png"];
        self.livesSprite2 = [CCSprite spriteWithFile:@"2hearts.png"];
        self.livesSprite3 = [CCSprite spriteWithFile:@"3hearts.png"];
        //[self addChild:self.livesLabel];
        
        if (newLives == 1) {
            [self addChild:self.livesSprite1];
        } else if (newLives == 2) {
            [self addChild:self.livesSprite2];
        } else {
            [self addChild:self.livesSprite3];
        }
        
    }
        
    return self;
}

@end
