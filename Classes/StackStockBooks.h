//
//  StackStockBooks.h
//  iS3
//
//  Created by noboru on 11/8/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JSON/JSON.h>

@class IS3AppDelegate;
//@class AllBookListController;

@interface StackStockBooks : NSObject {
	//NSMutableArray *bookList;
	NSMutableArray *readBookArray;
	NSMutableArray *unreadBookArray;
	NSMutableArray *wishBookArray;
	NSMutableArray *nowReadBookArray;
  NSMutableArray *mutterArray;
	NSMutableArray *bookInfoArray;
  NSMutableArray *userInfoArray;
	BOOL isDirty;
	BOOL isDetailViewHydrated;
  NSInteger userNo;
}

//@property (nonatomic, retain) NSMutableArray *bookList;
@property (nonatomic, retain) NSMutableArray *readBookArray;
@property (nonatomic, retain) NSMutableArray *unreadBookArray;
@property (nonatomic, retain) NSMutableArray *wishBookArray;
@property (nonatomic, retain) NSMutableArray *nowReadBookArray;
@property (nonatomic, retain) NSMutableArray *mutterArray;
@property (nonatomic, retain) NSMutableArray *bookInfoArray;
@property (nonatomic, retain) NSMutableArray *userInfoArray;
@property (nonatomic, readwrite) BOOL isDirty;
@property (nonatomic, readwrite) BOOL isDetailViewHydrated;
@property (nonatomic) NSInteger userNo;

//+ (void)getBookList;
- (id)jsonPerserWith:(NSString *)jsonString KindOf:(NSInteger)jsonType;
- (id) initWIthDataAboutBook:(NSString *)BookID;
- (id) initWithDataAboutUser:(NSString *)user;
- (id) initWithDataAboutDefaultUser;
- (id)initWithDataAboutMutterOfBookID:(NSString *)BookID;
- (void)initWithUpdateStatusWith:(NSArray *)bookArray;
- (id) initWithGetBookInfoOfISBN:(NSString *)isbn;
- (void) setBookList;
- (void)getReadBookListWithURL:(NSString *)fixUrl;
- (void)getWishBookListWithURL:(NSString *)fixUrl;
- (void)getUnreadBookListWithURL:(NSString *)fixUrl;
- (void)getReadingBookListWithURL:(NSString *)fixUrl;
- (void) getMutterWithBookID:(NSString *)ISBN;

@end
