//
//  BookController.h
//  iS3
//
//  Created by noboru on 11/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IS3AppDelegate;
@class ImageStore;

@interface BookController : UIViewController  {
  IBOutlet IS3AppDelegate *appDelegate;

	IBOutlet UILabel *bookTitle;
	IBOutlet UILabel *isbn;
  IBOutlet UILabel *isbn10;
  IBOutlet UILabel *author;
  IBOutlet UILabel *publisher;
	IBOutlet UIButton *bookImageButton;
  IBOutlet UIButton *categoryButton;
	IBOutlet UIImageView *bookImage;
  IBOutlet UILabel *dateOfIsues;
  //IBOutlet UIButton *mutterButton;
  IBOutlet UIView *toolbarView;
	
	NSObject *imageUrl;
	NSMutableString *tempTitle;
	NSString *bookISBN;
  NSString *bookISBN10;
  NSString *bookAuthor;
  NSString *bookPublisher;
  NSString *bookDateOfIsues;
  NSString *categoryButtonTitle;

}

@property (readwrite, assign) IS3AppDelegate *appDelegate;
@property (nonatomic, retain) UILabel *bookTitle;
@property (nonatomic, retain) UILabel *isbn;
@property (nonatomic, retain) UILabel *isbn10;
@property (nonatomic, retain) UILabel *author;
@property (nonatomic, retain) UILabel *publisher;
@property (nonatomic, retain) UIButton *bookImageButton;
@property (nonatomic, retain) UIButton *categoryButton;
@property (nonatomic, retain) UIImageView *bookImage;
@property (nonatomic, retain) UILabel *dateOfIsues;
//@property (nonatomic, retain) UIButton *mutterButton;
@property (nonatomic, retain) UIView *toolbarView;

@property (nonatomic, retain) NSObject *imageUrl;
@property (nonatomic, retain) NSMutableString *tempTitle;
@property (nonatomic, retain) NSString *bookISBN;
@property (nonatomic, retain) NSString *bookISBN10;
@property (nonatomic, retain) NSString *bookAuthor;
@property (nonatomic, retain) NSString *bookPublisher;
@property (nonatomic, retain) NSString *bookDateOfIsues;
@property (nonatomic, retain) NSString *categoryButtonTitle;

- (void)setLabel;
- (IBAction)showMutter:(id)sender;
- (IBAction)showAmazon:(id)sender;
- (IBAction)showStatusViewPicker:(id)sender;
- (IBAction)showToolbar:(id)sender;

@end
