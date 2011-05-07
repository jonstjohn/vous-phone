//
//  AreaHourlyViewController.h
//  climbingweather
//
//  Created by Jonathan StJohn on 1/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WeatherHourlyViewController : UIViewController <UITableViewDelegate> {
	NSMutableArray *days;
	IBOutlet UITableView *hourlyTable;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	NSMutableData *responseData;
}

- (void) refreshData;

@end
