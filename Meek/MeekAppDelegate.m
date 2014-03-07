//
//  MeekAppDelegate.m
//  Meek
//
//  Created by ZIWEI LIU on 2/15/14.
//  Copyright (c) 2014 ZIWEI LIU. All rights reserved.
//

#import "MeekAppDelegate.h"
#import "DatabaseAvailability.h"
#import "DreamRecord+DreamRecord_Edit.h"

@interface MeekAppDelegate ()
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (strong, nonatomic) NSURL *fileURL;
@end

@implementation MeekAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    [self openOrCreateDocument];
    return YES;
}
							

#pragma mark - UIManagedDocument
// create a managed document using fileURL but did not store it into disk
- (UIManagedDocument *)createManagedDocument
{
    UIManagedDocument * doc;
    self.fileURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"DreamRecord"];
    doc = [[UIManagedDocument alloc] initWithFileURL:self.fileURL];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    doc.persistentStoreOptions = options;
    
    return doc;
}


// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

// open or create new document from/into disk and then shoot the start flickr fetching
-(void)openOrCreateDocument
{
    UIManagedDocument *doc = [self createManagedDocument];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self.fileURL path]]) {
        [doc openWithCompletionHandler:^(BOOL success) {
            if (success) {
                if (doc.documentState == UIDocumentStateNormal) {
                    self.context = doc.managedObjectContext;
//                    [self startFlickrFetch];
                }
            }
            else {
                NSLog(@"can't open document at %@", self.fileURL);
            }
        }];
    } else {
        [doc saveToURL:self.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                if (doc.documentState == UIDocumentStateNormal) {
                    self.context = doc.managedObjectContext;
                    [self createInitialData];
                }
            }
            else {
                NSLog(@"can't create document at %@", self.fileURL);
            }
        }];
    }
}

- (void)setContext:(NSManagedObjectContext *)context
{
    _context = context;
    
    // let everyone who might be interested know this context is available
    // this happens very early in the running of our application
    NSDictionary *usrInfo =self.context? @{DatabaseAvailabilityContext : self.context} : nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:DatabaseAvailabilityNotification
                                                        object:self
                                                      userInfo:usrInfo];
}

-(void)createInitialData
{
    [DreamRecord dreamRecordWithDate:[NSDate date]
                           editTitle:@"My Dream"
                            orDetail:@"Try play around"
                          orCategory:@"normal"
              inManagedObjectContext:self.context];
}
@end
