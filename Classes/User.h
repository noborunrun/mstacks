//
//  user.h
//  iS3
//
//  Created by noboru on 11/6/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class IS3AppDelegate;

@interface User : NSObject {
	NSInteger userNo;
	NSString *userId;
	NSDecimalNumber *APIToken;
	
	//Intrnal variables to keep track of the state of the object.
	BOOL isDirty;
	BOOL isDetailViewHydrated;
}
@property (nonatomic, readonly) NSInteger userNo;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSDecimalNumber *APIToken;

@property (nonatomic, readwrite) BOOL isDirty;
@property (nonatomic, readwrite) BOOL isDetailViewHydrated;

//Static methods.
+ (void) getInitialDataToDisplay:(NSString *)dbPath;
//+ (void) finalizeStatements;

//Instance methods.
- (id) initWithPrimaryKey:(NSInteger)pk;
- (void) addUserWith:(NSArray *)insertArray;
@end
