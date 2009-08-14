//
//  user.m
//  iS3
//
//  Created by noboru on 11/6/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "User.h"
#import "IS3AppDelegate.h"

@implementation User
@synthesize userNo,userId, APIToken, isDirty, isDetailViewHydrated;

static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *addStmt = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *selectstmt = nil;


//valid

+ (void) getInitialDataToDisplay:(NSString *)dbPath {
	
	IS3AppDelegate *appDelegate = (IS3AppDelegate *)[[UIApplication sharedApplication] delegate];
	appDelegate.userId = @"";
	appDelegate.APIToken = @"";
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "SELECT USER_NO,USER_ID,API_TOKEN FROM USER";
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			if (sqlite3_step(selectstmt) == SQLITE_ROW) {
				sqlite3_reset(selectstmt);
				while(sqlite3_step(selectstmt) == SQLITE_ROW) {
					
					NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
					User *userObj = [[User alloc] initWithPrimaryKey:primaryKey];
					//				userObj.userId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
					//									userObj.APIToken = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt,2)];
					userObj.isDirty = NO;
					
					appDelegate.userId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
					appDelegate.APIToken = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
					
					[appDelegate.userArray addObject:userObj];
					[userObj release];
				}
			}else{
				appDelegate.userId = @"";
				appDelegate.APIToken = @"";
			}
		}
	}
	else {
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
	}
}


- (id) initWithPrimaryKey:(NSInteger) pk {
	
	[super init];
	userNo = pk;
	
	isDetailViewHydrated = NO;
	
	return self;
}

- (void) addUserWith:(NSArray *)insertArray {
	const char *deleteSQL = "delete from USER";
	if(sqlite3_prepare_v2(database, deleteSQL, -1, &deleteStmt, NULL) != SQLITE_OK){
		NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
	}
	
	
	if (SQLITE_DONE != sqlite3_step(deleteStmt))
		NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
	
	sqlite3_reset(deleteStmt);
	
	if(addStmt == nil) {
		const char *sql = "insert into User(USER_ID, API_TOKEN) Values(?, ?)";
		//const char *sql = "insert into User(USER_ID) Values(?)";
		if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
	}
	
	sqlite3_bind_text(addStmt, 1, [[insertArray objectAtIndex:0] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 2, [[insertArray objectAtIndex:1] UTF8String], -1, SQLITE_TRANSIENT);
	
	if(SQLITE_DONE != sqlite3_step(addStmt))
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
	else
		//SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
		//coffeeID = sqlite3_last_insert_rowid(database);
		
		//Reset the add statement.
		sqlite3_reset(addStmt);
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Setting" message:NSLocalizedString(@"登録しました。", nil)
																								 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];	
	[alert release];
	
}

+ (void) finalizeStatements {
	
	if(database) sqlite3_close(database);
	if(deleteStmt) sqlite3_finalize(deleteStmt);
	if(addStmt) sqlite3_finalize(addStmt);
}

- (void) dealloc {
	
	[userId release];
	[APIToken release];
	[super dealloc];
}

@end
