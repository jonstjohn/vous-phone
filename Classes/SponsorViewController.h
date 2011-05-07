//
//  SponsorViewController.h
//  rendezvous
//
//  Created by Jonathan StJohn on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SponsorDetailViewController.h"


@interface SponsorViewController : UIViewController <UITableViewDelegate> {
	IBOutlet UITableView *sponsorTable;
	NSMutableArray *sponsors;
	IBOutlet UIActivityIndicatorView *loadingIndicator;
	SponsorDetailViewController *detailController;
	NSMutableData *responseData;
}

- (void) refreshData;
@end
