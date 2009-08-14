//
//  BookListCellController.h
//  iS3
//
//  Created by yanagisawa.n on 11/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BookListCell;
@class ImageStore;

@interface BookListCellController : UIViewController {
	IBOutlet BookListCell *cell;
	ImageStore *imageStore;
	NSData *defaultImage;
  NSString *imageUrl;
}

@property (nonatomic, retain) BookListCell *cell;
@property (nonatomic, retain) ImageStore *imageStore;
@property (nonatomic, retain) NSData *defaultImage;
@property (nonatomic, retain) NSString *imageUrl;

@end
