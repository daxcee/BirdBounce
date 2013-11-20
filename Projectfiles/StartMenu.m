//
//  StartMenu.m
//  Bounce
//
//  Created by Linda He on 11/20/13.
//
//

#import "StartMenu.h"
#import "Bounce.h"

@implementation StartMenu

-(id) init
{
    if ((self = [super init]))
	{
		CCLOG(@"%@ init", NSStringFromClass([self class]));
        CCSprite *background = [CCSprite spriteWithFile:@"startmenu2.png"];
        background.position = ccp(background.contentSize.width/2, background.contentSize.height/2);
        [self addChild: background];
        [self setUpMenus];
    }
    return self;
}

-(void) setUpMenus
{
    CCMenuItemImage * startButton = [CCMenuItemImage itemWithNormalImage:@"startbutton.png"
                                                           selectedImage:@"startbutton.png"
                                                                  target:self 
                                                                selector:@selector(launchGame:)];
   /* CCMenuItemImage * instructionButton = [CCMenuItemImage itemWithNormalImage:@"instructionbutton.png"
                                                                 selectedImage:@"instructionbutton.png"
                                                                        target: self];
                                                                      selector:(launchInstructions:)];
    */
    
    CCMenu *menu = [CCMenu menuWithItems: startButton, nil];
    menu.position = ccp(320/2, 250-(startButton.contentSize.height/2));
    CCLOG(@"contentSize of StartButton = %f", menu.contentSize.width);
    [self addChild: menu];
}

-(void) launchGame: (CCMenuItem *) startButton
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[Bounce alloc] init]];
    
}

-(void) launchInstructions: (CCMenuItem *) startButton
{
    //[[CCDirector sharedDirector] replaceScene: (CCScene*)[[Bounce alloc] init]];
    
}


@end
