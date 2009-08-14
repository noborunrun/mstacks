//
//  BookListController.m
//  iS3
//
//  Created by yanagisawa.n on 11/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AllBookListController.h"
#import "IS3AppDelegate.h"
#import "BookListCell.h"
#import "BookListCellController.h"
#import "NowLoading.h"
#import "BookController.h"
#import "Image.h"
#import "ImageStore.h"

@implementation AllBookListController

@synthesize booksTableView;
@synthesize appDelegate;
@synthesize books;
@synthesize reloadButton;
@synthesize defaultImage;

BOOL resetCountFlag = NO;
NowLoading *nowLoading = nil;
UIView *nowLoadingView = nil;
NSMutableArray *bookListArray;
BOOL showFirst = YES;
BookController *bookController;
ImageStore *imageStore;
NSInteger bookArrayCount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		appDelegate = (IS3AppDelegate *)[[UIApplication sharedApplication] delegate];
	}
	return self;
}

- (id)initWithStyle:(UITableViewStyle)style {
	if (self = [super initWithStyle:style]) {
  }
	return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//	////NSLog(@"setSection");
  bookArrayCount = 0;
	[self setArrayBySection:section];
	bookArrayCount = [books count];
	return bookArrayCount;
}

//@"いつか欲しい",@"今読んでいる",@"まだ読んでいない",@"もう読み終えた",nil

- (NSString *) setNameBySection:(NSInteger)section {
	NSString *tableHeadertitle = @"";
		
	switch (section) {
    case 0:
      tableHeadertitle = [[appDelegate.selectItem objectAtIndex:2] stringByAppendingFormat:@"(%d)",bookArrayCount];
      break;
    case 1:
      tableHeadertitle = [[appDelegate.selectItem objectAtIndex:1] stringByAppendingFormat:@"(%d)",bookArrayCount];
      break;
    case 2:
      tableHeadertitle = [[appDelegate.selectItem objectAtIndex:0] stringByAppendingFormat:@"(%d)",bookArrayCount];
      break;
    case 3:
      tableHeadertitle = [[appDelegate.selectItem objectAtIndex:3] stringByAppendingFormat:@"(%d)",bookArrayCount];
    default:
      break;
  }
	return tableHeadertitle;
}

- (void) setArrayBySection:(NSInteger)section {
	if (section == 0) {
		books = appDelegate.nowReadBookArray;
	}else if (section == 1) {
		books = appDelegate.unreadBookArray;
	}else if (section == 2) {
		books = appDelegate.wishBookArray;
	}else if (section == 3) {
		books = appDelegate.readBookArray;
	}	
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	//	////NSLog(@"setTitle");
	NSString *tableHeadertitle = @"";
	tableHeadertitle = [self setNameBySection:section];
  
	return tableHeadertitle;	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"BookListCell";
	BookListCell *cell = (BookListCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
  
	if (cell == nil) {
    BookListCellController *controller = [[BookListCellController alloc] initWithNibName:MyIdentifier bundle:nil];
		cell = (BookListCell *)controller.view;
		
		//cell = [[[BookListCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
		UIImage *defaultImageData = [[UIImage alloc] initWithData:defaultImage];
    cell.defaultBookImage = defaultImageData;
		[defaultImageData release];
		cell.imageStore = imageStore;
  }		
	//setBookArray
	[self setArrayBySection:indexPath.section];
	
  NSString *imageUrlString = [[NSString alloc] initWithString:[self getBookImageFromAmazonOf:indexPath]];
  cell.imageUrl = imageUrlString;
  [cell setImageView];
  [imageUrlString release];
	//set book title
  NSString *bookTitle = [[NSString alloc] initWithString:[[[books objectAtIndex:indexPath.row] objectForKey:@"book"] objectForKey:@"title"]];
  
	[cell.bookTitle setText:bookTitle];
  [bookTitle release];
  
	return cell;  
}

- (NSString *) getBookImageFromAmazonOf:(NSIndexPath *)indexPath {
  NSMutableString *imageUrl = [[[NSMutableString alloc] init] autorelease];
 	imageUrl = [[[books objectAtIndex:indexPath.row] objectForKey:@"book"] objectForKey:@"image_uri"];
  
	if ([imageUrl isKindOfClass:[NSNull class]]) {
		imageUrl = @"http://stack.nayutaya.jp/images/no_book_image/50.gif";
	} else {
    NSArray *separateArray = [[NSArray alloc] initWithArray:[imageUrl componentsSeparatedByString:@"_"]];
    imageUrl = [[separateArray objectAtIndex:0] stringByAppendingString:@"SL40_.jpg"];
    [separateArray release];
  }
  [imageStore getImage:imageUrl];
  
  return imageUrl;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  //Initialize the controller.
    bookController = [[BookController alloc] initWithNibName:@"Book" bundle:[NSBundle mainBundle]];
  
  //setup BookView
	[self setArrayBySection:indexPath.section];
  
  NSString *tableHeadertitle = @"";
  tableHeadertitle = [self setNameBySection:indexPath.section];
  
  bookController.title = tableHeadertitle;
  
  //set author
  NSMutableString *author = @"";
  int i = 0;
  for (i=0;i<[[[[books objectAtIndex:indexPath.row] objectForKey:@"book"] objectForKey:@"authors"] count];i++) {
    if (i != 0) {
      author = [author stringByAppendingString:@","];
    }
    author = [author stringByAppendingString:[[[[[books objectAtIndex:indexPath.row] objectForKey:@"book"] objectForKey:@"authors"] objectAtIndex:i] objectForKey:@"name"]];
    
  }
  
  bookController.tempTitle = [[[books objectAtIndex:indexPath.row] objectForKey:@"book"] objectForKey:@"title"];
  bookController.imageUrl = [[[books objectAtIndex:indexPath.row] objectForKey:@"book"] objectForKey:@"image_uri"];
  bookController.bookISBN = [[[books objectAtIndex:indexPath.row] objectForKey:@"book"] objectForKey:@"isbn13"];
  bookController.bookISBN10 = [[[books objectAtIndex:indexPath.row] objectForKey:@"book"] objectForKey:@"isbn10"];
  bookController.bookAuthor = author;
  bookController.bookPublisher = [[[books objectAtIndex:indexPath.row] objectForKey:@"book"] objectForKey:@"publisher"];
  bookController.bookDateOfIsues = [[[books objectAtIndex:indexPath.row] objectForKey:@"book"] objectForKey:@"release_date"]; 
  //Add the view as a sub view to the current view.
  [bookController setLabel];
  [[self navigationController] pushViewController:bookController animated:YES];
  [bookController release];
}

/*
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 }
 if (editingStyle == UITableViewCellEditingStyleInsert) {
 }
 }
 */
/*
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */
/*
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */
/*
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

- (void)dealloc {
	//[imageStore release];
	//[booksTableView release];
	//[appDelegate release];
	[defaultImage release];
	[autoloadActivityView release];
	//[bookController release];
	[userArray release];
	[reloadButton release];
  [showFirst release];
  //[books release];
	[super dealloc];
}

- (void)viewDidLoad {
	if (imageStore == nil) {
    imageStore = [[ImageStore alloc] initWithDelegate:self];
	}
  
	[appDelegate getUserSetting];
//  if ([appDelegate.wishBookArray count] == 0 && [appDelegate.readBookArray count] == 0 && [appDelegate.unreadBookArray count] == 0 && [appDelegate.nowReadBookArray count] == 0) {
//		UIAlertView *alert = [UIAlertView alloc];
//		[alert initWithTitle:nil message:NSLocalizedString(@"ユーザーID/APITokenが違うか、本の登録がありません。", nil)
//								delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		[alert show];	
//		[alert release];
//		
//		[self.view removeFromSuperview];
//	}else{
		
		
	Image *getImage = [[Image alloc] initWIthDefaultImage];
	self.defaultImage = [getImage defaultImage];
	[getImage release];
	
	[self setupNavigationBar];
//	}
  
}

- (void)viewWillAppear:(BOOL)animated {
  if (imageStore == nil) {
    imageStore = [[ImageStore alloc] initWithDelegate:self];
	}
  imageStore.delegate = self;
  
  if (nowLoading == nil) {
    nowLoading = [[[NowLoading alloc] init] retain];
    nowLoadingView = [nowLoading nowloadingView];
    [self.tableView addSubview:nowLoadingView];	
  }
  if (showFirst == YES) {
    [appDelegate getBookList];
    showFirst = NO;
  }
  if (appDelegate.userChange == YES || appDelegate.statusChange == YES) {
    [self refreshBookList];
    appDelegate.userChange = NO;
    appDelegate.statusChange = NO;
    [self viewDidLoad];
    [self.tableView reloadData];
  }
	[super viewWillAppear:animated];
   
}

-(void) refreshBookList {
  [appDelegate getBookList];
}

- (void)viewDidAppear:(BOOL)animated {
  
	[nowLoading removeNowloadingView:nowLoadingView];
	nowLoading = nil;
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  imageStore.delegate = nil;
  imageStore = nil;
  [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
	////NSLog(@"memory Warning at All");
	[super didReceiveMemoryWarning];
}

- (void)imageStoreDidGetNewImage:(ImageStore*)sender url:(NSString*)url
{
  if (self.tableView) {    
	[self.tableView reloadData];
  }

}

- (void)setupNavigationBar {
	
	//reloadButton = [[UIBarButtonItem alloc] 
  //									initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
  //									target:self action:@selector(reloadButton:)];
  //	
  //	[[self navigationItem] setRightBarButtonItem:reloadButton];
}

@end