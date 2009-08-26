//
//  MutterCell.m
//  iS3
//
//  Created by noboru on 8/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MutterCell.h"


@implementation MutterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
