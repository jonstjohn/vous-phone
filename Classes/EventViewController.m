//
//  EventViewController.m
//  rendezvous
//
//  Created by Jonathan StJohn on 4/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventViewController.h"


@implementation EventViewController

@synthesize eventId;
@synthesize nameStr;
@synthesize sponsorStr;
@synthesize locationStr;

- (id) init
{
	eventId = [[NSString alloc] init];
	[super initWithNibName: @"EventViewController" bundle: nil];
	return self;	
}

- (void) viewWillAppear:(BOOL)animated
{
	[[self navigationController] setNavigationBarHidden: NO];
	
	// Populate view with controller properties
	CGRect nameFrame = [name frame];
	nameFrame.size.width = 280.0;
	[name setFrame: nameFrame];
	[name setText: nameStr];
	[name sizeToFit]; // adjust view to fit
	
	[self adjustLayout]; // adjust layout to account for differently size name
	
	
	[location setText: locationStr];
	[sponsor setText: sponsorStr];
	[description setText: @"Loading ..."]; // display loading text
	
	[description setContentInset: UIEdgeInsetsMake(-8,-8,0,0)];
	
	[[self view] bringSubviewToFront: loadingIndicator];
	[loadingIndicator startAnimating];
	responseData = [[NSMutableData data] retain];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: 
														  [NSString stringWithFormat: @"http://www.newriverclimbing.net/vous_event.php?id=%@",
															eventId]
														  ]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
		
	[super viewWillAppear: animated];
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
	NSDictionary *eventData = [resultData objectForKey: @"result"];
	
	//[name setText: [eventData objectForKey: @"n"]];
	//[name sizeToFit];
	//[location setText: [NSString stringWithFormat: @"%@ @ %@", [eventData objectForKey: @"t"], [eventData objectForKey: @"l"]]];
	//[sponsor setText: [eventData objectForKey: @"s"]];
	[description setText: [eventData objectForKey: @"d"]];
	
	[loadingIndicator stopAnimating];
	
}

- (void) adjustLayout
{
	// Get name frame
	//[name sizeToFit];
	CGRect nameFrame = [name frame];
	//nameFrame.size.height = imgSize.height;
	
	// Adjust position of Location frame
	CGRect locationFrame = [location frame];
	locationFrame.origin.y = nameFrame.origin.y + nameFrame.size.height + 5.0;
	[location setFrame: locationFrame];
	
	// Adjust position of Sponsor frame
	/*
	CGRect sponsorFrame = [sponsor frame];
	sponsorFrame.origin.y = locationFrame.origin.y + locationFrame.size.height + 10.0;
	[sponsor setFrame: sponsorFrame];
	 */
	
	// Adjust size and position of description frame
	CGRect viewFrame = [[self view] frame];
	CGRect descriptionFrame = [description frame];
	descriptionFrame.origin.y = locationFrame.origin.y + locationFrame.size.height + 10.0;
	descriptionFrame.size.height = viewFrame.size.height - descriptionFrame.origin.y - 10.0;
	[description setFrame: descriptionFrame];
}


- (void)dealloc {
	[eventId release];
	[nameStr release];
	[sponsorStr release];
	[locationStr release];
	[responseData release];
    [super dealloc];
}


@end
