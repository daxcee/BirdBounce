//
//  PauseLayer.m
//  Bounce
//
//  Created by Linda He on 12/6/13.
//
//

#import "PauseLayer.h"

CGFloat screenWidth;
CGFloat screenHeight;

@implementation PauseLayer


- (id) initWithColor:(ccColor4B)color
{
    if ((self = [super initWithColor:color]))
    {
        
        self.isTouchEnabled=YES;
        
        CCSprite * pausebackground = [CCSprite spriteWithFile:@"pausebackground.png"];
        pausebackground.scaleX = screenWidth/pausebackground.contentSize.width;
        pausebackground.scaleY = screenHeight/pausebackground.contentSize.height;
        pausebackground.position = ccp(screenWidth/2, screenHeight/2);
        [self addChild:pausebackground];
        
    }
    return self;
}



- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for( UITouch *touch in touches )
    {
        CGPoint location = [touch locationInView: [touch view]];
        
        location = [[CCDirector sharedDirector] convertToGL: location];
        
        Bounce * gl = (Bounce *)[self.parent getChildByTag:KGameLayer];
        [gl resume];
        [self.parent removeChild:self cleanup:YES];
    }
}

- (void) dealloc
{
    [super dealloc];
}

@end
