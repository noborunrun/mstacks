//
//  UnReadBooksListController.m
//  iS3
//
//  Created by noboru on 11/20/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "UnReadBooksListController.h"

@implementation UnReadBooksListController
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSString *) setNameBySection:(NSInteger)section {
	return [super setNameBySection:1];
}

- (void) setArrayBySection:(NSInteger)section {
  [super setArrayBySection:1];}

- (void)didReceiveMemoryWarning {
	////NSLog(@"memory Warning at UnRead");
	[super didReceiveMemoryWarning];
}

- (void)dealloc {
    [super dealloc];
}

@end

