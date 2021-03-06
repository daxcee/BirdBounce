#import "GameOver.h"
#import "Bounce.h"
#import "Score.h"
#import "StartMenu.h"

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
        /*NSString *filePath1 = [documentsDirectory1 stringByAppendingFormat:@"HighScores.plist"];*/
        NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"HighScores" ofType:@"plist"];
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
        
        if ([newHigh doubleValue] > [oldHighTop doubleValue]) {
            [highScoresArray replaceObjectAtIndex:1 withObject: newHigh];
            [highScoresArray replaceObjectAtIndex:3 withObject: oldHighTop];
            [highScoresArray replaceObjectAtIndex:5 withObject: oldHighMid];
        }
        else if ([newHigh doubleValue] <= [oldHighTop doubleValue] && [newHigh doubleValue] > [oldHighMid doubleValue]) {
            [highScoresArray replaceObjectAtIndex:3 withObject: newHigh];
            [highScoresArray replaceObjectAtIndex:5 withObject: oldHighMid];
        }
        
        else if ([newHigh doubleValue] <= [oldHighMid doubleValue] && [newHigh doubleValue] > [oldHighBot doubleValue]) {
            [highScoresArray replaceObjectAtIndex:5 withObject: newHigh];
        }
        
        //have player input their name if they get a high score
        /*[[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameOver alloc] initWithScore: scoreDisplay.totalScore]]*/
        /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"new high score!" message:@"Enter your name" delegate:self cancelButtonTitem:@"Done" otherButtonTitles:nil];
        
        UIAlertView *alert = [[UIAlertView] alloc]*/
        
        
        /*CGRect frame = CGRectMAke(10, 200, 300, 40);
        UITextField *text = [[UITextField alloc] initWithFrame:frame];
        UIView *view = [[UIView alloc] initWithFrame:frame];*/
        
        
    
        /*NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentFolder = [path objectAtIndex: 0];
        NSString *filePath = [documentFolder stringByAppendingFormat:@"HighScores.plist"];
        [highScoresArray writeToFile:filePath atomically:YES];*/
        
        NSLog(@"highScoresArray currently contains: %@", highScoresArray);
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"HighScores" ofType:@"plist"];
        
        
        bool fileExists = [[NSFileManager defaultManager]fileExistsAtPath:filePath];
        
        NSLog(@"fileExists = %d", fileExists);
        
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
        CCMenuItemImage *goToStart = [CCMenuItemImage
                                    itemWithNormalImage:@"mainmenu.png"
                                    selectedImage:@"mainmenu.png"
                                    target:self
                                    selector:@selector(jumpToMain:)];
        restart.position = ccp(0, -40);
        goToStart.position = ccp(0, -110);
        
        
        CCMenu * gameOverMenu = [CCMenu menuWithItems: restart, goToStart, nil];
        
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

- (void) jumpToMain: (id) sender
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[StartMenu alloc] init]];
}

@end
