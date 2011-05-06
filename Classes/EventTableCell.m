//
//  EventTableCell.m
//  rendezvous
//
//  Created by Jonathan StJohn on 5/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventTableCell.h"


@implementation EventTableCell

@synthesize eventId;
@synthesize nameLabel;
@synthesize timeLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        nameLabel = [[UILabel alloc] initWithFrame: CGRectZero];
		[[self contentView] addSubview: nameLabel];
		[nameLabel release];
		
        timeLabel = [[UILabel alloc] initWithFrame: CGRectZero];
		[[self contentView] addSubview: timeLabel];
		[timeLabel release];
    }
    return self;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	CGRect bounds = [[self contentView] bounds];
	float h = bounds.size.height;
	float w = bounds.size.width;
	
	float inset = 6.0;
	float columnSpacing = 10.0;
	float rowSpacing = 2.0;
	
	float big = 16.0;
	float small = 12.0;
	
	float nameX = inset;
	float nameY = inset;
	float nameWidth = w;
	float nameFontSize = big;
	float nameHeight = nameFontSize + 3.0;
	
	float timeX = inset;
	float timeY = nameY + nameHeight + rowSpacing;
	float timeWidth = nameWidth;
	float timeFontSize = small;
	float timeHeight = timeFontSize + 2.0;

	/*
	float logoX = nameX + nameWidth + columnSpacing;
	float logoY = (h - 20.0) / 2.0;
	float logoHeight = 20.0;
	 */
	
	// Total height = inset * 2 + nameHeight + rowSpacing + timeHeight = (6.0 * 2) + 17.0 + 4.0 + 13.0 = 44.0
	
	// Name label
	CGRect innerFrameName = CGRectMake(nameX, nameY, nameWidth, nameHeight); // big + 1.0);
	[nameLabel setFont: [UIFont systemFontOfSize: big]];
	[nameLabel setTextAlignment: UITextAlignmentLeft];
	[nameLabel setFrame: innerFrameName];
	
	// time label
	CGRect innerFrametime = CGRectMake(timeX, timeY, timeWidth, timeHeight);
	[timeLabel setFont: [UIFont systemFontOfSize: timeFontSize]];
	[timeLabel setTextAlignment: UITextAlignmentLeft];
	[timeLabel setFrame: innerFrametime];
	
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
