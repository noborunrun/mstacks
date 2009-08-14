//
//  ReadBooksList.m
//  iS3
//
//  Created by noboru on 11/20/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ReadBooksListController.h"

@implementation ReadBooksListController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSString *) setNameBySection:(NSInteger)section {
	return [super setNameBySection:3];
}

- (void) setArrayBySection:(NSInteger)section {
    [super setArrayBySection:3];
}

- (void)didReceiveMemoryWarning {
	////NSLog(@"memory Warning at Read");
	[super didReceiveMemoryWarning];
}

- (void)dealloc {
    [super dealloc];
}


@end

