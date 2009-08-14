//
//  AmazonViewController.m
//  iS3
//
//  Created by yanagisawa.n on 1/29/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AmazonViewController.h"
#import "NowLoading.h"

@implementation AmazonViewController

@synthesize URLString;
@synthesize webView;

//NowLoading *nowLoading = nil;
//UIView *nowLoadingView = nil;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		
	}
	return self;
}

- (void) setURLToWebView {

	NowLoading *nowLoading = nil;
  UIView *nowLoadingView = nil;
  
  nowLoading = [[[NowLoading alloc] init] retain];
	nowLoadingView = [nowLoading nowloadingView];
	[webView addSubview:nowLoadingView];
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLString]]];
	
	[nowLoading removeNowloadingView:nowLoadingView];
	nowLoading = nil;
}

/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */


// Implement loadView to create a view hierarchy programmatically, without using a nib.
// - (void)loadView {

// }



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
  [self setURLToWebView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)viewDidAppear:(BOOL)animated {
  
}
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

- (void)dealloc {
	[webView release];
	[URLString release];
	[super dealloc];
}


@end
