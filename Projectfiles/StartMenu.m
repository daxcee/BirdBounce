#import "StartMenu.h"
#import "Bounce.h"

CGFloat screenWidth;
CGFloat screenHeight;
id fadeIn;
id fadeOut;

@implementation StartMenu

-(id) init
{
    if ((self = [super init]))
	{
		CCLOG(@"%@ init", NSStringFromClass([self class]));
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        screenWidth = screenRect.size.width;
        screenHeight = screenRect.size.height;
        
        
        CCSprite *background = [CCSprite spriteWithFile:@"startmenu2.png"];
        /*background.position = ccp(background.contentSize.width/2, background.contentSize.height/2);*/
        background.scaleX = screenWidth/background.contentSize.width;
        background.scaleY = screenHeight/background.contentSize.height;
        background.position = ccp(screenWidth/2, screenHeight/2);
        [self addChild: background];
        [self setUpStartMenu];
        
        fadeIn = [CCFadeIn actionWithDuration:0.5];
        fadeOut = [CCFadeOut actionWithDuration: 0.5];
        
    }
    return self;
}

-(void) setUpStartMenu

{
    
    CCSprite * startbutt = [CCSprite spriteWithFile:@"startbutton.png"];
    CCSprite * instrubutt = [CCSprite spriteWithFile:@"instructionbutton.png"];
    startbutt.scale = 2;
    instrubutt.scale = 2;
    CCMenuItemImage * startButton = [CCMenuItemImage itemWithNormalImage:@"startbutton.png"
                                                           selectedImage:@"startbutton.png"
                                                                  target:self 
                                                                selector:@selector(launchGame:)];
    
    CCMenuItemImage * instructionButton = [CCMenuItemImage itemWithNormalImage:@"instructionbutton.png"
                                                                 selectedImage:@"instructionbutton.png"
                                                                        target: self
                                                                      selector:@selector(launchInstructionOne:)];
    /*CCMenuItemImage * restartButton = [CCMenuItemImage itemWithNormalImage:@"restart.png"
                                                                 selectedImage:@"restart.png"
                                                                        target: self
                                                                      selector:@selector(launchInstructionOne:)];*/
    
    CCMenu *menu = [CCMenu menuWithItems: startButton, instructionButton, nil];
    menu.position = ccp(320/2, 260-(startButton.contentSize.height/2));
    instructionButton.position = ccp(0, -screenHeight/6);
    CCLOG(@"contentSize of StartButton = %f", menu.contentSize.width);
    [self addChild: menu];
}

-(void) launchGame: (CCMenuItem *) startButton
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[Bounce alloc] init]];
    
}

-(void) launchInstructionOne: (CCMenuItem *) instructionButton
{
    CCSprite * instructionOne = [CCSprite spriteWithFile:@"instructionone.png"];
    instructionOne.scaleX = screenWidth/instructionOne.contentSize.width;
    instructionOne.scaleY = screenHeight/instructionOne.contentSize.height;
    instructionOne.position = ccp(screenWidth/2, screenHeight/2);
    
    instructionOne.opacity = 0;
    
    CCMenuItemImage * next = [CCMenuItemImage itemWithNormalImage:@"next.png"
                                                    selectedImage:@"next-hi.png"
                                                           target: self
                                                         selector:@selector(launchInstructionTwo:)];
    
    CCMenu * nextMenu = [CCMenu menuWithItems: next, nil];
    nextMenu.position = ccp(320/2, 480/12);
    [self addChild: instructionOne z:0];
    [self addChild: nextMenu z:0];
    
    [instructionOne runAction: fadeIn];
}

-(void) launchInstructionTwo: (CCMenuItem *) next
{
    CCSprite * instructionTwo = [CCSprite spriteWithFile:@"instructiontwo.png"];
    instructionTwo.scaleX = screenWidth/instructionTwo.contentSize.width;
    instructionTwo.scaleY = screenHeight/instructionTwo.contentSize.height;
    instructionTwo.position = ccp(screenWidth/2, screenHeight/2);
    
    instructionTwo.opacity = 0;
    
    CCMenuItemImage * nextTwo = [CCMenuItemImage itemWithNormalImage:@"next.png"
                                                    selectedImage:@"next-hi.png"
                                                           target: self
                                                         selector:@selector(launchInstructionThree:)];
    
    CCMenu * nextMenu = [CCMenu menuWithItems: nextTwo, nil];
    nextMenu.position = ccp(320/2, 480/12);
    [self addChild: instructionTwo z:0];
    
    [self addChild: nextMenu z:0];
    [instructionTwo runAction:fadeIn];
}

-(void) launchInstructionThree: (CCMenuItem *) nextTwo
{
    CCSprite * instructionThree = [CCSprite spriteWithFile:@"instructionthree.png"];
    instructionThree.scaleX = screenWidth/instructionThree.contentSize.width;
    instructionThree.scaleY = screenHeight/instructionThree.contentSize.height;
    instructionThree.position = ccp(screenWidth/2, screenHeight/2);
    
    instructionThree.opacity = 0;
    
    CCMenuItemImage * startGame = [CCMenuItemImage itemWithNormalImage:@"startinstrButton.png"
                                                         selectedImage:@"startinstrButton.png"
                                                                target: self
                                                              selector:@selector(launchGame:)];
    
    CCMenu * nextMenu = [CCMenu menuWithItems: startGame, nil];
    nextMenu.position = ccp(320/2, 480/12);
    [self addChild: instructionThree z:0];
    [self addChild: nextMenu z:0];
    
    [instructionThree runAction:fadeIn];
    
}


@end
