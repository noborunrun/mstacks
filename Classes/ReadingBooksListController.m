//
//  ReadingBooksListController.m
//  iS3
//
//  Created by noboru on 11/20/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ReadingBooksListController.h"

@implementation ReadingBooksListController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSString *) setNameBySection:(NSInteger)section {
	return [super setNameBySection:0];
}

- (void) setArrayBySection:(NSInteger)section {
   [super setArrayBySection:0];
}

- (void)didReceiveMemoryWarning {
	////NSLog(@"memory Warning at Reading");
	[super didReceiveMemoryWarning];
}

- (void)dealloc {
  [super dealloc];
}

@end

