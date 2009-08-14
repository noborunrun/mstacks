//
//  StatusPickerViewController.h
//  iS3
//
//  Created by noboru on 2/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IS3AppDelegate;

@interface StatusPickerViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource> {
  IBOutlet IS3AppDelegate *appDelegate;
  IBOutlet UIPickerView *pickerView;
  NSString *isbn10;
}

@property (readwrite, assign) IS3AppDelegate *appDelegate;
@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic, retain) NSString *isbn10;

- (IBAction)pushCancel:(id)sender;
- (IBAction)pushuSave:(id)sender;

@end
