//
//  SSBGenerateUrl.m
//  iS3
//
//  Created by noboru on 8/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SSBGenerateUrl.h"


@implementation SSBGenerateUrl

@synthesize URL;
- (id) setWebViewToInputBooks {
	
	URL = @"http://stack.nayutaya.jp/books/stock";
  
	NSURL *accessURL;
	NSXMLParser *xmlString;
	accessURL = [NSURL URLWithString:URL];
	//xmlString = [[NSXMLParser alloc] initWithContentsOfURL:accessURL encoding:NSUTF8StringEncoding error:nil];
	xmlString = [[NSXMLParser alloc] initWithContentsOfURL:accessURL];
	//NSLog(@"%@",xmlString);
	
	return 1;
	
}


@end
