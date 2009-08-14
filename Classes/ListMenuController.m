//
//  ListMenuController.m
//  iS3
//
//  Created by noboru on 12/27/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ListMenuController.h"
#import "IS3AppDelegate.h"
#import "WishBooksListController.h"
#import "UnReadBooksListController.h"
#import "ReadBooksListController.h"
#import "ReadingBooksListController.h"
#import "Reachability.h"

@implementation ListMenuController

@synthesize appDelegate;

NSArray *menuItemArray;

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return @"BookList";
}

- (void)viewDidLoad {
	appDelegate = (IS3AppDelegate *)[[UIApplication sharedApplication] delegate];
		[super viewDidLoad];
  
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewWillAppear:(BOOL)animated {
	//menuItemArray = [[NSArray alloc] initWithObjects:@"いつか欲しい",@"まだ読んでいない",@"今読んでいる",@"もう読み終えた",nil];
	menuItemArray = appDelegate.selectItem;

  [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
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

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [menuItemArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
  }
  
  // Set up the cell...
  cell.text = [menuItemArray objectAtIndex:indexPath.row];
  
  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:)
                                               name:@"kNetworkReachabilityChangedNotification" object:nil];
  if ([self refleshIfNeeded]){
		
		id *viewController;
		switch (indexPath.row) {
			case 0:
				viewController = [[WishBooksListController alloc] initWithStyle:UITableViewStylePlain];
				break;
			case 1:
				viewController = [[UnReadBooksListController alloc] initWithStyle:UITableViewStylePlain];
				break;
			case 2:
				viewController = [[ReadingBooksListController alloc] initWithStyle:UITableViewStylePlain];
				break;
			case 3:
				viewController = [[ReadBooksListController alloc] initWithStyle:UITableViewStylePlain];
				break;
			default:
				break;
		}
		
		[[self navigationController] pushViewController:viewController animated:YES];
		
		[viewController release];
	}
}

- (BOOL)refleshIfNeeded {
  [[Reachability sharedReachability] setNetworkStatusNotificationsEnabled:YES];
  [[Reachability sharedReachability] setHostName:@"http://stack.nayutaya.jp/"];
  ////NSLog(@"%@",[[Reachability sharedReachability] internetConnectionStatus]);
  if ([[Reachability sharedReachability] internetConnectionStatus] == NotReachable) {
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *infoDictionary = [bundle localizedInfoDictionary];
    NSString *appName = [[infoDictionary count] ? infoDictionary : [bundle infoDictionary] objectForKey:@"CFBundleDisplayName"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:appName message:NSLocalizedString(@"ネットワークが使用できません", nil)
                                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];	
    [alert release];
    return NO;
  }else{
    return YES;
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
  [menuItemArray release];
  [super dealloc];
}


@end

