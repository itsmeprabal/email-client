//
//  MasterViewController.m
//  SampleEmailApp
//
//  Created by Prabal on 21/01/19.
//  Copyright © 2019 pc. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "EmailData.h"
#import "Email.h"
#import "UserEmail.h"
#import "Draft.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@property EmailData *data;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(composeEmail:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.data = [EmailData getInstance];
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
    [[EmailData getInstance] refreshDataFromServer];
}

- (void)refreshData {
    [self.data refreshDataFromServer];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)composeEmail:(id)sender {
    
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        switch (indexPath.section) {
            case 0: {
                UserEmail *email = [self.data.inbox objectAtIndex:indexPath.row];
                controller.category = 0;
                controller.data = email;
            }
                break;
            case 1: {
                Email *email = [self.data.sent objectAtIndex:indexPath.row];
                controller.category = 1;
                controller.data = email;
            }
                break;
                
            case 2: {
                Draft *draft = [self.data.drafts objectAtIndex:indexPath.row];
                controller.category = 2;
                controller.data = draft;
            }
                break;
                
            case 3: {
                UserEmail *email = [self.data.trash objectAtIndex:indexPath.row];
                controller.category = 3;
                controller.data = email;
            }
                break;
                
            default:
                break;
        }
        
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Inbox";
            
        case 1:
            return @"Sent";
            
        case 2:
            return @"Drafts";
            
        case 3:
            return @"Trash";
            
        default:
            break;
    }
    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.data.inbox.count;
            
        case 1:
            return self.data.sent.count;
            
        case 2:
            return self.data.drafts.count;
            
        case 3:
            return self.data.trash.count;
            
        default:
            break;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0: {
            UserEmail *email = [self.data.inbox objectAtIndex:indexPath.row];
            cell.textLabel.text = email.email.subject;
            cell.detailTextLabel.text = email.email.body;
        }
            break;
        case 1: {
            Email *email = [self.data.sent objectAtIndex:indexPath.row];
            cell.textLabel.text = email.subject;
            cell.detailTextLabel.text = email.body;
        }
            break;
            
        case 2: {
            Draft *draft = [self.data.drafts objectAtIndex:indexPath.row];
            cell.textLabel.text = draft.subject;
            cell.detailTextLabel.text = draft.body;
        }
            break;

        case 3: {
            UserEmail *email = [self.data.trash objectAtIndex:indexPath.row];
            cell.textLabel.text = email.email.subject;
            cell.detailTextLabel.text = email.email.body;
            cell.backgroundColor = [UIColor lightGrayColor];
        }
            break;
            
        default:
            break;
    }
    return cell;
}


//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}


@end
