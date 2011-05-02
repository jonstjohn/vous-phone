//
//  SponsorDetailViewController.h
//  rendezvous
//
//  Created by Jonathan StJohn on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SponsorDetailViewController : UIViewController {
	IBOutlet UILabel *nameLabel;
	IBOutlet UILabel *websiteLabel;
	IBOutlet UITextView *description;
	IBOutlet UIImageView *logoImage;
	NSString *sponsorId;
	NSString *logo;
	NSString *website;
	IBOutlet UIActivityIndicatorView *loadingIndicator;
	NSMutableData *responseData;
}

@property (nonatomic, retain) NSString *sponsorId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *website;
@property (nonatomic, retain) NSString *logo;

@end
