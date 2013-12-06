#import "AppDelegate.h"
#import "Pause.h"

@implementation AppDelegate

-(void) initializationComplete
{
#ifdef KK_ARC_ENABLED
	CCLOG(@"ARC is enabled");
#else
	CCLOG(@"ARC is either not available or not enabled");
#endif
}

/*-(void) applicationWillResignActive:(UIApplication *)application
{
    [[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[CCDirector sharedDirector] resume];
}*/

-(void) applicationWillResignActiveNotification: (UIApplication*) application
{
    [[CCDirector sharedDirector] pushScene: (CCScene*)[[Pause alloc] init]];
}

-(id) alternateView
{
	return nil;
}

@end
