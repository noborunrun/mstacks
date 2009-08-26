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
@synthesize toolbarView;
//@synthesize mutterArrayIndex;
//@synthesize imageStore;

UIImage *userImageTemp;
ImageStore *imageStore;
BOOL toolbarAppear;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
      toolbarAppear = YES;
      toolbarView.hidden = NO;
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void) setMutterItem {
	if (imageStore == nil) {
		imageStore = [[ImageStore alloc] initWithDelegate:self];
	}
	imageStore.delegate = self;
  [imageStore getImage:[[userArray objectAtIndex:0] objectForKey:@"icon_uri"]];
	mutterText.text = mutter;
	self.userID = [[userArray objectAtIndex:0] objectForKey:@"user_id"];
	[self.userName setText:[[userArray objectAtIndex:0] objectForKey:@"name"]];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	if (imageStore == nil) {
		imageStore = [[ImageStore alloc] initWithDelegate:self];
	}
  userImageTemp = [[UIImage alloc] init];
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

- (void)viewDidDisappear:(BOOL)animated {
   imageStore.delegate = nil;
   imageStore = nil; 
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
 // imageStore.delegate = nil;
//  imageStore = nil;
}


- (IBAction)showToolbar:(id)sender {
//  if (toolbarAppear == YES) {
//    toolbarView.hidden = NO;
//    toolbarAppear = NO;
//  }else {
//    toolbarView.hidden = YES;
//    toolbarAppear = YES;
//  }
}



- (void)dealloc {
    [super dealloc];
}


//ImageStoreDelegate
- (void)imageStoreDidGetNewImage:(ImageStore*)sender url:(NSString*)url {
	self.userImage.image = [sender getImage:url];
}



@end
