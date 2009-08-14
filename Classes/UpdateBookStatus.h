//
//  UpdateBookStatus.h
//  iS3
//
//  Created by noboru on 2/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UpdateBookStatus : NSObject {

}
+ (NSArray *) createBookArrayWithISBN:(NSString *)isbn10 BookStatus:(NSString *)status;

@end
