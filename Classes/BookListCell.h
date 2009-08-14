//
//  BookListCell.h
//  iS3
//
//  Created by yanagisawa.n on 11/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageStore;
@class BookListCellController;

@interface BookListCell : UITableViewCell {
	IBOutlet UILabel *bookTitle;
	IBOutlet UILabel *bookAuthor;
	IBOutlet UIImageView *bookImage;
	ImageStore *imageStore;
	BookListCellController *view;
	 NSString *imageUrl;
  NSData *defaultBookImage;
}

@property (nonatomic, retain) UILabel *bookTitle;
@property (nonatomic, retain) UILabel *bookAuthor;
@property (nonatomic, retain) UIImageView *bookImage;
@property (nonatomic, retain) ImageStore *imageStore;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSData *defaultBookImage;

- (void)setImageView;

@end
