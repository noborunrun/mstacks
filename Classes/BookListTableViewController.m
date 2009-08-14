//
//  BookListTableViewController.m
//  iS3
//
//  Created by yanagisawa.n on 12/2/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//


#import "BookListTableViewController.h"
#import "IS3AppDelegate.h"
#import "BookListCell.h"
#import "BookListCellController.h"
#import "NowLoading.h"
#import "BookController.h"
#import "Image.h"

@implementation BookListTableViewController

@synthesize booksTableView;
@synthesize bookList;
@synthesize appDelegate;
@synthesize books;
//@synthesize nowLoading,nowLoadingView;
@synthesize bookController;
@synthesize reloadButton;
@synthesize defaultImage;

BOOL resetCountFlag = NO;
NowLoading *nowLoading = nil;
UIView *nowLoadingView = nil;
NSMutableArray *bookListArray;

- (id)initWithStyle:(UITableViewStyle)style {
	if (self = [super initWithStyle:style]) {
		
	}
	return self;
}

//-(void) loadView {
//	NSLog(@"%d",[appDelegate.nowReadBookArray count]);
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//	NSLog(@"setSection");
	NSInteger count = 0;
	[self setArrayBySection:section];
	count = [books count];
	return count;
}

- (NSString *) setNameBySection:(NSInteger)section {
	NSString *tableHeadertitle = @"";
	if (section == 0) {
		tableHeadertitle = @"Reading";
	}else if (section == 1) {
		tableHeadertitle = @"UnRead";
	}else if (section == 2) {
		tableHeadertitle = @"Wish";
	}else if (section == 3) {
		tableHeadertitle = @"Read";
	}
	return tableHeadertitle;
}

- (void) setArrayBySection:(NSInteger)section {
	if (section == 0) {
		books = appDelegate.nowReadBookArray;
	}else if (section == 1) {
		books = appDelegate.unreadBookArray;
	}else if (section == 2) {
		books = appDelegate.wantBookArray;
	}else if (section == 3) {
		books = appDelegate.readBookArray;
	}	
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	//	NSLog(@"setTitle");
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
		[controller release];
	}		
	//setBookArray
	[self setArrayBySection:indexPath.section];
	
	//set book title
	[cell.bookTitle setText:[NSString stringWithFormat:[[[books objectAtIndex:indexPath.row] objectForKey:@"book"] objectForKey:@"title"]]];
	//set book image
	UIImage *defaultImageData = [[UIImage alloc] initWithData:defaultImage];
	[cell.bookImage setImage:defaultImageData];
	[defaultImageData release];
	return cell;
}

- (void) cell:(BookListCell *)cell indexPath:(NSIndexPath *)indexPath {
	NSMutableString *imageUrl = [[NSMutableString alloc] init];
	imageUrl = [[[books objectAtIndex:indexPath.row] objectForKey:@"book"] objectForKey:@"image_uri"];
	if ([imageUrl isKindOfClass:[NSNull class]]) {
		imageUrl = @"http://stack.nayutaya.jp/images/no_book_image/350.gif";
	}
	NSURL *accessImageURL = [NSURL URLWithString:imageUrl];
	NSData *getImage = [[NSData alloc] initWithContentsOfURL:accessImageURL];
	UIImage *coverImage = [[UIImage alloc] initWithData:getImage];
	[cell.bookImage setImage:coverImage];
	//[accessImageURL release];
	//[imageUrl release];
	[getImage release];
	[coverImage release];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//Initialize the controller.
	if(bookController == nil) {
		bookController = [[BookController alloc] initWithNibName:@"Book" bundle:[NSBundle mainBundle]];
	}
	
	//init
	bookController.tempTitle = @"";
	bookController.imageUrl = @"";
	
	//setup BookView
	[self setArrayBySection:indexPath.section];
	
	NSString *tableHeadertitle = @"";
	tableHeadertitle = [self setNameBySection:indexPath.section];
	
	bookController.title = tableHeadertitle;
	
	bookController.tempTitle = [[[books objectAtIndex:indexPath.row] objectForKey:@"book"] objectForKey:@"title"];
	bookController.imageUrl = [[[books objectAtIndex:indexPath.row] objectForKey:@"book"] objectForKey:@"image_uri"];
	
	//Add the view as a sub view to the current view.
	[[self navigationController] pushViewController:bookController animated:YES];
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
	[defaultImage release];
	[books release];
	[appDelegate release];
	[books release];
	[bookController release];
	[super dealloc];
}


- (void)viewDidLoad {
	bookList = [[NSMutableArray alloc] init];
	[appDelegate getUserSetting];
	[appDelegate getBookList];
	Image *getImage = [[Image alloc] initWIthDefaultImage];
	self.defaultImage = [getImage defaultImage];
	[getImage release];
	
	[self setupNavigationBar];
	
}

- (void)viewWillAppear:(BOOL)animated {
	nowLoading = [[[NowLoading alloc] init] retain];
	nowLoadingView = [nowLoading nowloadingView];
	[self.tableView addSubview:nowLoadingView];	
	
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	
	[nowLoading removeNowloadingView:nowLoadingView];
	
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
	NSLog(@"memory Warning at All");
	[super didReceiveMemoryWarning];
}

- (void)setupNavigationBar {
	
	//reloadButton = [[UIBarButtonItem alloc] 
	//									initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
	//									target:self action:@selector(reloadButton:)];
	//	
	//	[[self navigationItem] setRightBarButtonItem:reloadButton];
}


@end