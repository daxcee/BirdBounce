//
//  Score.m
//  Bounce
//
//  Created by Tsion Behailu on 12/4/13.
//
//

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
        /*self.totalScore = 0;
        self.position = ccp(320/7*6, 480);
        scoreLabel = [CCLabelTTF labelWithString:@"My string."
                                           dimensions:CGSizeMake(200, 120)
                                           hAlignment:kCCTextAlignmentCenter
                                        lineBreakMode:kCCLineBreakModeWordWrap
                                             fontName:@"EngraversMT" fontSize:14];
        
        self.scoreSprite = [CCSprite spriteWithCGImage:scoreLabel];*/
    }
    return self;
}


@end
