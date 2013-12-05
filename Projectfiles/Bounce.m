#import "Bounce.h"
#import "Bird.h"
#import "Score.h"
#import "Trampoline.h"


#define TRAMPOLINEYPOS 420/8
#define PATH1 320/7
#define PATH2 320/2
#define PATH3 320/7*6
Trampoline *trampoline1;
Trampoline *trampoline2;
Trampoline *trampoline3;

NSMutableArray *birds; // list of birds
NSMutableArray *trampolines; // list of trampolines
NSMutableArray *paths; // list of paths

bool box1Touched = false;

Score *scoreDisplay;

@interface Bounce (PrivateMethods)
@end

@implementation Bounce

-(id) init
{
	if (self = [super init])
	{
        CCSprite *sprite = [CCSprite spriteWithFile:@"gamelayerbg.png"];
        sprite.anchorPoint = CGPointZero;
        [self addChild:sprite z:-1];
        
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
//        scoreDisplay.scoreSprite = [CCSprite spriteWithCGImage:scoreDisplay.scoreLabel];
        [self addChild:scoreDisplay];
        [self addChild:scoreDisplay.scoreSprite];
        
        [self scheduleUpdate];

	}

	return self;
}

- (void) update:(ccTime)dt
{
//    NSLog(@"Bird Count %d",[birds count]);
//    TODO: Consider removing birds once they leave screen
    
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
    
    /*
     Determine direction of all birds
     */
    Bird *birdPtr;
    for(int i = 0; i < [birds count]; i++)
    {
        NSInteger j = i;
        birdPtr = [birds objectAtIndex:j];
        if (birdPtr.isFalling) {
            birdPtr.position = ccp(birdPtr.position.x, birdPtr.position.y - birdPtr.fallingSpeed*dt);
        } else {
            birdPtr.position = ccp(birdPtr.position.x, birdPtr.position.y + birdPtr.fallingSpeed*dt);
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
        
        CGFloat maxDistance = (currentBird.contentSize.height + currentTrampoline.trampolineSprite.contentSize.height)/2; // minimum distance in order to bounce back up
        
        CGFloat x1 = (currentTrampoline.position.x-(currentTrampoline.trampolineSprite.contentSize.width/2));
        CGFloat x2 = (currentTrampoline.position.x+(currentTrampoline.trampolineSprite.contentSize.width/2));
        CGFloat y1 = (currentTrampoline.position.y-(currentTrampoline.trampolineSprite.contentSize.height/2));
        CGFloat y2 = (currentTrampoline.position.y+(currentTrampoline.trampolineSprite.contentSize.height/2));
        
        /*
         Touch meets criteria to change direction of current falling bird
         */
        if (x >= x1 && x <= x2 && y >= y1 && y <= y2 && distance <= maxDistance) {
            
            // change direction of current bird
            currentBird.isFalling = false;
            //[birds replaceObjectAtIndex:idx withObject:currentBird];
            
            
            // initialize new bird on a random path
            NSNumber *randomPath = [paths objectAtIndex:random()%[paths count]];
            Bird *newBird = [[Bird alloc] initWithPosition: [randomPath intValue]];
            [birds addObject:newBird];
            [self addChild:newBird z:1];
            
        }
        
       // CCLOG(@"Does it work? I think it did!");
    }
    
    
    
}

@end
