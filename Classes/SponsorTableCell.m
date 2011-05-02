//
//  SponsorTableCell.m
//  rendezvous
//
//  Created by Jonathan StJohn on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SponsorTableCell.h"


@implementation SponsorTableCell

@synthesize sponsorId;
@synthesize nameLabel;
@synthesize websiteLabel;
@synthesize logoImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        nameLabel = [[UILabel alloc] initWithFrame: CGRectZero];
		[[self contentView] addSubview: nameLabel];
		[nameLabel release];
		
        websiteLabel = [[UILabel alloc] initWithFrame: CGRectZero];
		[[self contentView] addSubview: websiteLabel];
		[websiteLabel release];
		
        logoImage = [[UIImageView alloc] initWithFrame: CGRectZero];
		[[self contentView] addSubview: logoImage];
		[logoImage setContentMode: UIViewContentModeScaleAspectFit];
		[logoImage release];
    }
    return self;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	CGRect bounds = [[self contentView] bounds];
	float h = bounds.size.height;
	float w = bounds.size.width;
	//float valueWidth = 200.0;
	
	float inset = 6.0;
	float columnSpacing = 10.0;
	float rowSpacing = 2.0;
	
	float big = 16.0;
	float small = 12.0;
	
	float logoWidth = 150.0;
	
	float nameX = inset;
	float nameY = inset;
	float nameWidth = w - logoWidth - columnSpacing;
	float nameFontSize = big;
	float nameHeight = nameFontSize + 1.0;
	
	float websiteX = inset;
	float websiteY = nameY + nameHeight + rowSpacing;
	float websiteWidth = nameWidth;
	float websiteFontSize = small;
	float websiteHeight = websiteFontSize + 1.0;
	
	float logoX = nameX + nameWidth + columnSpacing;
	float logoY = (h - 20.0) / 2.0;
	float logoHeight = 20.0;
	
	// Total height = inset * 2 + nameHeight + rowSpacing + websiteHeight = (6.0 * 2) + 17.0 + 4.0 + 13.0 = 44.0
	
	/*
	 
	 float secondRowY = inset + 20.0;
	 float thirdRowY = secondRowY + 20.0;
	 
	 float dayX = inset;
	 float dayWidth = 50.0;
	 
	 float iconX = dayX + dayWidth + columnSpacing;
	 float iconWidth = 40.0;
	 
	 float highX = iconX + iconWidth + columnSpacing;
	 float highWidth = 50.0;
	 
	 float precipX = highX + highWidth + columnSpacing;
	 float precipWidth = 50.0;
	 
	 float windX = precipX + precipWidth + columnSpacing;
	 float windWidth = 60.0;
	 */
	
	
	// Name label
	CGRect innerFrameName = CGRectMake(nameX, nameY, nameWidth, nameHeight); // big + 1.0);
	[nameLabel setFont: [UIFont systemFontOfSize: big]];
	[nameLabel setTextAlignment: UITextAlignmentLeft];
	[nameLabel setFrame: innerFrameName];
	
	// Website label
	CGRect innerFrameWebsite = CGRectMake(websiteX, websiteY, websiteWidth, websiteHeight);
	[websiteLabel setFont: [UIFont systemFontOfSize: websiteFontSize]];
	[websiteLabel setTextAlignment: UITextAlignmentLeft];
	[websiteLabel setFrame: innerFrameWebsite];
	
	// Logo
	CGRect innerFrameLogo = CGRectMake(logoX, logoY, logoWidth, logoHeight);
	[logoImage setFrame: innerFrameLogo];
	
	/*
	 
	 // Date
	 CGRect innerFrame2 = CGRectMake(dayX, secondRowY, dayWidth, small + 1.0);
	 [dateLabel setTextAlignment: UITextAlignmentCenter];
	 [dateLabel setFont: [UIFont systemFontOfSize: small]];
	 [dateLabel setFrame: innerFrame2];
	 
	 // Icon
	 CGRect innerFrameIcon = CGRectMake(iconX, inset, iconWidth, big + small + 2.0);
	 [iconImage setFrame: innerFrameIcon];
	 
	 // High
	 CGRect innerFrame3 = CGRectMake(highX, inset, highWidth, big + 1.0);
	 [highLabel setFont: [UIFont systemFontOfSize: big]];
	 [highLabel setTextAlignment: UITextAlignmentCenter];
	 [highLabel setFrame: innerFrame3];
	 
	 // Low
	 CGRect innerFrameLow = CGRectMake(highX, secondRowY, highWidth, small + 1.0);
	 [lowLabel setFont: [UIFont systemFontOfSize: small]];
	 [lowLabel setTextAlignment: UITextAlignmentCenter];
	 [lowLabel setFrame: innerFrameLow];
	 
	 // Precip Day
	 CGRect innerFramePrecipDay = CGRectMake(precipX, inset, precipWidth, big + 1.0);
	 [precipDayLabel setFont: [UIFont systemFontOfSize: big]];
	 [precipDayLabel setTextAlignment: UITextAlignmentCenter];
	 [precipDayLabel setFrame: innerFramePrecipDay];
	 
	 // Precip Night
	 CGRect innerFramePrecipNight = CGRectMake(precipX, secondRowY, precipWidth, small + 1.0);
	 [precipNightLabel setFont: [UIFont systemFontOfSize: small]];
	 [precipNightLabel setTextAlignment: UITextAlignmentCenter];
	 [precipNightLabel setFrame: innerFramePrecipNight];
	 
	 // Wind
	 CGRect innerFrameWind = CGRectMake(windX, inset, windWidth, big + 1.0);
	 [windLabel setFont: [UIFont systemFontOfSize: big]];
	 [windLabel setTextAlignment: UITextAlignmentCenter];
	 [windLabel setFrame: innerFrameWind];
	 
	 // Humidity
	 CGRect innerFrameHum = CGRectMake(windX, secondRowY, windWidth, small + 1.0);
	 [humLabel setFont: [UIFont systemFontOfSize: small]];
	 [humLabel setTextAlignment: UITextAlignmentCenter];
	 [humLabel setFrame: innerFrameHum];
	 
	 // Conditions
	 CGRect innerFrameConditions = CGRectMake(dayX + 5.0, thirdRowY, w, small + 1.0);
	 [conditionsLabel setFont: [UIFont systemFontOfSize: small]];
	 [conditionsLabel setTextAlignment: UITextAlignmentLeft];
	 [conditionsLabel setFrame: innerFrameConditions];
	 */
	
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
