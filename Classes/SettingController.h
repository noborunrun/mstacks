//
//  setting.h
//  iS3
//
//  Created by yanagisawa.n on 10/2/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "user.h"

@class IS3AppDelegate;
@class AllBookListController;

@interface SettingController : UIViewController <UITextFieldDelegate> {
  IS3AppDelegate *appDelegate;
  AllBookListController *allBookListController;
	NSInteger userNo;
	IBOutlet UITextField *userID;
	IBOutlet UITextField *apiToken;
	NSString *string;
  //BOOL changed;
}

@property (readwrite, assign) IS3AppDelegate *appDelegate;
@property (readwrite, assign) AllBookListController *allBookListController;
@property (readonly) NSInteger userNo;
@property (nonatomic, retain) UITextField *userID;
@property (nonatomic, retain) UITextField *apiToken;
@property (nonatomic, copy) NSString *string;

- (IBAction)setting:(id)sender;
- (IBAction) about:(id)sender;
- (IBAction)backgroudClick:(id)sender;
- (IBAction) openURL:(id)sender;

@end
