//
//  Image.h
//  iS3
//
//  Created by noboru on 11/29/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Image : NSObject {
}

- (id) initWIthDefaultImage;
- (NSData *) getImageFromWebWithURL:(NSObject *)url;
- (void) setDefaultImage;
- (NSData *) defaultImage;
- (NSString *) getLargeSizeImageWithURL:(NSString *)imageURL;
@end
