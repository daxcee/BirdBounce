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
        NSString *documentsDirectory1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath1 = [documentsDirectory1 stringByAppendingFormat:@"HighScores.plist"];
        NSMutableArray *highScoresArray = [NSMutableArray arrayWithContentsOfFile: filePath1];
        NSLog(@"what the plist contained before the game = %@", highScoresArray);
        int arraySize = [highScoresArray count];
        
        
        //this will show the plist on the game over screen
        
        /*NSNumber * newHigh = [NSNumber numberWithInt:highScore];
        NSLog
        (@"this current session's highScore: %d", highScore);
        for (int i = 0; i < arraySize; i+=2) {
            int j = i + 1;
            NSNumber *oldHighScore = [highScoresArray objectAtIndex: j];
            if (newHigh > oldHighScore) {
                [highScoresArray replaceObjectAtIndex:j withObject: newHigh];
            }
        }*/
        
        // this will update the highScoresArray if your score is higher than any of the three highest saved
        NSNumber * newHigh = [NSNumber numberWithInt:highScore];
        NSLog(@"this current session's highScore: %d", highScore);
        
        NSNumber * oldHighTop = [highScoresArray objectAtIndex: 1];
        NSNumber * oldHighMid = [highScoresArray objectAtIndex: 3];
        NSNumber * oldHighBot = [highScoresArray objectAtIndex: 5];
        
        if (newHigh > oldHighTop) {
            [highScoresArray replaceObjectAtIndex:1 withObject: newHigh];
            [highScoresArray replaceObjectAtIndex:3 withObject: oldHighTop];
            [highScoresArray replaceObjectAtIndex:5 withObject: oldHighMid];
        }
        if (newHigh <= oldHighTop && newHigh > oldHighMid) {
            [highScoresArray replaceObjectAtIndex:3 withObject: newHigh];
            [highScoresArray replaceObjectAtIndex:5 withObject: oldHighMid];
        }
        
        if (newHigh <= oldHighMid && newHigh > oldHighBot) {
            [highScoresArray replaceObjectAtIndex:5 withObject: newHigh];
        }
        
        /*for (int i = 0; i < arraySize; i+=2) {
            int j = i + 1;
            NSNumber *oldHighScore = [highScoresArray objectAtIndex: j];
            if (newHigh > oldHighScore && i == 0) {
                NSNumber *oldHighScore2 = [highScoresArray objectAtIndex:j+2];
                [highScoresArray replaceObjectAtIndex:j withObject: newHigh];
                [highScoresArray replaceObjectAtIndex:j+2 withObject: oldHighScore];
                [highScoresArray replaceObjectAtIndex:j+4 withObject: oldHighScore2];
            } else if (newHigh > oldHighScore && i == 2) {
                [highScoresArray replaceObjectAtIndex: j withObject: newHigh];
                [highScoresArray replaceObjectAtIndex:j+2 withObject: oldHighScore];
            } else if (newHigh > oldHighScore && i == 4) {
                [highScoresArray replaceObjectAtIndex: j withObject: newHigh];
            }
        }*/
        
        
        
        /*NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentFolder = [path objectAtIndex: 0];
        NSString *filePath = [documentFolder stringByAppendingFormat:@"HighScores.plist"];
        [highScoresArray writeToFile:filePath atomically:YES];*/
        
        NSLog(@"highScoresArray currently contains: %@", highScoresArray);
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingFormat:@"HighScores.plist"];
        [highScoresArray writeToFile: filePath atomically:YES];
        
        NSMutableArray *newArray = [NSMutableArray arrayWithContentsOfFile:filePath];
        NSLog(@"newArray contains: %@", newArray);
        
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
        leaderSprite.position = ccp(screenWidth/2, screenHeight/2+screenHeight/9);
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
