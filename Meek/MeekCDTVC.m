//
//  MeekCDTVCViewController.m
//  Meek
//
//  Created by ZIWEI LIU on 3/2/14.
//  Copyright (c) 2014 ZIWEI LIU. All rights reserved.
//

#import "MeekCDTVC.h"
#import "DatabaseAvailability.h"
#import "DreamRecord.h"
#import "DreamRecord+DreamRecord_Edit.h"
#import "DetailViewController.h"
#import "AddRecordViewController.h"
@interface MeekCDTVC ()

@end


@implementation MeekCDTVC
- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserverForName:DatabaseAvailabilityNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        if (note.userInfo[DatabaseAvailabilityContext]) {
            self.managedObjectContext = note.userInfo[DatabaseAvailabilityContext];
        }
    }];
    
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.allowsMultipleSelection = YES;
//    self.selectedRowsArray = [[NSMutableArray alloc] init];
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
    for (NSIndexPath *indexPath in selectedRows) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }

//    [self.tableView deselectRowAtIndexPaths: animated:NO];
//    [self.selectedRowsArray removeAllObjects];
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DreamRecord"];
    request.predicate = nil;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO selector:nil]];
//    request.fetchLimit = 50;
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];

}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Record Cell" forIndexPath:indexPath];
    DreamRecord *dreamRecord = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, MMM d, yyyy"];
    NSString *localDateString = [dateFormatter stringFromDate:dreamRecord.date];
    cell.textLabel.text = dreamRecord.title;
    cell.detailTextLabel.text = localDateString;
    return cell;
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.selectedRowsArray removeObject:indexPath];
    if (![[self.tableView indexPathsForSelectedRows] count]) {
        [self.navigationController setToolbarHidden:YES animated:YES];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController setToolbarHidden:NO animated:YES];
}

#pragma mark - UNWIND SEGUE

-(IBAction)addRecord:(UIStoryboardSegue *)segue
{
    if ([segue.sourceViewController isKindOfClass:[AddRecordViewController class]]) {
        AddRecordViewController *arvc = (AddRecordViewController *)segue.sourceViewController;
//        DreamRecord *addedRecord = arvc.addedDate;
        if (arvc.addedRecord) {
            
        } else {
            NSLog(@"AddRecordViewController unexpectedly did not add a record!");
        }
    }
    
}

@end
