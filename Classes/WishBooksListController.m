//
//  WishBooksListController.m
//  iS3
//
//  Created by noboru on 11/20/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "WishBooksListController.h"

@implementation WishBooksListController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSString *) setNameBySection:(NSInteger)section {
  return [super setNameBySection:2];
}

- (void) setArrayBySection:(NSInteger)section {
  ////NSLog(@"%d",section);
  [super setArrayBySection:2];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)didReceiveMemoryWarning {
	////NSLog(@"memory Warning at Wish");
	[super didReceiveMemoryWarning];
}


@end

