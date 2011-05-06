//
//  HomeViewController.m
//  rendezvous
//
//  Created by Jonathan StJohn on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController

- (id) init
{
	[super initWithNibName: @"HomeViewController" bundle: nil];
	return self;
}

- (void) viewDidLoad
{
	[[self navigationItem] setTitle: @"Home"];
	[super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
	[[self navigationController] setNavigationBarHidden: YES];
	[super viewWillAppear: animated];
}

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

- (IBAction) showSchedule
{
	if (scheduleController == nil) {
		scheduleController = [[ScheduleViewController alloc] init];
	}
	[[self navigationController] pushViewController: scheduleController animated: YES];
}

- (IBAction) showSupport
{
	if (supportController == nil) {
		supportController = [[SupportViewController alloc] init];
	}
	[[self navigationController] pushViewController: supportController animated: YES];
}

- (IBAction) showSponsors
{
	if (sponsorController == nil) {
		sponsorController = [[SponsorViewController alloc] init];
	}
	[[self navigationController] pushViewController: sponsorController animated: YES];
}

- (IBAction) showRegistration
{
	if (registrationController == nil) {
		registrationController = [[RegistrationViewController alloc] init];
	}
	[[self navigationController] pushViewController: registrationController animated: YES];
}

- (IBAction) showMap
{
	/*
	if (mapController == nil) {
		mapController = [[MapViewController alloc] init];
	}
	[[self navigationController] pushViewController: mapController animated: YES];
	 */
	if (mapTabController == nil) {
		
		NSLog(@"Creating map");
		
		mapTabController = [[UITabBarController alloc] init];
		
		// Create view controllers
		UIViewController *vc1 = [[MapViewController alloc] init];
		UIViewController *vc2 = [[MapBurnwoodViewController alloc] init];
		
		
		
		// Make an array that contains the two view controllers
		NSArray *viewControllers = [NSArray arrayWithObjects: vc1, vc2, nil];
		
		// Attach to tab bar controller
		[mapTabController setViewControllers: viewControllers];
		
		[[mapTabController navigationItem] setTitle: @"Map"];
		/*
		UIBarButtonItem *iButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemRefresh target:self action:@selector(refreshWeather)];
		[[weatherTabController navigationItem] setRightBarButtonItem: iButton];
		[iButton release];
		 */
		
		[vc1 release];
		[vc2 release];
		
	}
	
	[mapTabController setSelectedIndex: 0];
	[[self navigationController] pushViewController: mapTabController animated:YES];
	
}

- (IBAction) showWeather
{
	/*
	if (weatherController == nil) {
		weatherController = [[WeatherViewController alloc] init];
	}
	[[self navigationController] pushViewController: weatherController animated: YES];
	 */
	if (weatherTabController == nil) {

		weatherTabController = [[UITabBarController alloc] init];
		
		// Create view controllers
		UIViewController *vc1 = [[WeatherViewController alloc] init];
		UIViewController *vc2 = [[WeatherHourlyViewController alloc] init];
		UIViewController *vc3 = [[WeatherAboutViewController alloc] init];
		
		// Make an array that contains the two view controllers
		NSArray *viewControllers = [NSArray arrayWithObjects: vc1, vc2, vc3, nil];
		
		// Attach to tab bar controller
		[weatherTabController setViewControllers: viewControllers];
		
		[[weatherTabController navigationItem] setTitle: @"Weather"];
		UIBarButtonItem *iButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemRefresh target:self action:@selector(refreshWeather)];
		[[weatherTabController navigationItem] setRightBarButtonItem: iButton];
		[iButton release];
		
		[vc1 release];
		[vc2 release];
		[vc3 release];
	}
	
	[weatherTabController setSelectedIndex: 0];
	[[self navigationController] pushViewController: weatherTabController animated:YES];
	
}

- (void) refreshWeather
{
	[[[weatherTabController viewControllers] objectAtIndex: [weatherTabController selectedIndex]] refreshData];
}


- (void)dealloc {
	[scheduleController release];
	[supportController release];
	[sponsorController release];
	[registrationController release];
	[mapController release];
	[weatherController release];
	[weatherTabController release];
    [super dealloc];
}


@end
