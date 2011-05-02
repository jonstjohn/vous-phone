//
//  rendezvousAppDelegate.m
//  rendezvous
//
//  Created by Jonathan StJohn on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "rendezvousAppDelegate.h"
#import "HomeViewController.h"


@implementation rendezvousAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
	// Setup navigation controller
	UIViewController *homeController = [[HomeViewController alloc] init];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: homeController];
	//[[navController navigationBar] setTintColor: [UIColor colorWithRed: 0.98 green: 0.89 blue: 0.17 alpha: 1.0]];
	[[navController navigationBar] setTintColor: [UIColor blueColor]];
	[[navController navigationBar] setTintColor: [UIColor colorWithRed: 0.0 green: 0.20 blue: 0.40 alpha: 1.0]];
	[navController setNavigationBarHidden: YES];
	//[navController navigationBar] but
	
	NSString *reqSysVer = @"4.0";
	NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
	if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending) {
		[window setRootViewController: navController];
	} else {
		[window addSubview:[navController view]]; // make compatible with 3.x
	}
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {

    [window release];
    [super dealloc];
}


@end

