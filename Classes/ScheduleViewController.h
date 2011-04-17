//
//  ScheduleViewController.h
//  rendezvous
//
//  Created by Jonathan StJohn on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"


@interface ScheduleViewController : UIViewController <UITableViewDelegate> {
	IBOutlet UITableView *eventTable;
	IBOutlet UITableViewCell *loadingCell;
	NSMutableArray *events;
	NSMutableData *responseData;
	NSString *requestUrl;
}

@end
