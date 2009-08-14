//
//  iS3AppDelegate.h
//  iS3
//
//  Created by yanagisawa.n on 11/7/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@class StackStockBooks;
@class SettingController;
@class AllBookListController;
@class ReadBooksListController;
@class WishBooksListController;
@class UnReadBooksListController;
@class ReadingBooksListController;
@class InputViewController;
@class NowLoading;

@interface IS3AppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet UITabBarController *tabBarController;
	IBOutlet AllBookListController *allBookListController;
	IBOutlet SettingController *SettingController;
  IBOutlet InputViewController *inputViewController;
	IBOutlet ReadBooksListController *readBookListController;
	IBOutlet WishBooksListController *wishBookListController;
	IBOutlet UnReadBooksListController *unReadBookListController;
	IBOutlet ReadingBooksListController *readingBookListController;
	NSMutableArray *userArray;
  
	NSMutableArray *readBookArray;
	NSMutableArray *unreadBookArray;
	NSMutableArray *wishBookArray;
	NSMutableArray *nowReadBookArray;
	NSArray *selectItem;
//	NSArray 
	
  NSInteger userNo;
  NSString *userId;
	NSString *APIToken;
	BOOL ssbDirty;
  BOOL userChange;
  BOOL statusChange;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;

@property (nonatomic, retain) NSMutableArray *userArray;

@property (nonatomic, retain) NSMutableArray *readBookArray;
@property (nonatomic, retain) NSMutableArray *unreadBookArray;
@property (nonatomic, retain) NSMutableArray *wishBookArray;
@property (nonatomic, retain) NSMutableArray *nowReadBookArray;

@property (nonatomic) NSInteger userNo;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *APIToken;
@property (readwrite) BOOL ssbDirty;
@property (readwrite)   BOOL userChange;
@property (readwrite) BOOL statusChange;
@property (nonatomic, retain) NSArray *selectItem;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;
- (void) getUserSetting;
- (void) getBookList;
@end

