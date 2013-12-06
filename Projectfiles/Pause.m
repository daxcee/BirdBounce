//
//  Pause.m
//  Bounce
//
//  Created by Linda He on 12/5/13.
//
//

#import "Pause.h"
#import "StartMenu.h"
#import "Bounce.h"

CGFloat screenWidth;
CGFloat screenHeight;

@implementation Pause



+ (id) Pausescene
{
    CCScene *scene = [CCScene node];
    
    
    Pause *layer = [Pause node];
    
    
    [scene addChild: layer];
    
    
    return scene;
}

-(id)init
{
    if( (self=[super init]))
    {
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        screenWidth = screenRect.size.width;
        screenHeight = screenRect.size.height;
        
        CCSprite *pauseBackground = [CCSprite spriteWithFile:@"pausebackground.png"];
        pauseBackground.scaleX = screenWidth/pauseBackground.contentSize.width;
        pauseBackground.scaleY = screenHeight/pauseBackground.contentSize.height;
        pauseBackground.position = ccp(screenWidth/2, screenHeight/2);
        [self addChild: pauseBackground];
        
        
        CCMenuItemImage *resumeGame = [CCMenuItemImage
                                      itemWithNormalImage:@"resume.png"
                                      selectedImage:@"resume.png"
                                    target:self
                                    selector:@selector(resumeGame:)];
        CCMenuItemImage *restart = [CCMenuItemImage
                                    itemWithNormalImage:@"restart.png"
                                    selectedImage:@"restart.png"
                                    target:self
                                    selector:@selector(reStart:)];
        restart.position = ccp(0, -75);
        
        
        CCMenu * pauseMenu = [CCMenu menuWithItems: resumeGame, restart, nil];

        [self addChild: pauseMenu];
        
        
        
        // position your pause menu in the center of your layer
        pauseMenu.position = ccp(screenWidth/2, screenHeight/2);
        
        
        
        
        
    }
    return self;
}

- (void) reStart: (id) sender
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[Bounce alloc] init]];
}

- (void) resumeGame: (id) sender
{
    [[CCDirector sharedDirector] popScene];
}

@end
