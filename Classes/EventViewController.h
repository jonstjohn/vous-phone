//
//  EventViewController.h
//  rendezvous
//
//  Created by Jonathan StJohn on 4/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"


@interface EventViewController : UIViewController {
	NSString *eventId;
	IBOutlet UILabel *name;
	IBOutlet UILabel *sponsor;
	IBOutlet UILabel *time;
	IBOutlet UILabel *location;
	IBOutlet UITextView *description;
	IBOutlet UIActivityIndicatorView *loadingIndicator;
	NSMutableData *responseData;
}

@property (nonatomic, retain) NSString *eventId;

@end
