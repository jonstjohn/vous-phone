//
//  SponsorDetailViewController.m
//  rendezvous
//
//  Created by Jonathan StJohn on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SponsorDetailViewController.h"


@implementation SponsorDetailViewController

@synthesize sponsorId;
@synthesize name;
@synthesize website;
@synthesize logo;

- (id) init
{
	sponsorId = [[NSString alloc] init];
	[super initWithNibName: @"SponsorDetailViewController" bundle: nil];
	return self;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void) viewWillAppear:(BOOL)animated
{
	[[self view] bringSubviewToFront: loadingIndicator];
	[loadingIndicator startAnimating];
	responseData = [[NSMutableData data] retain];
	
	[nameLabel setText: name];
	[websiteLabel setText: website];
	
	// Determine image size and resize logoImage to accomodate height
	UIImage *img = [UIImage imageNamed: logo];
	[logoImage setImage: img];
	//[logoImage setCenter: CGPointMake(1.0, 10.0)];
	
	// Set logo view to the size of the logo
	CGSize imgSize = [img size];
	CGRect frame = [logoImage frame];
	frame.size.height = imgSize.height;
	frame.size.width = imgSize.width;
	[logoImage setFrame: frame];
	
	// Set the description view adjusted for logo
	
	CGRect descFrame = [description frame];
	//description.bounds = CGRectMake(descFrame.origin.x, descFrame.origin.y, 300, description.bounds.size.height - logoImage.bounds.size.height);
	descFrame.origin.y = logoImage.frame.origin.y + imgSize.height + 10.0;
	[description setFrame: descFrame];
	

	[description setContentInset: UIEdgeInsetsMake(-4,-8,0,0)];
	
	[description setText: @"Loading ..."];
	
	NSString *url = [NSString stringWithFormat: @"http://www.newriverclimbing.net/vous_sponsor.php?id=%@", sponsorId];
	NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString: url]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
	
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
	NSDictionary *sponsor = [resultData objectForKey: @"result"];

	
	//CGPoint point = logoImage.frame.origin;
	//point.y = frame.origin.y + 10.0;
	//description.frame.origin = point;
	
	// Modify description location to just below logo
	[description setText: [sponsor objectForKey: @"d"]];

	//[responseString release];
	[loadingIndicator stopAnimating];
	
}


- (void)dealloc {
	[sponsorId release];
	[name release];
	[logo release];
	[website release];
    [super dealloc];
}


@end
