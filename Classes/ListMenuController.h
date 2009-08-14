//
//  ListMenuController.h
//  iS3
//
//  Created by noboru on 12/27/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IS3AppDelegate;

@interface ListMenuController : UITableViewController {
  IBOutlet UITableView *menuTableView;
	IBOutlet IS3AppDelegate *appDelegate;
}

@property (readwrite, assign) IS3AppDelegate *appDelegate;

- (BOOL)refleshIfNeeded;

@end
