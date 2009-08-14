//
//  AboutViewController.m
//  iS3
//
//  Created by noboru on 2/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"


@implementation AboutViewController


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
      self.title = @"About";
      
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
  NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	NSString *textPath = [documentsDir stringByAppendingPathComponent:@"about.txt"];	
  BOOL success;
  if(![fileManager fileExistsAtPath:textPath]) {
    NSString *defaultFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"about.txt"];
		success = [fileManager copyItemAtPath:defaultFilePath toPath:textPath error:&error];
  }
  if (success){
    
  NSString *fileText = [[NSString alloc] initWithContentsOfFile:textPath encoding:NSUTF8StringEncoding error:&error];
    textView.text = fileText;
  
  textView.editable = NO;
  }else{
    textView.text = error;
  }

}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
