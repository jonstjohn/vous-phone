//
//  SponsorViewController.h
//  rendezvous
//
//  Created by Jonathan StJohn on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SponsorViewController : UIViewController <UITableViewDelegate> {
	UITableView *sponsorTable;
	NSArray *sponsors;
}

@end
