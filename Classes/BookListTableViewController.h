//
//  BookListTableViewController.h
//  iS3
//
//  Created by yanagisawa.n on 12/2/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IS3AppDelegate;
@class NowLoading;
@class BookController;


@interface BookListTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate> {
	IBOutlet UITableView *booksTableView;
	IBOutlet IS3AppDelegate *appDelegate;
	NSMutableArray *books;
	NSData *defaultImage;
	UIActivityIndicatorView *autoloadActivityView;
	NSMutableArray *bookList;
	//nowLoading
	//UIView *nowLoadingView;
	//NowLoading *nowLoading;
	//Book
	BookController *bookController;
	
	UIBarButtonItem *reloadButton;
}

@property (nonatomic, retain) UITableView *booksTableView;
@property (readwrite, assign) IS3AppDelegate *appDelegate;
@property (nonatomic, retain) NSMutableArray *books;
@property (nonatomic, retain) NSData *defaultImage;
//@property (nonatomic, retain) NowLoading *nowLoading;
@property (nonatomic, retain) NSMutableArray *bookList;
//@property (nonatomic, retain) UIView *nowLoadingView;
@property (nonatomic, retain) BookController *bookController;
@property	(readonly) UIBarButtonItem *reloadButton;

//- (UIView*)nowloadingView;
//- (void)removeNowloadingView;
- (NSString *) setNameBySection:(NSInteger)section;
- (void) setArrayBySection:(NSInteger)section;
- (void)setupNavigationBar;

@end
