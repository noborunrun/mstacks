//
//  setting.m
//  iS3
//
//  Created by yanagisawa.n on 10/2/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "settingController.h"
#import "AllBookListController.h"
#import "IS3AppDelegate.h"
#import "user.h"
#import "AboutViewController.h"
#import "AmazonViewController.h"

@implementation SettingController

@synthesize userNo;
@synthesize userID;
@synthesize apiToken;
@synthesize string;
@synthesize appDelegate;
@synthesize allBookListController;
//@synthesize changed;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		appDelegate = (IS3AppDelegate *)[[UIApplication sharedApplication] delegate];
    allBookListController = (AllBookListController *)[[UIApplication sharedApplication] delegate];
		//if (appDelegate.userId != @"" && appDelegate.APIToken != @"") {
		//if (appDelegate.userId != @"") {
		userID.text = appDelegate.userId;
		[userID becomeFirstResponder];
		//apiToken.text = appDelegate.APIToken;
		//}
	}
	return self;
}

//- (void) awakeFromNib {
//
//}

- (IBAction)setting:(id)sender{
	if (userID.text == nil) {
		UIAlertView *alert = [UIAlertView alloc];
		[alert initWithTitle:nil message:NSLocalizedString(@"UserID/APITokenを入力してください。", nil)
								delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];	
		[alert release];
    
	}else{
		
		////NSLog(@"%@",userID.text);
		NSArray *settingArray = [[NSArray alloc] initWithObjects:userID.text,apiToken.text,nil];
		//NSArray *settingArray = [[NSArray alloc] initWithObjects:userID.text,nil];
		
		//insert UserData
		User *userData = [[User alloc] init];
		[userData addUserWith:settingArray];
		appDelegate.userId = userID.text;
		appDelegate.APIToken = apiToken.text;
		appDelegate.ssbDirty = NO;
		
		appDelegate.userChange = YES;
		[settingArray release];
		[userData release];
	}
}

- (IBAction)about:(id)sender {
  AboutViewController *about = [[AboutViewController alloc] initWithNibName:@"AboutView" bundle:nil];
  [self.navigationController pushViewController:about animated:YES];
  
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	if (theTextField == userID){
		[userID resignFirstResponder];
	}
	if (theTextField == apiToken){
		[apiToken resignFirstResponder];
	}
	return YES;
}

- (IBAction)backgroudClick:(id)sender{
  [userID resignFirstResponder];
  [apiToken resignFirstResponder];
}

- (IBAction) openURL:(id)sender {
  NSString *URL = @"http://stack.nayutaya.jp/api"; 
  ////NSLog(@"%@",amazonURL);
  AmazonViewController *amazonWVController = [[AmazonViewController alloc] initWithNibName:@"URLView"  bundle:nil];
  amazonWVController.URLString = URL;
  //amazonWVController.title = [@"amazon:" stringByAppendingString:self.bookTitle.text];
  [[self navigationController] pushViewController:amazonWVController animated:YES];
  
}



// Implement loadView if you want to create a view hierarchy programmatically
// - (void)loadView {
// }

// If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad {
	appDelegate = (IS3AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.title = @"Settings";
  
	[super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
  userID.text = appDelegate.userId;
	apiToken.text = appDelegate.APIToken;
	//label.text = @"";	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

- (void)dealloc {
	[userID release];
	[apiToken release];
	[string release];
	//[label release];	
	[super dealloc];
}


@end
