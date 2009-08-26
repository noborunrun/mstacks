//
//  mutterController.m
//  iS3
//
//  Created by noboru on 1/22/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MutterController.h"
#import "IS3AppDelegate.h"
#import "MutterDetailViewController.h"
#import "StackStockBooks.h"
#import "Image.h"
#import "ImageStore.h"


@implementation MutterController
@synthesize mutterList;
@synthesize appDelegate;
@synthesize imageStore;

NSMutableArray *mine,*others;
//NSMutableArray *othersUserID;
NSMutableArray *mutterArray;

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
      appDelegate = (IS3AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  [self separateMutterArrayToMineOrOthers];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)separateMutterArrayToMineOrOthers {
  mine = [[NSMutableArray alloc] init];
  others = [[NSMutableArray alloc] init];
   NSInteger i;
  for (i=0;i<[mutterList count];i++) {
    if ([[[mutterList objectAtIndex:i] objectForKey:@"user_id"] intValue] == appDelegate.userNo) {
      [mine insertObject:[mutterList objectAtIndex:i] atIndex:[mine count]];
    }else{
      [others insertObject:[mutterList objectAtIndex:i] atIndex:[others count]];

      //TODO:separate user mutter with UserID
      
    }

  }
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
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
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
    if ([mine count] > 0){
      return [mine count];
    }else{
      return 1;
    }
  }else {
    if ([others count] > 0){
      return [others count];
    }else{
      return 1;
    }
  }  
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"MutterCell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
  }
  // Set up the cell...
  if (indexPath.section == 1) {
    mutterArray = others;
  }else {
    mutterArray = mine;
  }
  if ([mutterArray count] > 0){
    cell.text = [[mutterArray objectAtIndex:indexPath.row] objectForKey:@"body"];
  }else{
    cell.text = @"まだつぶやいてないです。";
  }

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *tableHeadertitle = @"";
  switch (section) {
    case 0:
      tableHeadertitle = @"mine";
      break;
    case 1:
      tableHeadertitle = @"others";
      break;
    default:
      break;
  }
	return tableHeadertitle;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([tableView cellForRowAtIndexPath:indexPath].text != @"まだつぶやいてないです。") {
    StackStockBooks *ssb = [[StackStockBooks alloc] initWithGetUserInfoOfUserID:[[mutterList objectAtIndex:indexPath.row] objectForKey:@"user_id"]];
    NSMutableArray *userInfoArray = [[NSMutableArray alloc] initWithArray:ssb.userInfoArray];
    
	MutterDetailViewController *mutterDetailViewController = [[MutterDetailViewController alloc] initWithNibName:@"MutterDetailView" bundle:nil];
		//set MutterData
		mutterDetailViewController.mutterArray = mutterList;
		mutterDetailViewController.mutter = [tableView cellForRowAtIndexPath:indexPath].text;
    mutterDetailViewController.userArray = userInfoArray;
    
		[userInfoArray release];
	[self.navigationController pushViewController:mutterDetailViewController animated:YES];
		[mutterDetailViewController release];
	}
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)dealloc {
  [mutterList release];
  [appDelegate release];
  
  [mine release];
  [others release];
  [mutterArray release];
    [super dealloc];
}


@end

