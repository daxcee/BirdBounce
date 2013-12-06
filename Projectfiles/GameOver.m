//
//  GameOver.m
//  Bounce
//
//  Created by Linda He on 12/6/13.
//
//

#import "GameOver.h"
#import "Bounce.h"
#import "Score.h"

CGFloat screenWidth;
CGFloat screenHeight;

@implementation GameOver



+ (id) GameOverscene
{
    CCScene *scene = [CCScene node];
    
    
    GameOver *layer = [GameOver node];
    
    
    [scene addChild: layer];
    
    
    return scene;
}

/*-(id) init
 {
 return [self initWithScore: 0];
 }*/

-(id) initWithScore: (int) highScore
{

    if( (self=[super init]))
    {
        /*
         generalized dimensions
         */
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        screenWidth = screenRect.size.width;
        screenHeight = screenRect.size.height;
        
        
        /*
         setting up the game over screen and the menu option to restart
         */
        CCSprite *gameOverBG = [CCSprite spriteWithFile:@"pausebackground.png"];
        gameOverBG.scaleX = screenWidth/gameOverBG.contentSize.width;
        gameOverBG.scaleY = screenHeight/gameOverBG.contentSize.height;
        gameOverBG.position = ccp(screenWidth/2, screenHeight/2);
        [self addChild: gameOverBG];
        
        CCMenuItemImage *restart = [CCMenuItemImage
                                    itemWithNormalImage:@"restart.png"
                                    selectedImage:@"restart.png"
                                    target:self
                                    selector:@selector(reStart:)];
        restart.position = ccp(0, -50);
        
        
        CCMenu * gameOverMenu = [CCMenu menuWithItems: restart, nil];
        
        [self addChild: gameOverMenu];
        
        /*
         setting up high score
         */
        
        /*self.totalScore = newScore;*/
        /*self.position = ccp(320/6*5, 465);*/
        NSString * scoreString = [[NSString alloc] initWithFormat:@"score\n %d", highScore];
        CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:scoreString
                                             fontName:@"Marker Felt"
                                             fontSize:20];
        scoreLabel.color = ccc3(255, 255, 255);
        scoreLabel.position = ccp(320/2, 310);
        /*CCSprite *scoreSprite = [CCSprite spriteWithSpriteFrame : self.scoreLabel.displayFrame];*/
        [self addChild:scoreLabel];
        /*[self addChild:self.scoreSprite];*/
        
        
        
        // position your pause menu in the center of your layer
        gameOverMenu.position = ccp(screenWidth/2, screenHeight/2);
        
        
        
        
        
    }
    return self;
}

- (void) reStart: (id) sender
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[Bounce alloc] init]];
}

@end
