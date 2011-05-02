//
//  SponsorTableCell.h
//  rendezvous
//
//  Created by Jonathan StJohn on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SponsorTableCell : UITableViewCell {
	NSString *sponsorId;
	UILabel *nameLabel;
	UILabel *websiteLabel;
	UIImageView *logoImage;
}

@property (nonatomic, retain) NSString *sponsorId;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *websiteLabel;
@property (nonatomic, retain) UIImageView *logoImage;

@end
