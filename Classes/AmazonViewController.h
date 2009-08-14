//
//  AmazonViewController.h
//  iS3
//
//  Created by yanagisawa.n on 1/29/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NowLoading;

@interface AmazonViewController : UIViewController <UIWebViewDelegate>{
	IBOutlet UIWebView *webView;
	NSString *URLString;
}

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) NSString *URLString;

@end
