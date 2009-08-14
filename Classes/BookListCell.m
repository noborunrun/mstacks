//
//  BookListCell.m
//  iS3
//
//  Created by yanagisawa.n on 11/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "BookListCell.h"
#import "BookListCellController.h"
#import "ImageStore.h"

@implementation BookListCell

@synthesize bookTitle;
@synthesize bookAuthor;
@synthesize bookImage;
@synthesize imageStore;
@synthesize imageUrl;
@synthesize defaultBookImage;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		// Initialization code
	}
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  
	[super setSelected:selected animated:animated];
  
	// Configure the view for the selected state
}

- (void)setImageView {
  UIImage *amazonImage = [imageStore getImage:imageUrl];
  ////NSLog(@"%@",[[imageStore getImage:imageUrl] class]);
  self.bookImage.image = amazonImage;
}


//- (void)setImageStore:(ImageStore*)value
//{
//  imageStore = value;
//}
//
//- (ImageStore*)imageStore
//{
//	return imageStore;
//}

- (void)dealloc {
  [bookTitle release];
  [bookAuthor release];
  [bookImage release];
  
	[super dealloc];
}

@end
