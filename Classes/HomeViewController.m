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
	if (mapController == nil) {
		mapController = [[MapViewController alloc] init];
	}
	[[self navigationController] pushViewController: mapController animated: YES];
}

- (IBAction) showWeather
{
	if (weatherController == nil) {
		weatherController = [[WeatherViewController alloc] init];
	}
	[[self navigationController] pushViewController: weatherController animated: YES];
}

- (void)dealloc {
	[scheduleController release];
	[supportController release];
	[sponsorController release];
	[registrationController release];
	[mapController release];
	[weatherController release];
    [super dealloc];
}


@end
