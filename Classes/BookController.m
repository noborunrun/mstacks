//
//  BookController.m
//  iS3
//
//  Created by noboru on 11/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "IS3AppDelegate.h"
#import "BookController.h"
#import "Image.h"
#import "StackStockBooks.h"
#import "MutterController.h"
#import "AmazonViewController.h"
#import "StatusPickerViewController.h"
#import "ImageStore.h"

@implementation BookController

@synthesize bookTitle;
@synthesize isbn,isbn10,author,publisher,dateOfIsues;
@synthesize bookImageButton;
@synthesize categoryButton;
@synthesize categoryButtonTitle;
@synthesize bookImage;
//@synthesize mutterButton;
@synthesize toolbarView;

@synthesize imageUrl;
@synthesize tempTitle;
@synthesize bookISBN;
@synthesize bookISBN10;
@synthesize bookAuthor;
@synthesize bookPublisher;
@synthesize bookDateOfIsues;
@synthesize appDelegate;

ImageStore *imageStore;
BOOL toolbarAppear;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Custom initialization
    appDelegate = (IS3AppDelegate *)[[UIApplication sharedApplication] delegate];
    toolbarAppear = YES;
    toolbarView.hidden = NO;

	}
	return self;
}

- (void)setButtonTitleWith:(NSInteger)recieverID {

  switch (recieverID) {
    case 1:
      //[self.categoryButton setTitle:@"登録" forState:UIControlStateNormal];
//		  categoryButtonTitle = @"登録";
      break;
    default:
      break;
  }
  
}

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  if (imageStore == nil) {
    imageStore = [[ImageStore alloc] initWithDelegate:self];
	}
  
  //  ////NSLog(@"%@",imageUrl);
	Image *getImage = [[Image alloc] initWIthDefaultImage];
	UIImage *imageData = [[UIImage alloc] initWithData:[getImage defaultImage]];
	self.bookImage.image = imageData;
	[getImage release];
	[imageData release];
  [self setLabel];
}

- (void)setLabel {
  self.bookTitle.text = self.tempTitle;
  self.author.text = self.bookAuthor;
  self.isbn.text = self.bookISBN;
  self.isbn10.text = self.bookISBN10;
  self.publisher.text = self.bookPublisher;
  if ([self.bookDateOfIsues isKindOfClass:[NSNull class]]) {
    self.dateOfIsues.text = @"";
  }else {
    self.dateOfIsues.text = self.bookDateOfIsues;
  }
//	[self.categoryButton setTitle:categoryButtonTitle forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated {
  //  if (appDelegate.statusChange == YES){
  //    [self.navigationController popViewControllerAnimated:YES];
  //  }else{
  if (imageStore == nil) {
    imageStore = [[ImageStore alloc] initWithDelegate:self];
	}
  imageStore.delegate = self;
  
	Image *getImage = [[Image alloc] initWIthDefaultImage];
  
	if ([imageUrl isKindOfClass:[NSNull class]]) {
	}else{
    [imageStore getImage:[getImage getLargeSizeImageWithURL:imageUrl]];
    //self.bookImage.image = imageStore;
    //		UIImage *fixImageData = [[UIImage alloc] initWithData:[getImage getImageFromWebWithURL:[getImage getLargeSizeImageWithURL:imageUrl]]];
    //		self.bookImage.image = fixImageData;
    //		[fixImageData release];
	}
	[getImage release];
  //  }   
  
}

- (void)viewDidDisappear:(BOOL)animated{
  
	//Image *getImage = [[Image alloc] initWIthDefaultImage];
	//UIImage *defaultImageData = [[UIImage alloc] initWithData:[getImage defaultImage]];
	//self.bookImage.image = defaultImageData;
  //imageStore.delegate = nil;
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

- (IBAction)showMutter:(id)sender {
  StackStockBooks *ssb = [[StackStockBooks alloc] initWithDataAboutMutterOfBookID:self.isbn.text];
  MutterController *mutterController = [[MutterController alloc] initWithStyle:UITableViewStyleGrouped];
  mutterController.title = self.bookTitle.text;
  mutterController.mutterList = ssb.mutterArray;
  NSLog(@"%@",ssb.mutterArray);
  [ssb release];

  [[self navigationController] pushViewController:mutterController animated:YES];
}

- (IBAction)showAmazon:(id)sender {
  
  NSString *amazonURL = [[@"http://www.amazon.co.jp/gp/aw/rd.html?ie=UTF8&dl=1&uid=NULLGWDOCOMO&lc=msn&a=" stringByAppendingString:self.isbn10.text] stringByAppendingString:@"&at=noblog0c3-22&url=%2Fgp%2Faw%2Fd.html"];
  ////NSLog(@"%@",amazonURL);
	AmazonViewController *amazonWVController = [[AmazonViewController alloc] initWithNibName:@"URLView"  bundle:nil];
	amazonWVController.URLString = amazonURL;
  amazonWVController.title = [@"amazon:" stringByAppendingString:self.bookTitle.text];
  [[self navigationController] pushViewController:amazonWVController animated:YES];
	
}

- (IBAction)showStatusViewPicker:(id)sender {
  StatusPickerViewController *statusPickerViewController = 
  [[StatusPickerViewController alloc] initWithNibName:@"PickerView" bundle:nil];
  statusPickerViewController.isbn10 = self.isbn10.text;
  [self.view addSubview:statusPickerViewController.view];
}

- (IBAction)showToolbar:(id)sender {
  if (toolbarAppear == YES) {
    toolbarView.hidden = NO;
    toolbarAppear = NO;
  }else {
    toolbarView.hidden = YES;
    toolbarAppear = YES;
  }
}

- (void)imageStoreDidGetNewImage:(ImageStore*)sender url:(NSString*)url
{
  // //NSLog(@"%@",[sender.images objectForKey:@"URL"]);
  self.bookImage.image = [sender getImage:url];
}

- (void)dealloc {
	[bookTitle release];
	[isbn release];
  [isbn10 release];
  [author release];
  [publisher release];
	[bookImageButton release];
	[bookImage release];
  [dateOfIsues release];
	[imageUrl release];
	[tempTitle release];
	[bookISBN release];
  [bookAuthor release];
  [bookPublisher release];
  [bookDateOfIsues release];
	[super dealloc];
}


@end
