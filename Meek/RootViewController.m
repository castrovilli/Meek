//
//  RootViewController.m
//  Meek
//
//  Created by ZIWEI LIU on 3/4/14.
//  Copyright (c) 2014 ZIWEI LIU. All rights reserved.
//

#import "RootViewController.h"
#import "AddRecordViewController.h"
#import "DreamRecord+DreamRecord_Edit.h"
#import "MeekCDTVC.h"
#import "DetailViewController.h"

@interface RootViewController ()
//@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) MeekCDTVC *meekcdtvc;
@end

@implementation RootViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIViewController *childViewController = [self.childViewControllers firstObject];
    if([childViewController isKindOfClass:[MeekCDTVC class]]){
        self.meekcdtvc = (MeekCDTVC *)childViewController;
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

#pragma mark - IBAction

- (IBAction)delete:(UIBarButtonItem *)sender {
    NSArray *selectedRows = [self.meekcdtvc.tableView indexPathsForSelectedRows];
    for (NSIndexPath *indexPath in selectedRows) {
        DreamRecord *selectedrecord = [self.meekcdtvc.fetchedResultsController objectAtIndexPath:indexPath];
        [self.meekcdtvc.managedObjectContext deleteObject:selectedrecord];
    }
}

#pragma mark - Navigation

- (void)prepareViewController:(id)vc
                     forSegue:(NSString *)segueIdentifier
                fromIndexPath:(NSIndexPath *)indexPath
   inFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    // NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if ([vc isKindOfClass:[DetailViewController class]]) {
        if (![segueIdentifier length] || [segueIdentifier isEqualToString:@"Show Record"]) {
            // prepare vc
            DreamRecord *dreamRecord = [fetchedResultsController objectAtIndexPath:indexPath];
//            NSLog(@"%@", dreamRecord);
            DetailViewController *dvc = (DetailViewController *)vc;
            dvc.dreamRecord = dreamRecord;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
            [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
            NSString *localDateString = [dateFormatter stringFromDate:dreamRecord.date];
            dvc.title = localDateString;
            //            NSLog(@"date : %@",localDateString);
        }
    }
}
// In a story board-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSManagedObjectContext *managedObjectContext = self.meekcdtvc.managedObjectContext;;
    NSIndexPath *indexPath = [[self.meekcdtvc.tableView indexPathsForSelectedRows] firstObject];
    NSFetchedResultsController *frc = self.meekcdtvc.fetchedResultsController;

    if ([segue.destinationViewController isKindOfClass:[AddRecordViewController class]]) {
        AddRecordViewController *advc = (AddRecordViewController *)segue.destinationViewController;
        advc.addedRecord = [DreamRecord dreamRecordWithDate:[NSDate date]
                                                  editTitle:nil
                                                   orDetail:nil
                                                 orCategory:nil
                                     inManagedObjectContext:managedObjectContext];
    } else if([sender isKindOfClass:[UIBarButtonItem class]] ){
        if(indexPath){
            [self prepareViewController:segue.destinationViewController
                               forSegue:segue.identifier
                          fromIndexPath:indexPath
             inFetchedResultsController:frc];
        }
    }
}

@end
