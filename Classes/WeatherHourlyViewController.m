//
//  AreaHourlyViewController.m
//  climbingweather
//
//  Created by Jonathan StJohn on 1/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WeatherHourlyViewController.h"
#import "WeatherHourlyCell.h"

@implementation WeatherHourlyViewController

- (id) init
{
	// Setup tab bar item
	UITabBarItem *tbi = [self tabBarItem];
	[tbi setTitle: @"Hourly"];
	
	// Add image
	UIImage *i = [UIImage imageNamed:@"icon_time.png"];
	[tbi setImage: i];
	
	days = [[NSMutableArray alloc] initWithObjects: nil];
	
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	float inset = 2.0;
	float columnSpacing = 10.0;
	
	//float secondRowY = inset + 20.0;
	//float thirdRowY = secondRowY + 20.0;
	
	float dayX = inset;
	float dayWidth = 50.0;
	
	float iconX = dayX + dayWidth + columnSpacing;
	float iconWidth = 40.0;
	
	float highX = iconX + iconWidth + columnSpacing;
	float highWidth = 50.0;
	
	float precipX = highX + highWidth + columnSpacing;
	float precipWidth = 50.0;
	
	float windX = precipX + precipWidth + columnSpacing;
	float windWidth = 60.0;
	
	float fontSize = 10.0;
	float rowHeight = fontSize + inset * 2.0;
	
	// Set table header
	UIView *containerView = [[[UIView alloc] initWithFrame: CGRectMake(0, 0, 300, rowHeight)] autorelease];
	[containerView setBackgroundColor: [[UIColor lightGrayColor] colorWithAlphaComponent: 0.5]];
	//[containerView setAlpha: 0.75];
	UILabel *dayLabel = [[[UILabel alloc] initWithFrame: CGRectMake(dayX, inset, dayWidth, fontSize)] autorelease];
	[dayLabel setText: @"Forecast"];
	[dayLabel setBackgroundColor:[UIColor clearColor]];
	[dayLabel setFont: [UIFont systemFontOfSize: fontSize]];
	[dayLabel setTextAlignment: UITextAlignmentCenter];
	[containerView addSubview: dayLabel];
	
	UILabel *highLabel = [[[UILabel alloc] initWithFrame: CGRectMake(highX, inset, highWidth, fontSize)] autorelease];
	[highLabel setText: @"Temp/Sky"];
	[highLabel setBackgroundColor:[UIColor clearColor]];
	[highLabel setFont: [UIFont systemFontOfSize: fontSize]];
	[highLabel setTextAlignment: UITextAlignmentCenter];
	[containerView addSubview: highLabel];
	
	UILabel *precipLabel = [[[UILabel alloc] initWithFrame: CGRectMake(precipX, inset, precipWidth, fontSize)] autorelease];
	[precipLabel setText: @"Precip"];
	[precipLabel setBackgroundColor:[UIColor clearColor]];
	[precipLabel setFont: [UIFont systemFontOfSize: fontSize]];
	[precipLabel setTextAlignment: UITextAlignmentCenter];
	[containerView addSubview: precipLabel];
	
	UILabel *windLabel = [[[UILabel alloc] initWithFrame: CGRectMake(windX, inset, windWidth, fontSize)] autorelease];
	[windLabel setText: @"Wind/Hum"];
	[windLabel setBackgroundColor:[UIColor clearColor]];
	[windLabel setFont: [UIFont systemFontOfSize: fontSize]];
	[windLabel setTextAlignment: UITextAlignmentCenter];
	[containerView addSubview: windLabel];
	
	[hourlyTable setTableHeaderView: containerView];
	
	
	[[self navigationController] setNavigationBarHidden: NO];
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear: animated];
	
	[self refreshData];
}

- (void) refreshData
{
	[days removeAllObjects];
	[hourlyTable reloadData];
	[hourlyTable setHidden: YES];
	
	[[self view] bringSubviewToFront: activityIndicator];
	[activityIndicator startAnimating];
	
	// Send request for JSON data
	responseData = [[NSMutableData data] retain];
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *tempUnit = [NSString stringWithFormat: @"%@", [[prefs stringForKey: @"tempUnit"] isEqualToString: @"c"] ? @"c" : @"f"];
	NSString *url = [NSString stringWithFormat: @"http://api.climbingweather.com/api/area/hourly/3?apiKey=iphone-%@&tempUnit=%@",
					 [[UIDevice currentDevice] uniqueIdentifier], tempUnit];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
	
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear: animated];
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
	WeatherHourlyCell *cell = (WeatherHourlyCell *)[tableView dequeueReusableCellWithIdentifier: @"WeatherHourlyCell"];
	
	if (!cell) {
		cell = [[[WeatherHourlyCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"WeatherHourlyCell"] autorelease];
	}
	NSArray *hours = [[days objectAtIndex: [indexPath section]] objectForKey: @"f"];
	NSString *temp = [[hours objectAtIndex: [indexPath row]] objectForKey: @"t"];
	NSString *sky = [[hours objectAtIndex: [indexPath row]] objectForKey: @"sk"];
	NSString *conditions = [[hours objectAtIndex: [indexPath row]] objectForKey: @"c"];
	
	[[cell timeLabel] setText: [[hours objectAtIndex: [indexPath row]] objectForKey: @"ti"]];
	[[cell tempLabel] setText: [NSString stringWithFormat: @"%@˚", temp]];
	[[cell skyLabel] setText: [NSString stringWithFormat: @"%@%% cloudy", sky]];
	[[cell precipLabel] setText: [NSString stringWithFormat: @"%@%%", [[hours objectAtIndex: [indexPath row]] objectForKey: @"p"]]];
	[[cell windLabel] setText: [NSString stringWithFormat: @"%@ mph", [[hours objectAtIndex: [indexPath row]] objectForKey: @"ws"]]];
	[[cell humLabel] setText: [NSString stringWithFormat: @"%@%%", [[hours objectAtIndex: [indexPath row]] objectForKey: @"h"]]];
	[[cell conditionsLabel] setText: conditions];
	if ([conditions length] == 0) {
		[[cell conditionsLabel] setHidden: YES];
	} else {
		[[cell conditionsLabel] setHidden: NO];
	}
	
	//[[cell iconImage] setImage: [UIImage imageNamed: [[hours objectAtIndex: [indexPath row]] objectForKey: @"sy"]]];
	[[cell iconImage] setImage: [UIImage imageNamed: [NSString stringWithFormat: @"%@.png", [[hours objectAtIndex: [indexPath row]] objectForKey: @"sy"]]]];
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	return cell;
}

- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
	NSArray *hours = [[days objectAtIndex: [indexPath section]] objectForKey: @"f"];
	if ([[[hours objectAtIndex: [indexPath row]] objectForKey: @"c"] length] == 0) {
		return 53.0;
	} else {
		return 68.0;
	}
}

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section
{
	return [[[days objectAtIndex: section] objectForKey: @"f"] count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *) tableView
{
	return [days count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	return [[days objectAtIndex: section] objectForKey: @"n"];
	
}


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
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle: @"Network Connection Failure" message:@"Please try again when your network connection is restored." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[connection release];
	
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	[responseData release];
	
	NSDictionary *json = [responseString JSONValue];
	
	[days removeAllObjects];
	
	NSArray *forecastJson = [json objectForKey: @"f"];
	
	// Dictionary with keys 'dy' (day) and values array of forecast dictionary
	NSMutableDictionary *daysData = [NSMutableDictionary dictionaryWithCapacity: 0];
	
	// Temporary place to store day order
	NSMutableArray *daysTemp = [NSMutableArray arrayWithCapacity: 0];
	
	for (int i = 0; i < [forecastJson count]; i++) {
		
		NSString *dy = [[forecastJson objectAtIndex: i] objectForKey: @"dy"];
		
		if (![daysData objectForKey: dy]) {
			[daysData setObject: [NSMutableArray arrayWithCapacity: 0] forKey: dy];
			[daysTemp addObject: dy];
		}
		[[daysData objectForKey: dy] addObject: [forecastJson objectAtIndex: i]];
		//[dy release];
		
	}
	
	// Add objects stored in daysData in the order that they are stored in daysTemp
	for (int i = 0; i < [daysTemp count]; i++) {
		
		[days addObject: [
						  NSDictionary dictionaryWithObjectsAndKeys:
						  [daysTemp objectAtIndex: i], @"n", 
						  [daysData objectForKey: [daysTemp objectAtIndex: i]], @"f", nil
						  ]
		 ];
		
	}
	
	[responseString release];
	
	[activityIndicator stopAnimating];
	[hourlyTable reloadData];
	[hourlyTable setHidden: NO];
	
}

- (void)dealloc {
	[days release];
	[responseData release];
    [super dealloc];
}


@end
