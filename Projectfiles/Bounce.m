#import "Bounce.h"
#import "Bird.h"
#import "Score.h"
#import "Trampoline.h"
#import "Pause.h"
#import "Lives.h"
#import "GameOver.h"
#import "SimpleAudioEngine.h"s


#define TRAMPOLINEYPOS 420/8
#define PATH1 320/7
#define PATH2 320/2
#define PATH3 320/7*6
#define GAMEOVER 3
#define KGameLayer 1
Trampoline *trampoline1;
Trampoline *trampoline2;
Trampoline *trampoline3;


NSMutableArray *birds; // list of birds
NSMutableArray *trampolines; // list of trampolines
NSMutableArray *paths; // list of paths

/*int currentStreak;*/
float speedIncrement = 15;

bool initializeBird = false;

Score *scoreDisplay;
Lives *livesDisplay;

@interface Bounce (PrivateMethods)

@end

@implementation Bounce
{
    int currentStreak;
    float currentAccel;
    float initialSpeed;
    float currentSpeed;
    float scoreBasedOnSpeedIncrement;
}


-(id) init
{
	if (self = [super init])
	{
        
        //set up bird chirping noise
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"bird_chirp.mp3"];
        [SimpleAudioEngine sharedEngine].effectsVolume = 0.05;
        
        //set up currentStreak (== 0) and currentAccel (==9.8)
        currentStreak = 0;
        currentAccel = 9.8;
        initialSpeed = 200;
        currentSpeed = initialSpeed;
        scoreBasedOnSpeedIncrement = currentSpeed;
        
        CCSprite *sprite = [CCSprite spriteWithFile:@"gamelayerbg.png"];
        /*sprite.opacity = 0;*/
        sprite.anchorPoint = CGPointZero;
        [self addChild:sprite z:-1];
        /*[sprite runAction: [CCFadeIn actionWithDuration:0.5]];*/
        
        
        birds = [[NSMutableArray alloc] init]; // list of birds
        trampolines = [[NSMutableArray alloc] init]; // list of trampolines
        paths = [[NSMutableArray alloc] init]; // list of paths
        [paths addObject:[NSNumber numberWithInteger:PATH1]];
        [paths addObject:[NSNumber numberWithInteger:PATH2]];
        [paths addObject:[NSNumber numberWithInteger:PATH3]];
        
        // Initialize red bird (left)
        trampoline1 = [[Trampoline alloc] initWithPosition: PATH1];
        trampoline1.trampolineSprite = [CCSprite spriteWithFile:@"redbouncer.png"];
        [trampoline1 addChild:trampoline1.trampolineSprite];
        [trampolines addObject:trampoline1];
        [self addChild:trampoline1 z:1];
        
        // Initialize green bird (center)
        trampoline2 = [[Trampoline alloc] initWithPosition: PATH2];
        trampoline2.trampolineSprite = [CCSprite spriteWithFile:@"greenbouncer.png"];
        [trampoline2 addChild:trampoline2.trampolineSprite];
        [trampolines addObject:trampoline2];
        [self addChild:trampoline2 z:1];
        
        // Initialize blue bird (center)
        trampoline3 = [[Trampoline alloc] initWithPosition: PATH3];
        trampoline3.trampolineSprite = [CCSprite spriteWithFile:@"bluebouncer.png"];
        [trampoline3 addChild:trampoline3.trampolineSprite];
        [trampolines addObject:trampoline3];
        [self addChild:trampoline3 z:1];
        
        // Initialize first bird
        Bird *firstBird = [[Bird alloc] initWithPosition: PATH1];
        [birds addObject:firstBird];
        [self addChild:firstBird z:1];
        
        // Initialize score
        scoreDisplay = [[Score alloc] init];
        //scoreDisplay.scoreSprite = [CCSprite spriteWithSpriteFrame : scoreDisplay.scoreLabel.displayFrame];
        [self addChild:scoreDisplay];
        //[self addChild:scoreDisplay.scoreSprite];
        
        //Initialize lives
        livesDisplay = [[Lives alloc] init];
        [self addChild: livesDisplay];
        
        [self scheduleUpdate];
        [self setUpPauseButton];

	}

	return self;
}

-(void) setUpPauseButton
{
 
 
    CCMenuItemImage * pauseButton = [CCMenuItemImage itemWithNormalImage:@"pauseButton.png"
                                                           selectedImage:@"pauseButton.png"
                                                                  target:self
                                                                selector:@selector(pauseGame:)];
    
    CCMenu *pauseButtonMenu = [CCMenu menuWithItems: pauseButton, nil];
    pauseButtonMenu.position = ccp(20, 480 - 20);
    [self addChild: pauseButtonMenu];
}

-(void) pauseGame: (CCMenuItem *) startButton
{
    [[CCDirector sharedDirector] pushScene: (CCScene*)[[Pause alloc] init]];
}



- (void) update:(ccTime)dt
{
//    NSLog(@"Bird Count %d",[birds count]);
//    TODO: Consider removing birds once they leave screen
    
    if ([birds count] == 0) {
        [self makeBird];
    }
    
    /*
     Get reference to most current falling bird
     */
    NSInteger idx = [birds count]-1;
    Bird *currentBird = [birds objectAtIndex:idx];
    
    /*
     Get reference to relevant trampoline
    */
    Trampoline *currentTrampoline;
    if (currentBird.position.x == trampoline1.position.x) {
        currentTrampoline = trampoline1;
    } else if (currentBird.position.x == trampoline2.position.x) {
        currentTrampoline = trampoline2;
    } else {
        currentTrampoline = trampoline3;
    }
    
    
    Bird *birdPtr;
    for(int i = 0; i < [birds count]; i++)
    {
        NSInteger j = i;
        birdPtr = [birds objectAtIndex:j];
        
        if (birdPtr.isFalling) {
            birdPtr.position = ccp(birdPtr.position.x, birdPtr.position.y - currentSpeed*dt);
        } else {
            birdPtr.position = ccp(birdPtr.position.x, birdPtr.position.y + currentSpeed*dt);
        }
        
    }
    
    
    /*
     Touch happenned so check if most current falling bird will change direction
     */
    KKInput* input = [KKInput sharedInput];
    CGPoint pos = [input locationOfAnyTouchInPhase:KKTouchPhaseBegan];
    
    if (input.anyTouchBeganThisFrame) {
        //get x and y coordinates for mouse
        int x = pos.x;
        int y = pos.y;
        CGFloat distance = abs(currentBird.position.y-currentTrampoline.trampolineSprite.position.y); // get distance between bird and trampoline
        
        CGFloat maxDistance = (currentBird.contentSize.height + currentTrampoline.trampolineSprite.contentSize.height)+20;
        /*CGFloat maxDistance = (currentBird.contentSize.height + currentTrampoline.trampolineSprite.contentSize.height)/2; // minimum distance in order to bounce back up*/
        
        CGFloat x1 = (currentTrampoline.position.x-(currentTrampoline.trampolineSprite.contentSize.width/2));
        CGFloat x2 = (currentTrampoline.position.x+(currentTrampoline.trampolineSprite.contentSize.width/2));
        /*this is the original
        CGFloat y1 = (currentTrampoline.position.y-(currentTrampoline.trampolineSprite.contentSize.height/2));
        CGFloat y2 = (currentTrampoline.position.y+(currentTrampoline.trampolineSprite.contentSize.height/2));*/
        
        CGFloat y1 = (currentTrampoline.position.y-(currentTrampoline.trampolineSprite.contentSize.height/2));
        CGFloat y2 = (currentTrampoline.position.y+(currentTrampoline.trampolineSprite.contentSize.height/1.3));
        
        /*
         Touch meets criteria to change direction of current falling bird
         */
        if (x >= x1 && x <= x2 && y >= y1 && y <= y2 && distance <= maxDistance) {
            
            //NSLog(@"Bird Pos %f",currentBird.position.y);
            
            // change direction of current bird
            currentBird.isFalling = false;
            //[birds replaceObjectAtIndex:idx withObject:currentBird];
            
            /*[currentBird setTexture: [[CCSprite spriteWithFile:@"upbird.png"] texture]];*/
            CCTexture2D* birdIsNowFlyingImg = [[CCTextureCache sharedTextureCache] addImage: @"upbird.png"];
            [currentBird.birdSprite setTexture: birdIsNowFlyingImg];
            
            
            // initialize new bird on a random path
            [self makeBird];
            
            
            // update score
            [self removeChild:scoreDisplay];
            /*scoreBasedOnSpeedIncrement = currentSpeed;*/
            float scoreIncrement = ((scoreBasedOnSpeedIncrement)/(speedIncrement*3) + 1);
            CCLOG(@"scoreIncrement %f", scoreIncrement);
            scoreDisplay = [[Score alloc] initWithScore:scoreDisplay.totalScore+scoreIncrement];
            [self addChild:scoreDisplay];
            
            // increment currentStreak
            if (currentStreak < scoreDisplay.totalScore) {
                currentStreak++;
            }
            CCLOG(@"currentStreak updated to %d", currentStreak);

            
            currentAccel += 1.0;
            CCLOG(@"currentAccel of current bird: %f", currentAccel);
            
            //play sound
            [[SimpleAudioEngine sharedEngine] playEffect: @"bird_chirp.mp3"];
            
        }
        
        //NSLog(@"Bird Pos %f",currentBird.position.y);
        //CCLOG(@"Does it work? I think it did!");
    }
    
    /*
     Initialize new bird if no birds on screen
     */
    if (currentBird.isFalling && currentBird.position.y < (currentTrampoline.position.y-(currentTrampoline.trampolineSprite.contentSize.height/2)) /*currentBird.position.y < 420/25*/) {
            [self makeBird];
    
    /*
     Lose a life if a bird falls past this point
     */
            
        // update lives
        [self removeChild:livesDisplay];
        livesDisplay = [[Lives alloc] initWithLives:livesDisplay.totalLives-1];
        [self addChild:livesDisplay];

        // if lives = 0, then jump to Game Over screen
        if (livesDisplay.totalLives == 0) {
            [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameOver alloc] initWithScore: scoreDisplay.totalScore]];
        }
        
        //if we lose a life, gaining we half what points we can earn from the next bounce
        scoreBasedOnSpeedIncrement = scoreBasedOnSpeedIncrement / 2;
    
        //set currentStreak = 0;
        currentStreak = 0;
//        currentAccel = 9.8;
//        currentSpeed = 200 + scoreDisplay.totalScore/(currentStreak+1);
        CCLOG(@"reset currentStreak and currentAccel");
    }


    
}

/*
 Initialize new bird on a random path
 */
- (void) makeBird
{
    // update the falling speed in proportion to the currentStreak
    if (currentStreak != 0 && (currentStreak%2) == 0) {
        CCLOG(@"currentSpeed %f", currentSpeed);
        currentSpeed = currentSpeed + speedIncrement;
        scoreBasedOnSpeedIncrement = scoreBasedOnSpeedIncrement + speedIncrement;
    }
    
    NSNumber *randomPath = [paths objectAtIndex:random()%[paths count]];
    Bird *newBird = [[Bird alloc] initWithPosition: [randomPath intValue]];
    [birds addObject:newBird];
    [self addChild:newBird z:1];
    
}

@end
