#import "Bounce.h"


CCSprite *ball1;
CCSprite *box1;
CCSprite *box2;
CCSprite *box3;
bool box1Touched = false;

@interface Bounce (PrivateMethods)
@end

@implementation Bounce

-(id) init
{
	if ((self = [super init]))
	{
        CCSprite *sprite = [CCSprite spriteWithFile:@"background.png"];
        sprite.anchorPoint = CGPointZero;
        [self addChild:sprite z:-1];
        
        // Add ball 1 to screen
        ball1 = [CCSprite spriteWithFile:@"redball.png"];
        ball1.position = ccp(320/7, 420);
        [self addChild:ball1];
        
        // Initialize box 1
        box1 = [CCSprite spriteWithFile:@"box1.png"];
        box1.position = ccp(320/7, 420/8);
        [self addChild:box1];
        
        // Initialize box 2
        box2 = [CCSprite spriteWithFile:@"box1.png"];
        box2.position = ccp(320/2, 420/8);
        [self addChild:box2];
        
        // Initialize box 3
        box3 = [CCSprite spriteWithFile:@"box1.png"];
        box3.position = ccp(320/7*6, 420/8);
        [self addChild:box3];
        
        [self scheduleUpdate];

	}

	return self;
}

- (void) update:(ccTime)dt
{
    
//    //move the ship only in the x direction by a fixed amount every frame
//    ship1.position = ccp( ship1.position.x + 100*dt, ship1.position.y );
//    
//    if (ship1.position.x > 480+32)
//    {
//        //if the ship reaches the edge of the screen, loop around
//        ship1.position = ccp( -32, ship1.position.y );
//        
//
    

    if (!box1Touched) {
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
        CGFloat distance = abs(ball1.position.y-box1.position.y); // get distance between ball 1 and box 1
        
        CGFloat maxDistance = (ball1.contentSize.height + box1.contentSize.height)/2; // minimum distance in order to bounce back up
        
        CGFloat x1 = (box1.position.x-(box1.contentSize.width/2));
        CGFloat x2 = (box1.position.x+(box1.contentSize.width/2));
        CGFloat y1 = (box1.position.y-(box1.contentSize.height/2));
        CGFloat y2 = (box1.position.y+(box1.contentSize.height/2));
        
        if (x >= x1 && x <= x2 && y >= y1 && y <= y2 && distance <= maxDistance) {
            box1Touched = true;
        }
        
        CCLOG(@"Ball has been touched");
    }
    
}

@end
