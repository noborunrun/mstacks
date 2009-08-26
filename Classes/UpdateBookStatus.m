//
//  UpdateBookStatus.m
//  iS3
//
//  Created by noboru on 2/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UpdateBookStatus.h"


@implementation UpdateBookStatus

+ (NSArray *) createBookArrayWithISBN:(NSString *)isbn10 BookStatus:(NSString *)status {

  //get today date
  NSString *now = [[NSDate date] description];
  //  //NSLog(@"%@",[now class]);
  NSArray *date = [now componentsSeparatedByString:@" "];
  //NSLog(@"%@",[date objectAtIndex:0]);
  
  NSMutableArray *bookArray = [[NSMutableArray alloc] init];
  NSMutableDictionary *bookDict = [[NSMutableDictionary alloc] init];
  [bookDict setObject:isbn10 forKey:@"asin"];
  [bookDict setObject:[date objectAtIndex:0] forKey:@"date"];
  [bookDict setObject:[status lowercaseString] forKey:@"state"];
  //NSLog(@"%@",status);
  ////NSLog(@"%@",bookDict);
  //[bookDict setObject:@"n/a" forKey:@"public"];
  NSLog(@"%@",status);
  NSLog(@"%@",[date objectAtIndex:0]);
  [bookArray addObject:bookDict];
  return bookArray;
}
@end
