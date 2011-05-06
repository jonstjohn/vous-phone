//
//  HomeViewController.h
//  rendezvous
//
//  Created by Jonathan StJohn on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleViewController.h"
#import "SupportViewController.h"
#import "SponsorViewController.h"
#import "RegistrationViewController.h"
#import "MapViewController.h"
#import "WeatherViewController.h"
#import "WeatherHourlyViewController.h"
#import "MapBurnwoodViewController.h"
#import "WeatherAboutViewController.h"

@interface HomeViewController : UIViewController {
	ScheduleViewController *scheduleController;
	SupportViewController *supportController;
	SponsorViewController *sponsorController;
	RegistrationViewController *registrationController;
	MapViewController *mapController;
	WeatherViewController *weatherController;
	UITabBarController *weatherTabController;
	UITabBarController *mapTabController;
}
- (IBAction) showSchedule;
- (IBAction) showSupport;
- (IBAction) showSponsors;
- (IBAction) showRegistration;
- (IBAction) showMap;
- (IBAction) showWeather;

@end
