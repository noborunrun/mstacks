//
//  StatusPickerViewController.m
//  iS3
//
//  Created by noboru on 2/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "StatusPickerViewController.h"
#import "StackStockBooks.h"
#import "UpdateBookStatus.h"
#import "IS3AppDelegate.h"

@implementation StatusPickerViewController

@synthesize appDelegate;
@synthesize pickerView;
@synthesize isbn10;

NSArray *pickerItems;
NSMutableString *selectedRowItem;
NSInteger selectedRowItemCount;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Custom initialization
		appDelegate = (IS3AppDelegate *)[[UIApplication sharedApplication] delegate];
	}
	return self;
}

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
  selectedRowItem = [[NSMutableString alloc] init];
  //pickerItems = [[NSArray alloc] initWithObjects:@"いつか欲しい",@"いま読んでいる",@"まだ読んでいない",@"もう読み終えた",nil];
	pickerItems = appDelegate.selectItem;
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (IBAction)pushCancel:(id)sender {
  [self.view removeFromSuperview];
}

- (IBAction)pushuSave:(id)sender {
  switch (selectedRowItemCount) {
    case 0:
      selectedRowItem = @"wish";
      break;
    case 1:
      selectedRowItem = @"unread";
      break;
      
    case 2:
      selectedRowItem = @"reading";
      break;
    case 3:
      selectedRowItem = @"read";
      break;
    default:
      break;
  }
	//NSLog(@"%@",selectedRowItem);
  NSMutableArray *bookArray = [[NSMutableArray alloc] initWithArray:
                               [UpdateBookStatus createBookArrayWithISBN:isbn10 BookStatus:selectedRowItem]
                               ];
  //StackStockBooks *ssb = [[StackStockBooks alloc] initWithUpdateStatusWith:bookArray];
	[[StackStockBooks alloc] initWithUpdateStatusWith:bookArray];
  appDelegate.statusChange = YES;
  appDelegate.ssbDirty = NO;
	
  [self.view removeFromSuperview];
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[appDelegate release];
  [pickerView release];
  [isbn10 release];
	[super dealloc];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return [pickerItems count];
}

/*UIPickerViewDelegate*/

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  // selectedRowItem = [pickerItems objectAtIndex:row];
	selectedRowItemCount = row;
  
}
/*
 - (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
 
 }
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  return [pickerItems objectAtIndex:row];
}
/*
 - (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
 
 }
 - (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
 
 }
 */
@end
