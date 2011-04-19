//
//  MapViewController.m
//  rendezvous
//
//  Created by Jonathan StJohn on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "MapPoint.h"


@implementation MapViewController

- (void) viewDidLoad
{
	[[self navigationItem] setTitle: @"Map"];
	
	CLLocationCoordinate2D coordinate;
	coordinate.latitude = 38.07333200077531;
	coordinate.longitude = -81.07609748840332;
	MapPoint *mp = [[MapPoint alloc] initWithCoordinate: coordinate title: @"Burnwood" ];
	[mapView addAnnotation: mp];
	[mp release];
	
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


- (void) mapView: (MKMapView *) mv didAddAnnotationViews: (NSArray *) views
{
	MKAnnotationView *annotationView = [views objectAtIndex: 0];
	id <MKAnnotation> mp = [annotationView annotation];
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 1000, 1000);
	[mv setRegion: region animated: NO];
	[mv setHidden: NO];
}


- (MKAnnotationView *) mapView: (MKMapView *) mv viewForAnnotation: (id <MKAnnotation>) annotation
{	
	if ([mv userLocation] == annotation) {
		return nil;
	}
	
	NSString *identifier = [NSString stringWithFormat: @"climbing_area"];
	
	MKAnnotationView *annotationView = [mv dequeueReusableAnnotationViewWithIdentifier:identifier];
	if (annotationView == nil) {
		annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier] autorelease];
		[annotationView setImage: [UIImage imageNamed:@"climbing.png"]];
		
		[annotationView setCanShowCallout: YES];
	}
	return annotationView;
}


- (void)dealloc {
    [super dealloc];
}


@end
