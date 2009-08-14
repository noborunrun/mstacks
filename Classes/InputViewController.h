//
//  InputViewController.h
//  iS3
//
//  Created by yanagisawa.n on 5/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IS3AppDelegate;
@class BookController;

@interface InputViewController : UIViewController <UITextFieldDelegate> {
  
  IS3AppDelegate *appDelegate;
  IBOutlet UITextField *isbn;
  
}

@property (nonatomic, retain) UITextField *isbn;
@property (readwrite, assign) IS3AppDelegate *appDelegate;

- (IBAction)getBookInfo:(id)sender;
- (IBAction)backgroudClick:(id)sender;

@end
