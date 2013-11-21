#import "Bounce.h"
#import "Bird.h"



#define TRAMPOLINEYPOS 420/8
#define PATH1 320/7
#define PATH2 320/2
#define PATH3 320/7*6
//CCSprite *ball1;
CCSprite *bird1;
CCSprite *bird2;
CCSprite *bird3;

bool box1Touched = false;

@interface Bounce (PrivateMethods)
@end

@implementation Bounce

-(id) init
{
	if ((self = [super init]))
	{
        CCSprite *sprite = [CCSprite spriteWithFile:@"gamelayerbg.png"];
        sprite.anchorPoint = CGPointZero;
        [self addChild:sprite z:-1];
        
        /*// Add ball 1 to screen
        ball1 = [CCSprite spriteWithFile:@"upbird.png"];
        ball1.position = ccp(320/7, 420);
        [self addChild:ball1 z:2];*/
        
        // Initialize red bird (left)
        bird1 = [CCSprite spriteWithFile:@"redbouncer.png"];
        bird1.position = ccp(TRAMPOLINEYPOS, PATH1);
        [self addChild:bird1 z:1];
        
        // Initialize green bird (center)
        bird2 = [CCSprite spriteWithFile:@"greenbouncer.png"];
        bird2.position = ccp(TRAMPOLINEYPOS, PATH2);
        [self addChild:bird2 z:1];
        
        // Initialize blue bird (center)
        bird3 = [CCSprite spriteWithFile:@"bluebouncer.png"];
        bird3.position = ccp(TRAMPOLINEYPOS, PATH3);
        [self addChild:bird3 z:1];
        
        [self scheduleUpdate];

	}

	return self;
}

- (void) update:(ccTime)dt
{
    Bird *firstBird = [[Bird alloc] initWithPosition PATH1];
    
    
//    //move the ship only in the x direction by a fixed amount every frame
//    ship1.position = ccp( ship1.position.x + 100*dt, ship1.position.y );
//    
//    if (ship1.position.x > 480+32)
//    {
//        //if the ship reaches the edge of the screen, loop around
//        ship1.position = ccp( -32, ship1.position.y );
//        
//
    

/*    if (!box1Touched) {
        ball1.position = ccp(ball1.position.x, ball1.position.y - 200*dt);
    } else if (box1Touched) {
        ball1.position = ccp(ball1.position.x, ball1.position.y + 200*dt);
    }
    
    
    KKInput* input = [KKInput sharedInput];
    CGPoint pos = [input locationOfAnyTouchInPhase:KKTouchPhaseBegan];
    
    
    if (input.anyTouchBeganThisFrame) {
        //get x and y coordinates for mouse
        int x = pos.x;
        int y = pos.y;
        CGFloat distance = abs(ball1.position.y-bird1.position.y); // get distance between ball 1 and box 1
        
        CGFloat maxDistance = (ball1.contentSize.height + bird1.contentSize.height)/2; // minimum distance in order to bounce back up
        
        CGFloat x1 = (bird1.position.x-(bird1.contentSize.width/2));
        CGFloat x2 = (bird1.position.x+(bird1.contentSize.width/2));
        CGFloat y1 = (bird1.position.y-(bird1.contentSize.height/2));
        CGFloat y2 = (bird1.position.y+(bird1.contentSize.height/2));
        
        if (x >= x1 && x <= x2 && y >= y1 && y <= y2 && distance <= maxDistance) {
            box1Touched = true;
        }
        
        CCLOG(@"Does it work? I think it did!");
    }
    */
    
    
}

@end
