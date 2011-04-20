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
	sponsors = [[NSArray alloc] initWithObjects: 

				[NSDictionary dictionaryWithObjectsAndKeys:
				    @"Dead Point Magazine", @"name", @"deadpointmag.com", @"website", @"150_DPM-logo.jpg", @"logo", nil
				],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Mountain Hardwear", @"name", @"mountainhardwear.com", @"website", @"150_Mtn_Hdwr.4c.jpg", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Patagonia", @"name", @"patagonia.com", @"website", @"150_Patagonia-Word-Logo.jpg", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"La Sportiva", @"name", @"lasportiva.com", @"website", @"150_Half-Mtn-Lg_1.jpg", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Five Ten", @"name", @"fiveten.com", @"website", @"100_fivetenlogo.jpg", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Petzl", @"name", @"petzl.com", @"website", @"100_petzl_logo.jpg", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Sanuk", @"name", @"sanuk.com", @"website", @"100_logo_box_web.jpg", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Scarpa", @"name", @"scarpa.com", @"website", @"100_scarpa_logo.jpg", @"logo", nil
				],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Osprey", @"name", @"ospreypacks.com", @"website", @"100_Osprey-Logo.jpg", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Black Diamond", @"name", @"bdel.com", @"website", @"100_BlackDiamond.jpg", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Sterling Rope", @"name", @"sterlingrope.com", @"website", @"103-map.png", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Trango", @"name", @"trango.com", @"website", @"103-map.png", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Outdoor Research", @"name", @"outdoorresearch.com", @"website", @"103-map.png", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Mammut", @"name", @"mammut.com", @"website", @"103-map.png", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Prana", @"name", @"prana.com", @"website", @"103-map.png", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Mountain Khakis", @"name", @"mountainkhaki.com", @"website", @"103-map.png", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Evolv", @"name", @"evolvsports.com", @"website", @"103-map.png", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Metolius", @"name", @"metoliusclimbing.com", @"website", @"103-map.png", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Friksn", @"name", @"friksn.com", @"website", @"103-map.png", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Darn Tough", @"name", @"darntough.com", @"website", @"103-map.png", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Chaco", @"name", @"chacousa.com", @"website", @"103-map.png", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
				 @"Misty Mountain", @"name", @"mistymountain.com", @"website", @"103-map.png", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Nutriex", @"name", @"nutriex.com", @"website", @"103-map.png", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"So Ill", @"name", @"soillholds.com", @"website", @"103-map.png", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Warrior's Way", @"name", @"warriorsway.com", @"website", @"103-map.png", @"logo", nil
				 ],
				[NSDictionary dictionaryWithObjectsAndKeys:
					@"Fox Mountain Guides", @"name", @"foxmountainguides.com", @"website", @"103-map.png", @"logo", nil
				 ],
				nil
				];
	
	[super initWithNibName: @"SponsorViewController" bundle: nil];
	return self;
}

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section
{
	return [sponsors count];
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"SponsorCell"];
	
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: @"SponsorCell"];
	}
	
	NSDictionary *sponsor = [sponsors objectAtIndex: [indexPath row]]; // TODO may need to release, not sure
	NSLog(@"%@", sponsor);
	[[cell textLabel] setText: [NSString stringWithFormat: @"%@", [sponsor objectForKey: @"name"]]];
	[[cell detailTextLabel] setText: [NSString stringWithFormat: @"%@", [sponsor objectForKey: @"website"]]];
	//[[cell imageView] setImage: [UIImage imageNamed: [NSString stringWithFormat: @"%@", [sponsor objectForKey: @"logo"]]]];
	
	return cell;
}

- (void) viewDidLoad
{
	[[self navigationItem] setTitle: @"Sponsors"];
	[super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
	[[self navigationController] setNavigationBarHidden: NO];
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


- (void)dealloc {
    [super dealloc];
}


@end
