//
//  Image.m
//  iS3
//
//  Created by noboru on 11/29/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Image.h"

@implementation Image

NSData *defaultImage = nil;

- (id) initWIthDefaultImage {
	if (self = [super init]) {
		[self setDefaultImage];
	}
	return self;
}

- (NSData *) getImageFromWebWithURL:(NSString *)url {
  NSURL *accessImageURL = nil;
  NSMutableData *getImage = nil;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
  accessImageURL = [NSURL URLWithString:(NSString *)url];
  getImage = [[[NSMutableData alloc] initWithContentsOfURL:accessImageURL] autorelease];
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  
  return getImage;
}

- (void) setDefaultImage {
	if ([defaultImage length] < 1 ){
		defaultImage = [[NSData alloc] init];
		NSURL *accessImageURL = [NSURL URLWithString:@"http://stack.nayutaya.jp/images/no_book_image/50.gif"];
		defaultImage = [[NSMutableData alloc] initWithContentsOfURL:accessImageURL];
	}
}

- (NSData *) defaultImage {
	return defaultImage;
}

- (NSString *) getLargeSizeImageWithURL:(NSString *)imageURL {
	NSArray *separateArray = [[NSArray alloc] initWithArray:[imageURL componentsSeparatedByString:@"_"]];
	imageURL = [[separateArray objectAtIndex:0] stringByAppendingString:@"jpg"];
  //	////NSLog(@"%@",imageURL);
	[separateArray release];
	return imageURL;
}

- (void)dealloc {
	[super dealloc];
}

@end
