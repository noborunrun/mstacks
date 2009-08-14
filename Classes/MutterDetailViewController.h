//
//  MutterDetailViewController.h
//  iS3
//
//  Created by noboru on 6/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageStore;

@interface MutterDetailViewController : UIViewController {

	
	IBOutlet UILabel *userName;
	IBOutlet UIImageView *userImage;
	IBOutlet UILabel *mutterText;
	NSString *userID;
	NSString *mutter;
	NSMutableArray *mutterArray;
	NSMutableArray *userArray;
	NSInteger mutterArrayIndex;
	//ImageStore *imageStore;
	
}

@property (nonatomic, retain) UILabel *userName;
@property (nonatomic, retain) UIImageView *userImage;
@property (nonatomic, retain) UILabel *mutterText;
@property (nonatomic, retain) NSString *userID;
@property (nonatomic, retain) NSString *mutter;
@property (nonatomic, retain) NSMutableArray *mutterArray;
@property (nonatomic, retain) NSMutableArray *userArray;
//@property (nonatomic, retain) NSInteger mutterArrayIndex;
//@property (nonatomic, retain) ImageStore *imageStore;

@end
