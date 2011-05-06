//
//  WeatherViewController.h
//  rendezvous
//
//  Created by Jonathan StJohn on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WeatherViewController : UIViewController <UITableViewDelegate> {
	NSMutableArray *days;
	IBOutlet UITableView *myTable;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	NSMutableData *responseData;
}

- (void) refreshData;

@end
