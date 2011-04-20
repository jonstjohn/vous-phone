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

- (id) init
{
	eventId = [[NSString alloc] init];
	[super initWithNibName: @"EventViewController" bundle: nil];
	return self;	
}

- (void) viewWillAppear:(BOOL)animated
{
	[[self navigationController] setNavigationBarHidden: NO];
	
	[name setText: @""];
	[location setText: @""];
	[time setText: @""];
	[sponsor setText: @""];
	[description setText: @""];
	
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
	NSLog(@"result: %@", resultData);
	NSDictionary *eventData = [resultData objectForKey: @"result"];
	NSLog(@"eventData: %@", eventData);
	
	
	[name setText: [eventData objectForKey: @"n"]];
	[location setText: [eventData objectForKey: @"l"]];
	[time setText: [eventData objectForKey: @"t"]];
	[sponsor setText: [eventData objectForKey: @"s"]];
	[description setText: [eventData objectForKey: @"d"]];
	
	[loadingIndicator stopAnimating];
	
}


- (void)dealloc {
	[eventId release];
	[responseData release];
    [super dealloc];
}


@end
