//
//  MutterDetailViewController.m
//  iS3
//
//  Created by noboru on 6/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MutterDetailViewController.h"
#import "ImageStore.h"

@implementation MutterDetailViewController

@synthesize userName;
@synthesize userImage;
@synthesize mutterText;
@synthesize userID;
@synthesize mutter;
@synthesize mutterArray;
@synthesize userArray;
//@synthesize mutterArrayIndex;
//@synthesize imageStore;

UIImage *userImageTemp;
ImageStore *imageStore;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void) setMutterItem {
	//if (imageStore == nil) {
//		imageStore = [[ImageStore alloc] initWithDelegate:self];
//	}
	//imageStore.delegate = self;
	
	//userImageTemp = [imageStore getImage:[[mutterArray objectAtIndex:0] objectForKey:@"icon_uri"]];
	mutterText.text = mutter;
	//NSLog(@"%@",[[mutterArray objectAtIndex:0] objectForKey:@"user_id"]);
	//NSLog(@"%@",[[mutterArray objectAtIndex:0] objectForKey:@"name"]);
	self.userID = [[mutterArray objectAtIndex:0] objectForKey:@"user_id"];
	[self.userName setText:[[mutterArray objectAtIndex:0] objectForKey:@"name"]];
//	self.userImage.image = [imageStore getImage:[[mutterArray objectAtIndex:0] objectForKey:@"icon_uri"]];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	//if (imageStore == nil) {
//		imageStore = [[ImageStore alloc] initWithDelegate:self];
//	}
	[self setMutterItem];
    [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void)imageStoreDidGetNewImage:(ImageStore*)sender url:(NSString*)url {
	self.userImage.image = userImageTemp;
	
}



@end
