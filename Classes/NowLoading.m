//
//  NowLoading.m
//  iS3
//
//  Created by noboru on 11/25/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "NowLoading.h"

@implementation NowLoading

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)dealloc {
    [super dealloc];
}

- (UIView *) nowloadingView {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	UIView *v = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)] autorelease];
	
	UIActivityIndicatorView *ai = [[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(140, 175, 50, 50)] autorelease];
	ai.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
	[ai startAnimating];
	[v addSubview:ai];
	
	return v;
}

- (void) removeNowloadingView:(UIView *)nowloadingView {

	if (nowloadingView) {
		[nowloadingView removeFromSuperview];
		nowloadingView = nil;
	}
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
