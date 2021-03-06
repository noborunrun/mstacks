//
//  ConvertISBN.m
//  iS3
//
//  Created by noboru on 8/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ConvertISBN.h"
#include <string.h>


@implementation ConvertISBN

-(NSString *)ConvertISBN13to10:(NSString *)isbn13 {
  static char ib10[16];
  const char *ib13 = [isbn13 cString];
  
  unsigned long   checkDigit = 0;
  const char      *p = ib13;
  char            *q = ib10;
  int             i;
  
  p += 3;
  for ( i = 10; i > 1; i-- ) {
    if ( !(*p) || (*p < '0') || (*p > '9') ) {
      if ( *p == '-' ) {
        p++;
        i++;
        continue;
      }
    }
    checkDigit += (*p - '0') * i;
    *q++ = *p++;
  }
  checkDigit = (11 - (checkDigit % 11)) % 11;
  *q++ = checkDigit == 10 ? 'X' : (char)(checkDigit + '0');
  *q   = '\0';

  NSLog(@"%s",ib10);
//  char *isbn10tmp = "";
//  for (i = 0 ; i<11 ; i++) {
//    strcat(*isbn10tmp,ib10[i]);
//  }
//  NSLog(@"%@",isbn10tmp);
  NSString *isbn10 = [[NSString alloc] initWithCString:ib10 encoding:1];
  NSLog(@"%@",isbn10);
  return isbn10;
}
@end
