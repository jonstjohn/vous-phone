//
//  SponsorViewController.m
//  rendezvous
//
//  Created by Jonathan StJohn on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SponsorViewController.h"
#import "SponsorTableCell.h"


@implementation SponsorViewController

- (id) init
{
	// Setup sponsors array
	sponsors = [[NSMutableArray alloc] init];
	[super initWithNibName: @"SponsorViewController" bundle: nil];
	return self;
}

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section
{
	return [sponsors count];
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
	SponsorTableCell *cell = (SponsorTableCell *)[tableView dequeueReusableCellWithIdentifier: @"SponsorCell"];
	
	if (!cell) {
		cell = [[[SponsorTableCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"SponsorCell"] autorelease];
	}
	
	NSDictionary *sponsor = [sponsors objectAtIndex: [indexPath row]]; // TODO may need to release, not sure
	[[cell nameLabel] setText: [NSString stringWithFormat: @"%@", [sponsor objectForKey: @"n"]]];
	[[cell websiteLabel] setText: [NSString stringWithFormat: @"%@", [sponsor objectForKey: @"w"]]];
	[[cell logoImage] setImage: [UIImage imageNamed: [NSString stringWithFormat: @"%@", [sponsor objectForKey: @"l"]]]];
	
	[cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
	
	
	return cell;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{	
	if (detailController == nil) {
		detailController = [[SponsorDetailViewController alloc] init];
	}
	
	NSDictionary *sponsor = [sponsors objectAtIndex: [indexPath row]];
	
	[detailController setSponsorId: [NSString stringWithFormat: @"%@", [sponsor objectForKey: @"id"]]];
	[detailController setName: [NSString stringWithFormat: @"%@", [sponsor objectForKey: @"n"]]];
	[detailController setLogo: [NSString stringWithFormat: @"%@", [sponsor objectForKey: @"l"]]];
	[detailController setWebsite: [NSString stringWithFormat: @"%@", [sponsor objectForKey: @"w"]]];
	[[self navigationController] pushViewController:detailController animated: YES];
	return;
	
}

- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
	return 44.0;
}

- (void) viewDidLoad
{
	[[self navigationItem] setTitle: @"Sponsors"];
	[super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
	[[self navigationController] setNavigationBarHidden: NO];
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	NSString *lastUpdated = [prefs stringForKey: @"sponsorsUpdated"];
	NSString *currentDate = [[NSDate date] descriptionWithCalendarFormat:@"%Y-%m-%d" timeZone:nil locale:nil];
	
	// Cache data for one day
	if ([sponsors count] == 0 || ![lastUpdated isEqualToString: currentDate]) {
		
		[[self view] bringSubviewToFront: loadingIndicator];
		[loadingIndicator startAnimating];
		responseData = [[NSMutableData data] retain];

		NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: @"http://www.newriverclimbing.net/vous_sponsor.php"]];
		[[NSURLConnection alloc] initWithRequest:request delegate:self];
		
	}
	
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
	
	[responseData release];
	NSDictionary *resultData = [responseString JSONValue];
	NSArray *sponsorData = [resultData objectForKey: @"result"];
	
	
	[sponsors removeAllObjects];
	for (int i = 0; i < [sponsorData count]; i++) {
		
		[sponsors addObject: [sponsorData objectAtIndex: i]];
		
	}
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *currentDate = [[NSDate date] descriptionWithCalendarFormat:@"%Y-%m-%d" timeZone:nil locale:nil];
	[prefs setObject: currentDate forKey: @"sponsorsUpdated"];
	
	
	//[responseString release];
	[loadingIndicator stopAnimating];
	[sponsorTable reloadData];
	
}


- (void)dealloc {
	[sponsors release];
	[detailController release];
    [super dealloc];
}


@end
