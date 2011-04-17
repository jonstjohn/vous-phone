//
//  RegistrationViewController.m
//  rendezvous
//
//  Created by Jonathan StJohn on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RegistrationViewController.h"


@implementation RegistrationViewController

- (void) viewDidLoad
{
	[[self navigationItem] setTitle: @"Registration"];
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
