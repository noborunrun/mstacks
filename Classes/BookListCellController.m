//
//  BookListCellController.m
//  iS3
//
//  Created by yanagisawa.n on 11/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "BookListCellController.h"
#import "BookListCell.h"
#import "ImageStore.h"

@implementation BookListCellController

@synthesize cell;
@synthesize imageStore;
@synthesize defaultImage;
@synthesize imageUrl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}

- (void) awakeFromNib {
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */
/*
 //If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad {
  //cell.bookImage = [cell.imageStore getImage:imageUrl];
}
 */

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

- (void)dealloc {
  [cell release];
	[super dealloc];
}


@end
