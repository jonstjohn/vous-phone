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
	IBOutlet UILabel *location;
	IBOutlet UITextView *description;
	IBOutlet UIActivityIndicatorView *loadingIndicator;
	NSMutableData *responseData;
	NSString *nameStr;
	NSString *locationStr;
	NSString *sponsorStr;
}

@property (nonatomic, retain) NSString *eventId;
@property (nonatomic, retain) NSString *nameStr;
@property (nonatomic, retain) NSString *locationStr;
@property (nonatomic, retain) NSString *sponsorStr;

- (void) adjustLayout;

@end
