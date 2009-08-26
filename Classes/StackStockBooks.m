//
//  StackStockBooks.m
//  iS3
//
//  Created by noboru on 11/8/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "StackStockBooks.h"
#import "IS3AppDelegate.h"
#import "Reachability.h"

@implementation StackStockBooks

@synthesize readBookArray;
@synthesize unreadBookArray;
@synthesize wishBookArray;
@synthesize nowReadBookArray;
@synthesize mutterArray;
@synthesize bookInfoArray;
@synthesize userInfoArray;
@synthesize userNo;

@synthesize isDirty, isDetailViewHydrated;

NSMutableArray *readbooks,*unReadbooks,*wishbooks, *nowReadbooks;
static NSString *userID;
IS3AppDelegate *appDelegate;
NSInteger pagination;
NSInteger pageCount;
NSMutableArray *mutter;
NSMutableArray *bookInfo;
NSMutableArray *userInfo;

/* method of regist books */
- (NSString *)jsonGeneratorWith:(NSArray *)convertArray {
  SBJSON *sbjson = [[SBJSON alloc] init];
  NSError *error;
  sbjson.humanReadable = YES;
  return [sbjson stringWithObject:convertArray error:&error];
}

- (void)updateMyStacksWith:(NSArray *)bookArray {
  NSString *jsonString;
  jsonString = [self jsonGeneratorWith:bookArray];
  //jsonString = @"[{\"asin\": \"479810714X\",\"state\": \"reading\"}]";
  NSMutableData *postData = [[NSMutableData alloc] init];
  NSString *requestString = [@"request=" stringByAppendingString:
                             [jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                             ];
  [postData setData:[requestString dataUsingEncoding:NSUTF8StringEncoding]];
  
  NSString *url = [[NSString alloc] init];
  NSURL *accessURL;
  url = [[[[@"http://stack.nayutaya.jp/api/" stringByAppendingString:appDelegate.userId]
           stringByAppendingString:@"/"] stringByAppendingString:appDelegate.APIToken] 
         stringByAppendingString:@"/stocks/update.1"];
  ////NSLog(@"%@",requestString);
  accessURL = [NSURL URLWithString:url];
  NSMutableURLRequest *postRequest = [[NSMutableURLRequest alloc] init];
  //set Request Property
  [postRequest setHTTPMethod:@"POST"];
  [postRequest setURL:accessURL];
	[postRequest setValue:@"mStacks.v1.0" forHTTPHeaderField: @"User-Agent"];
  [postRequest setHTTPBody:postData];
  
  NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:postRequest delegate:self];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	NSString *messageTitle = @"書籍変更";
  NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  SBJSON *jsonParser = [[SBJSON alloc] init];
	NSError *error;
	
	//Jsonを変換
	NSDictionary *parsed = [jsonParser objectWithString:responseString error:&error];
  ////NSLog(@"%@",[parsed objectForKey:@"message"]);
	UIAlertView *alert = [UIAlertView alloc];
	if ([parsed objectForKey:@"success"] == @"1") {
		
		
		[alert initWithTitle:messageTitle message:NSLocalizedString([parsed objectForKey:@"完了しました。"], nil)
								delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
	}else {
		[alert initWithTitle:messageTitle message:NSLocalizedString([parsed objectForKey:@"message"], nil)
								delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
	}
	[alert show];	
	[alert release];
	
}
//- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse {
//  
//}

- (void)initWithUpdateStatusWith:(NSArray *)bookArray {
  [super init];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:)
                                               name:@"kNetworkReachabilityChangedNotification" object:nil];
  if ([self refleshIfNeeded]){
    
    if (!appDelegate) {
      appDelegate = (IS3AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    [self updateMyStacksWith:bookArray];
  }  
}


/* method of read books */
- (id)jsonPerserWith:(NSString *)jsonString KindOf:(NSInteger)jsonType {
	SBJSON *jsonParser = [[SBJSON alloc] init];
	NSError *error;
	
	//Jsonを変換
	NSDictionary *parsed = [jsonParser objectWithString:jsonString error:&error];
	NSDecimalNumber *number =[[parsed objectForKey:@"pagination"] objectForKey:@"total_pages"];
	pagination = [number integerValue];
	//[number release];
	NSDictionary *httpResponse = [parsed objectForKey:@"response"];
  NSArray *list;
  switch (jsonType) {
    case 0://get User Books
      userNo = [[[httpResponse objectForKey:@"user"] objectForKey:@"user_id"] intValue];
      list = [httpResponse objectForKey:@"stocks"];
      break;
    case 1://get Mutter of Books
      list = [httpResponse objectForKey:@"mumbles"];
      break;
	  case 2://get BookInfo,otherUserInfo
		  list = httpResponse;
//		  list = [httpResponse objectForKey:@"book"];
		  break;
	  case 3:
		  break;
    default:
      list = httpResponse;
      break;
  }
	[jsonParser release];
	
	//NSLog(@"%@",list);
	return list;
}

- (id) initWithDataAboutUser:(NSString *)user {
	[super init];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:)
                                               name:@"kNetworkReachabilityChangedNotification" object:nil];
  if ([self refleshIfNeeded]){
    
  }
	return self;
	
}

- (id) initWIthDataAboutBook:(NSString *)BookID {
	[super init];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:)
                                               name:@"kNetworkReachabilityChangedNotification" object:nil];
  if ([self refleshIfNeeded]){
  }
	return self;
	
}


- (id) initWithDataAboutDefaultUser {
	[super init];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:)
                                               name:@"kNetworkReachabilityChangedNotification" object:nil];
  if ([self refleshIfNeeded]){
    
    [self setBookList];
  }
	return self;
}

- (id) initWithDataAboutMutterOfBookID:(NSString *)BookID {
  [super init];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:)
                                               name:@"kNetworkReachabilityChangedNotification" object:nil];
  if ([self refleshIfNeeded]){
    
    pagination = 0;
    pageCount = 0;
    mutter = [[NSMutableArray alloc] init];
    [self getMutterWithBookID:BookID];
    
    mutterArray = mutter;
    //NSLog(@"%@",mutterArray);
  }
  return self;
}

- (id) initWithGetBookInfoOfISBN:(NSString *)isbn {
	
	[super init];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:)
												 name:@"kNetworkReachabilityChangedNotification" object:nil];
	if ([self refleshIfNeeded]){
		bookInfo = [[NSMutableArray alloc] init];
	[self getBookInfoWithISBN:isbn];
		bookInfoArray = bookInfo;
		
	}
}

- (id) initWithGetUserInfoOfUserID:(NSDecimalNumber *)userID {
  [super init];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:)
                                               name:@"kNetworkReachabilityChangedNotification" object:nil];
	if ([self refleshIfNeeded]){
    userInfo = [[NSMutableArray alloc] init];
  [self getUserInfoWithUserID:userID];
  userInfoArray = userInfo;
  }
	return self; 
}

- (void) dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
	[super dealloc];
}

- (void) getMutterWithBookID:(NSString *)ISBN {
  pageCount += 1;
  NSString *url = [[NSString alloc] init];
  NSURL *accessURL;
  NSString *jsonString;
  url = [[@"http://stack.nayutaya.jp/api/book/isbn13/" stringByAppendingString:ISBN] stringByAppendingString:@"/mumbles.json"];
  accessURL = [NSURL URLWithString:url];
  jsonString = [[NSString alloc] initWithContentsOfURL:accessURL encoding:NSUTF8StringEncoding error:nil];
  [mutter addObjectsFromArray:[self jsonPerserWith:jsonString KindOf:1]];
  if (pageCount < pagination) {
    [self getMutterWithBookID:ISBN];
  }
}

- (NSString *) addApiTokenWithURL:(NSString *)url {
	////NSLog(@"%@",appDelegate.APIToken);
	if (appDelegate.APIToken != NULL) {
		url = [url stringByAppendingString:@"&api_user="];
		url = [url stringByAppendingString:appDelegate.userId];
		url = [url stringByAppendingString:@"&api_token="];
		url = [url stringByAppendingString:appDelegate.APIToken];
		////NSLog(@"%@",url);
		
	}
	return url;
}

- (void)getReadBookListWithURL:(NSString *)fixUrl {
	pageCount += 1;
	NSString *url = [[NSString alloc] init];
	NSURL *accessURL;
	NSString *jsonString;
	//NSMutableArray *readbooks;
	url =  [
					[fixUrl stringByAppendingString:@"read.json?include_books=true&include_authors=true&order=stock_updated_desc&page="] 
					stringByAppendingFormat:@"%d",pageCount];
	
	url = [self addApiTokenWithURL:url];
	accessURL = [NSURL URLWithString:url];
	jsonString = [[NSString alloc] initWithContentsOfURL:accessURL encoding:NSUTF8StringEncoding error:nil];
	[readbooks addObjectsFromArray: [self jsonPerserWith:jsonString KindOf:0]];
	if (pageCount < pagination) {
		[self getReadBookListWithURL:fixUrl];
	}
}

- (void)getWishBookListWithURL:(NSString *)fixUrl {
	pageCount += 1;
	NSString *url = [[NSString alloc] init];
	NSURL *accessURL;
	NSString *jsonString;
	url =  [
					[fixUrl stringByAppendingString:@"wish.json?include_books=true&include_authors=true&order=stock_updated_desc&page="]
					stringByAppendingFormat:@"%d",pageCount];
	url = [self addApiTokenWithURL:url];
	accessURL = [NSURL URLWithString:url];
	jsonString = [[NSString alloc] initWithContentsOfURL:accessURL encoding:NSUTF8StringEncoding error:nil];
	//convert json to array
	[wishbooks addObjectsFromArray: [self jsonPerserWith:jsonString KindOf:0]];
	if (pageCount < pagination) {
		[self getWishBookListWithURL:fixUrl];
	}	
}

- (void)getUnreadBookListWithURL:(NSString *)fixUrl {
	pageCount += 1;
	NSString *url = [[NSString alloc] init];
	NSURL *accessURL;
	NSString *jsonString;
	
	url =  [
					[fixUrl stringByAppendingString:@"unread.json?include_books=true&include_authors=true&order=stock_updated_desc&page="]
					stringByAppendingFormat:@"%d",pageCount];
	
	url = [self addApiTokenWithURL:url];
	accessURL = [NSURL URLWithString:url];
	jsonString = [[NSString alloc] initWithContentsOfURL:accessURL encoding:NSUTF8StringEncoding error:nil];
	//convert json to array
	[unReadbooks  addObjectsFromArray: [self jsonPerserWith:jsonString KindOf:0]];
	if (pageCount < pagination) {
		[self getUnreadBookListWithURL:fixUrl];
	}	
}

- (void)getReadingBookListWithURL:(NSString *)fixUrl {
	pageCount += 1;
	NSString *url = [[NSString alloc] init];
	NSURL *accessURL;
	NSString *jsonString;
	url =  [
					[fixUrl stringByAppendingString:@"reading.json?include_books=true&include_authors=true&order=stock_updated_desc&page="]
					stringByAppendingFormat:@"%d",pageCount];
	url = [self addApiTokenWithURL:url];
	accessURL = [NSURL URLWithString:url];
	jsonString = [[NSString alloc] initWithContentsOfURL:accessURL encoding:NSUTF8StringEncoding error:nil];
	//convert json to array
	[nowReadbooks addObjectsFromArray: [self jsonPerserWith:jsonString KindOf:0]];
	if (pageCount < pagination) {
		[self getReadingBookListWithURL:fixUrl];
	}	
}

- (void) setBookList {
	
	appDelegate = (IS3AppDelegate *)[[UIApplication sharedApplication] delegate];
	if (appDelegate.ssbDirty == NO) {
		
    userID = appDelegate.userId;
    NSString *fixUrl = [[[[NSString alloc] initWithString:@"http://stack.nayutaya.jp/api/user/name/"] stringByAppendingString:userID]
                        stringByAppendingString:@"/stocks/"];
    int i=0;
    while (i < 4) {
      switch (i) {
        case 0:
					pagination = 0;
					pageCount = 0;
					readbooks = [[NSMutableArray alloc] init];
					[self getReadBookListWithURL:fixUrl];
          break;
        case 1:
					pagination = 0;
					pageCount = 0;
					unReadbooks = [[NSMutableArray alloc] init];
					[self getUnreadBookListWithURL:fixUrl];
          break;
        case 2:
					pagination = 0;
					pageCount = 0;
					wishbooks = [[NSMutableArray alloc] init];					
					[self getWishBookListWithURL:fixUrl];
          break;
        case 3:
					pagination = 0;
					pageCount = 0;
					nowReadbooks = [[NSMutableArray alloc] init];
					[self getReadingBookListWithURL:fixUrl];
          break;
        default:
          break;
      }
      i+=1;
    }
    //getReadBooks  
    self.readBookArray = readbooks;
    [readbooks release];
    //getUnreadBooks
    self.unreadBookArray = unReadbooks;
    [unReadbooks release];
    //getwantbooks
    self.wishBookArray = wishbooks;
    [wishbooks release];
    //getNowReadBooks
    self.nowReadBookArray = nowReadbooks;
    [nowReadbooks release];
    //	[url release];
		appDelegate.ssbDirty = YES;
	}
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

- (void)getBookInfoWithISBN:(NSString *)isbn {

	NSString *url = [[NSString alloc] initWithString:@"http://stack.nayutaya.jp/api/book/"];
	NSURL *accessURL;
	NSString *jsonString;
	
	switch (isbn.length) {
		case 10:
			url =  [
					[
					 [url stringByAppendingString:@"isbn10/"]
					  stringByAppendingString:isbn]
						stringByAppendingString:@".json?include_authors=true"];

			break;
		case 13:
			url =  [
					[
					 [url stringByAppendingString:@"isbn13/"]
					  stringByAppendingString:isbn]
						stringByAppendingString:@".json?include_authors=true"];
//						stringByAppendingString:@".json"];
			break;
		default:
			break;
	}
	
	//NSLog(@"%@",url);
	accessURL = [NSURL URLWithString:url];
	jsonString = [[NSString alloc] initWithContentsOfURL:accessURL encoding:NSUTF8StringEncoding error:nil];
	//convert json to array
	[bookInfo addObjectsFromArray: [self jsonPerserWith:jsonString KindOf:2]];
	
}

- (void) getUserInfoWithUserID:(NSDecimalNumber *)userID {
  NSURL *accessURL;
	NSString *jsonString;
  NSString *url = [[NSString alloc] initWithString:@"http://stack.nayutaya.jp/api/user/id/"];
  url = [[url stringByAppendingString:[userID stringValue]] stringByAppendingString:@".json?"];
//  //NSLog(@"%@",url);
  accessURL = [NSURL URLWithString:url];
  jsonString = [[NSString alloc] initWithContentsOfURL:accessURL encoding:NSUTF8StringEncoding error:nil];
  NSLog(@"%@",jsonString);
  [userInfo addObjectsFromArray: [self jsonPerserWith:jsonString KindOf:2]];
  NSLog(@"%@",userInfo);
}

//- (id)getBookInfoWithISBN:(NSString *)isbn13 I {
//	
//}

@end
