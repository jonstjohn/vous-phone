//
//  WeatherAboutViewController.m
//  rendezvous
//
//  Created by Jonathan StJohn on 5/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WeatherAboutViewController.h"


@implementation WeatherAboutViewController

- (id) init
{	
	// Setup tab bar item
	UITabBarItem *tbi = [self tabBarItem];
	[tbi setTitle: @"About"];
	
	// Add image
	UIImage *i = [UIImage imageNamed:@"icon_information.png"];
	[tbi setImage: i];
	
	return self;
}
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) refreshData
{
	// do nothing
}

- (IBAction)appStoreLink {
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/climbing-weather/id432020810?mt=8"]];
	
}


- (void)dealloc {
    [super dealloc];
}


@end
