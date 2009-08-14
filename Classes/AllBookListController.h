//
//  BookListController.h
//  iS3
//
//  Created by yanagisawa.n on 11/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IS3AppDelegate;
@class NowLoading;
@class BookController;
@class ImageStore;

@interface AllBookListController : UITableViewController <UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate> {
	IBOutlet UITableView *booksTableView;
	IBOutlet IS3AppDelegate *appDelegate;
	NSMutableArray *books;
	NSData *defaultImage;
	UIActivityIndicatorView *autoloadActivityView;
	NSMutableArray *userArray;	
	UIBarButtonItem *reloadButton;
}

@property (nonatomic, retain) UITableView *booksTableView;
@property (readwrite, assign) IS3AppDelegate *appDelegate;
@property (nonatomic, retain) NSMutableArray *books;
@property (nonatomic, retain) NSData *defaultImage;
@property	(readonly) UIBarButtonItem *reloadButton;

- (NSString *) setNameBySection:(NSInteger)section;
- (void) setArrayBySection:(NSInteger)section;
- (void)setupNavigationBar;
- (NSString *) getBookImageFromAmazonOf:(NSIndexPath *)indexPath;
- (void) refreshBookList;

@end
