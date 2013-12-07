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
        CCLOG(@"entering game over!");
        /*
         generalized dimensions
         */
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        screenWidth = screenRect.size.width;
        screenHeight = screenRect.size.height;
        
        /*
         Checking for high score
         */
        
        //this reads the plist and fetches the three highest scores already stored
        NSMutableArray *highScoresArray = [NSMutableArray arrayWithContentsOfFile: @"HighScores.plist"];
        NSLog(@"array = %@", highScoresArray);
        int arraySize = [highScoresArray count];
        
        
        //this will show the plist on the game over screen
        
        
        /*for (int i = 0; i < arraySize; i++) {
            NSInteger j = i + 1;
            int oldHighScore = [highScoresArray objectAtIndex: j];
            if (highScore > oldHighScore) {
                NSInteger newHigh = highScore;
                [highScoresArray replaceObjectAtIndex:j withObject: newHigh];
            }
        }
                            
                            /* for reference
                             for(int i = 0; i < [birds count]; i++)
                            {
                                NSInteger j = i;
                                birdPtr = [birds objectAtIndex:j];
                                if (birdPtr.isFalling) {
                                    /*birdPtr.position = ccp(birdPtr.position.x, birdPtr.position.y - birdPtr.fallingSpeed*dt - birdPtr.fallingSpeed*birdPtr.fallingAccel*dt*dt);
                                    birdPtr.position = ccp(birdPtr.position.x, birdPtr.position.y - birdPtr.fallingSpeed*dt - currentSpeed*dt*dt);
                                } else {
                                    birdPtr.position = ccp(birdPtr.position.x, birdPtr.position.y + birdPtr.fallingSpeed*dt + birdPtr.fallingSpeed*(birdPtr.fallingAccel/3)*dt*dt);
                                }
                                
                            }*/
        
                

    
        
        /*
         setting up the game over screen and the menu option to restart
         */
        CCSprite *gameOverBG = [CCSprite spriteWithFile:@"gameoverbackground.png"];
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
         setting up leader scoreboard
         */
        
        NSString* leaderString = [[NSString alloc] initWithFormat:@"all-time high scores\n %@: %@\n %@: %@ \n %@: %@",
                                  [highScoresArray objectAtIndex: 0],[highScoresArray objectAtIndex: 1],
                                  [highScoresArray objectAtIndex: 2],[highScoresArray objectAtIndex: 3],
                                  [highScoresArray objectAtIndex: 4],[highScoresArray objectAtIndex: 5]];
        NSLog(@"%@",leaderString);
        CCLabelTTF *leaderLabel = [CCLabelTTF labelWithString: leaderString
                                                     fontName: @"Marker Felt"
                                                     fontSize: 20];
        
        leaderLabel.color = ccc3(255, 255, 255);
        CCSprite *leaderSprite = [CCSprite spriteWithSpriteFrame : leaderLabel.displayFrame];
        leaderLabel.position = ccp(screenWidth/2, screenHeight/2+screenHeight/9);
        [self addChild: leaderLabel];
        [self addChild: leaderSprite];
        
        
        /*
         setting up your high score
         */
        
        NSString * scoreString = [[NSString alloc] initWithFormat:@"your high score\n %d", highScore];
        CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:scoreString
                                             fontName:@"Marker Felt"
                                             fontSize:20];
        scoreLabel.color = ccc3(255, 255, 255);
        scoreLabel.position = ccp(screenWidth/2, screenHeight/2-screenHeight/10);
        [self addChild:scoreLabel];
        
        // position your pause menu in the center of your layer
        gameOverMenu.position = ccp(screenWidth/2, screenHeight/2-75);
        
    }
    return self;
}

- (void) reStart: (id) sender
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[Bounce alloc] init]];
}

@end