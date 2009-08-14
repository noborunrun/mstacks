//
//  mutterController.h
//  iS3
//
//  Created by noboru on 1/22/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IS3AppDelegate;
@class ImageStore;

@interface MutterController : UITableViewController <UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate> {
  NSMutableArray *mutterList;
  IBOutlet IS3AppDelegate *appDelegate;
ImageStore *imageStore;
	
}

@property (nonatomic, retain) NSMutableArray *mutterList;
@property (readwrite, assign) IS3AppDelegate *appDelegate;
@property (nonatomic, retain) ImageStore *imageStore;

- (void)separateMutterArrayToMineOrOthers;

@end
