//
//  InputViewController.m
//  iS3
//
//  Created by yanagisawa.n on 5/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "InputViewController.h"
#import "IS3AppDelegate.h"
#import "BookController.h"
#import "StackStockBooks.h"
#import "AmazonViewController.h"
#import "ConvertISBN.h"
#import "UpdateBookStatus.h"

@implementation InputViewController

@synthesize appDelegate;
@synthesize isbn;

BookController *bookController;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    // Custom initialization
    appDelegate = (IS3AppDelegate *)[[UIApplication sharedApplication] delegate];
  }
  return self;
}

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
  [isbn resignFirstResponder];
}


- (void)dealloc {
  [super dealloc];
}


- (IBAction)getBookInfo:(id)sender {
  //test
  //  isbn.text = @"9784774138381";
  if ([isbn.text length] == 10 ||[isbn.text length] == 13 ) {
    
    
    //Once regist book for SSB
    if ([isbn.text length] != 0) {
      NSString *isbn10;
      if ([isbn.text length] == 13) {
        ConvertISBN *isbnConverter = [[ConvertISBN alloc] init];
        isbn10 = [isbnConverter ConvertISBN13to10:isbn.text];
      }else if ([isbn.text length] == 10) {
        isbn10 = isbn.text;
      }
      NSLog(@"%@",isbn10);
      StackStockBooks *ssb = [[StackStockBooks alloc ] init];
      NSMutableArray *bookArray = [[NSMutableArray alloc] initWithArray:
                                   [UpdateBookStatus createBookArrayWithISBN:isbn10 BookStatus:@"wish"]
                                   ];
      //StackStockBooks *ssb = [[StackStockBooks alloc] initWithUpdateStatusWith:bookArray];
      [ssb initWithUpdateStatusWith:bookArray];
      [ConvertISBN release];
      
      //NSLog(@"%@",isbn.text);
      NSMutableArray *bookInfo = [[NSMutableArray alloc] init];
      
      //Get BookInfo with ISBN
      [ssb initWithGetBookInfoOfISBN:isbn10];
      //ssb = [[StackStockBooks alloc] initWithGetBookInfoOfISBN:isbn.text];
      
      NSLog(@"%@",ssb.bookInfoArray);
      bookInfo = ssb.bookInfoArray;
      NSLog(@"%@",bookInfo);
      [ssb release];
      //NSLog(@"%d",[bookInfo count]);
      
      if ([bookInfo count] < 1) {
        //if not exist show alert
        UIAlertView *alert = [UIAlertView alloc];
        [alert initWithTitle:@"Error" message:@"ISBNが間違っているか、StackStockBooksに書籍情報がありません。"
                    delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];	
        [alert release];
        
        
      }else {
        //if exist bookInfo on SSB,open BookView
        //Initialize the controller.   
        
        bookController = [[BookController alloc] initWithNibName:@"Book" bundle:[NSBundle mainBundle]];
        
        //set author
        NSMutableString *author = @"";
        int i = 0;
        for (i=0;i<[[[bookInfo objectAtIndex:0] objectForKey:@"authors"] count];i++) {
          if (i != 0) {
            author = [author stringByAppendingString:@","];
          }
          author = [author stringByAppendingString:[[[[bookInfo objectAtIndex:0] objectForKey:@"authors"] objectAtIndex:i] objectForKey:@"name"]];
          
        }
        bookController.title = @"Book Infomation";
        [bookController setButtonTitleWith:1];
        bookController.tempTitle = [[bookInfo objectAtIndex:0] objectForKey:@"title"];
        bookController.imageUrl = [[bookInfo objectAtIndex:0] objectForKey:@"image_uri"];
        bookController.bookISBN = [[bookInfo objectAtIndex:0] objectForKey:@"isbn13"];
        bookController.bookISBN10 = [[bookInfo objectAtIndex:0] objectForKey:@"isbn10"];
        bookController.bookAuthor = author;
        bookController.bookPublisher = [[bookInfo objectAtIndex:0] objectForKey:@"publisher"];
        bookController.bookDateOfIsues = [[bookInfo objectAtIndex:0] objectForKey:@"release_date"]; 
        //Add the view as a sub view to the current view.
        [bookController setLabel];
        [[self navigationController] pushViewController:bookController animated:YES];
        [bookController release];
        [isbn resignFirstResponder];
      }
    }
  }
}

- (IBAction)backgroudClick:(id)sender{
  [isbn resignFirstResponder];
  
}
- (IBAction) openURL:(id)sender {
  NSString *URL = @"http://stack.nayutaya.jp/books/stock"; 
  ////NSLog(@"%@",amazonURL);
  AmazonViewController *amazonWVController = [[AmazonViewController alloc] initWithNibName:@"URLView"  bundle:nil];
  amazonWVController.URLString = URL;
  //amazonWVController.title = [@"amazon:" stringByAppendingString:self.bookTitle.text];
  [[self navigationController] pushViewController:amazonWVController animated:YES];
  
}

@end
