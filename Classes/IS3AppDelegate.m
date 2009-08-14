//
//  iS3AppDelegate.m
//  iS3
//
//  Created by yanagisawa.n on 11/7/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "IS3AppDelegate.h"
#import "User.h"
#import "StackStockBooks.h"
#import "NowLoading.h"
#import "Reachability.h"
//test
#import "Amazon.h"

@implementation IS3AppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize userArray;
@synthesize ssbDirty;
//@synthesize bookListArray;
@synthesize userId,APIToken,userNo;

@synthesize readBookArray;
@synthesize unreadBookArray;
@synthesize wishBookArray;
@synthesize nowReadBookArray;
@synthesize userChange,statusChange;
@synthesize selectItem;



NSString *dbName = @"iS3.sqlite";

//static int displayCount = 0;

- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	//testCode start
	NSString *isbn = @"9784774138381";
	
	Amazon *amazon = [[Amazon alloc] init];
	[amazon getBookInfoFromAmazonWith:isbn];
	
	//testCode end
	
	
	selectItem = [[NSArray alloc]initWithObjects:@"いつか欲しい",@"まだ読んでいない",@"いま読んでいる",@"もう読み終えた",nil];
	
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	self.ssbDirty = NO;
	// Override point for customization after app launch	
  [self getUserSetting];
  //NSLog(@"%@",userId);
  if (userId == @"") {
    tabBarController.selectedIndex = 2;
  }
  [window addSubview:tabBarController.view];
	[window makeKeyAndVisible];	
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  [self refleshIfNeeded];
  
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	
  
}

- (BOOL)refleshIfNeeded {
  [[Reachability sharedReachability] setNetworkStatusNotificationsEnabled:YES];
  [[Reachability sharedReachability] setHostName:@"http://stack.nayutaya.jp/"];
  ////NSLog(@"%@",[[Reachability sharedReachability] internetConnectionStatus]);
  if ([[Reachability sharedReachability] internetConnectionStatus] == NotReachable) {
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *infoDictionary = [bundle localizedInfoDictionary];
    NSString *appName = [[infoDictionary count] ? infoDictionary : [bundle infoDictionary] objectForKey:@"CFBundleDisplayName"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:appName message:NSLocalizedString(@"ネットワークが使用できません", nil)
                                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];	
    [alert release];
    return NO;
  }else{
    return YES;
  }
}

- (void)dealloc {
  
  [readBookArray release];
  [unreadBookArray release];
  [wishBookArray release];
  [nowReadBookArray release];
  
  
	[window release];
	[tabBarController release];
	[allBookListController release];
  //	[SettingController release];
  
	[readBookListController release];
	[wishBookListController release];
	[unReadBookListController release];
	[readingBookListController release];
	
  [userArray release];
  [userId release];
	[APIToken release];
	[super dealloc];
}

- (void) getUserSetting {
	[self copyDatabaseIfNeeded];
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.userArray = tempArray;
	[tempArray release];
	[User getInitialDataToDisplay:[self getDBPath]];
	
}

- (void) copyDatabaseIfNeeded {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [self getDBPath];
	BOOL success = [fileManager fileExistsAtPath:dbPath];
	if (!success) {
		NSString *defaultFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
		success = [fileManager copyItemAtPath:defaultFilePath toPath:dbPath error:&error];
		if (!success) {
			////NSLog(@"%@",error);
		}
	}
}

- (NSString *) getDBPath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:dbName];	
}

- (void) getBookList {
  NowLoading *nowLoading = nil;
  UIView *nowLoadingView = nil;
  
  nowLoading = [[[NowLoading alloc] init] retain];
	nowLoadingView = [nowLoading nowloadingView];
  
  [tabBarController.view addSubview:nowLoadingView];
	if (self.ssbDirty == NO) {
		
    StackStockBooks *ssb = [[StackStockBooks alloc] initWithDataAboutDefaultUser];
    self.wishBookArray = ssb.wishBookArray;
    self.unreadBookArray = ssb.unreadBookArray;
    self.readBookArray = ssb.readBookArray;
    self.nowReadBookArray = ssb.nowReadBookArray;
    self.userNo = ssb.userNo;
    [ssb release];
    self.ssbDirty = YES;
    
	}	
  [nowLoading removeNowloadingView:nowLoadingView];
	if ([self.wishBookArray count] == 0 && [self.unreadBookArray count] == 0 && [self.readBookArray count] == 0 && [self.nowReadBookArray count] == 0 ) {
		UIAlertView *alert = [UIAlertView alloc];
		[alert initWithTitle:nil message:NSLocalizedString(@"ユーザーID/APITokenが違うか、本の登録がありません。", nil)
					delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];	
		[alert release];
				
	}
  //[nowLoading release];
  //  [nowLoadingView release];
  
}
@end
