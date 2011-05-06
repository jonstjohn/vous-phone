//
//  ScheduleViewController.m
//  rendezvous
//
//  Created by Jonathan StJohn on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScheduleViewController.h"
#import "EventTableCell.h"


@implementation ScheduleViewController

- (id) init
{
	events = [[NSMutableArray alloc] init];
	// Initialize request url
	requestUrl = [[NSString alloc] initWithFormat: @"http://newriverclimbing.net/vous_event.php", 
				  [[UIDevice currentDevice] uniqueIdentifier]];
	[super initWithNibName: @"ScheduleViewController" bundle: nil];
	return self;
}

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section
{
	if ([events count] == 0) {
		return 0;
	}

	return [[[events objectAtIndex: section] objectForKey: @"e"] count];
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
	/*
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"EventCell"];
	
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: @"EventCell"];
	}
	 */
	
	EventTableCell *cell = (EventTableCell *)[tableView dequeueReusableCellWithIdentifier: @"EventCell"];
	
	if (!cell) {
		cell = [[[EventTableCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"EventCell"] autorelease];
	}
	
	NSDictionary *event = [[[events objectAtIndex: [indexPath section]] objectForKey: @"e"] objectAtIndex: [indexPath row]];
	[[cell nameLabel] setText: [NSString stringWithFormat: @"%@", [event objectForKey: @"n"]]];
	[[cell timeLabel] setText: [NSString stringWithFormat: @"%@", [event objectForKey: @"t"]]];
	
	[cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
	
	return cell;
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *) tableView
{
	return [events count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	return [[events objectAtIndex: section] objectForKey: @"n"];
	
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{	
	if (eventController == nil) {
		eventController = [[EventViewController alloc] init];
	}
	NSDictionary *event = [[[events objectAtIndex: [indexPath section]] objectForKey: @"e"] objectAtIndex: [indexPath row]];
	[eventController setEventId: [event objectForKey: @"id"]];
	[eventController setNameStr: [event objectForKey: @"n"]];
	//[eventController setSponsorStr: [event objectForKey: @"s"]];
	[eventController setLocationStr: [NSString stringWithFormat: @"%@ @ %@", [event objectForKey: @"t"], [event objectForKey: @"l"]]];
	[[self navigationController] pushViewController:eventController animated: YES];
	return;
	
}
	
- (void) viewDidLoad
{
	[[self navigationItem] setTitle: @"Schedule"];
	
    //UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    //[infoButton addTarget:self action:@selector(toggleInfo:) forControlEvents:UIControlEventTouchUpInside];
    //UIBarButtonItem *iButton = [[UIBarButtonItem alloc] initWithCustomView: infoButton];
	UIBarButtonItem *iButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemRefresh target:self action:@selector(refreshData)];
    [[self navigationItem] setRightBarButtonItem: iButton];
    [iButton release];
	
	[super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
	//[[self tabBarController] setTitle: @"US States"];
	[[self navigationController] setNavigationBarHidden: NO];
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	NSString *lastUpdated = [prefs stringForKey: @"scheduledUpdated"];
	NSString *currentDate = [[NSDate date] descriptionWithCalendarFormat:@"%Y-%m-%d" timeZone:nil locale:nil];

	// Cache data for one day
	if ([events count] == 0 || ![lastUpdated isEqualToString: currentDate]) {
	
		[self refreshData];
	
	}
	[super viewWillAppear: animated];
}

- (void) refreshData
{
	[eventTable setHidden: YES];
	[[self view] bringSubviewToFront: loadingIndicator];
	[loadingIndicator startAnimating];
	responseData = [[NSMutableData data] retain];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: requestUrl]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];	
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

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Connection failed: %@", [error description]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	
	[connection release];
	
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	// Cache data, expire after 24 hours
	//Cache *sharedCache = [Cache sharedCache];
	//[sharedCache set: requestUrl withValue: responseString expiresOn: [[NSDate date] timeIntervalSince1970] + 60*60*24];
	
	[responseData release];
	
	NSDictionary *resultData = [responseString JSONValue];
	NSArray *eventData = [resultData objectForKey: @"result"];
	
	
	//NSLog(@"Event data: %@", eventData);
	
	[events removeAllObjects];
	for (int i = 0; i < [eventData count]; i++) {
		
		[events addObject: [eventData objectAtIndex: i]];
		
	}
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *currentDate = [[NSDate date] descriptionWithCalendarFormat:@"%Y-%m-%d" timeZone:nil locale:nil];
	[prefs setObject: currentDate forKey: @"scheduledUpdated"];
	
	[loadingIndicator stopAnimating];
	[eventTable setHidden: NO];
	[eventTable reloadData];
	
}


- (void)dealloc {
	[events release];
	[eventController release];
    [super dealloc];
}


@end
