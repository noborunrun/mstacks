//
//  amazon.m
//  iS3
//
//  Created by yanagisawa.n on 6/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Amazon.h"

@implementation Amazon

@synthesize amazonURL;

NSString *amazonAPIToken = @"0S3FR5SV6P9T90RPDHR2";

- (id) getBookInfoFromAmazonWith:(NSString *)ISBN {
	
	amazonURL = [[[[@"http://webservices.amazon.co.jp/onca/xml?Service=AWSECommerceService&AWSAccessKeyId="
					stringByAppendingString:amazonAPIToken]
				    stringByAppendingString:@"&Operation=ItemLookup&SearchIndex=Books&ResponseGroup=Large&IdType=ISBN&ItemId="]
					stringByAppendingString:ISBN]
					stringByAppendingString:@"&ReviewPage=1"];
				 
	NSURL *accessURL;
	NSXMLParser *xmlString;
	accessURL = [NSURL URLWithString:amazonURL];
	//xmlString = [[NSXMLParser alloc] initWithContentsOfURL:accessURL encoding:NSUTF8StringEncoding error:nil];
	xmlString = [[NSXMLParser alloc] initWithContentsOfURL:accessURL];
	//NSLog(@"%@",xmlString);
	
	return 1;
	
}

@end
