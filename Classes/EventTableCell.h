//
//  EventTableCell.h
//  rendezvous
//
//  Created by Jonathan StJohn on 5/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EventTableCell : UITableViewCell {
	NSString *eventId;
	UILabel *nameLabel;
	UILabel *timeLabel;
}

@property (nonatomic, retain) NSString *eventId;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *timeLabel;

@end
