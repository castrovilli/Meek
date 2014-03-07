//
//  DreamRecord+DreamRecord_Edit.m
//  Meek
//
//  Created by ZIWEI LIU on 3/2/14.
//  Copyright (c) 2014 ZIWEI LIU. All rights reserved.
//

#import "DreamRecord+DreamRecord_Edit.h"

@implementation DreamRecord (DreamRecord_Edit)
+(DreamRecord *)dreamRecordWithDate:(NSDate *)date
                          editTitle:(NSString *)title
                           orDetail:(NSString *)detail
                         orCategory:(NSString *)category
             inManagedObjectContext:(NSManagedObjectContext *) context
{
    DreamRecord *dreamRecord = nil;
    
    if (date) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DreamRecord"];
        request.predicate = [NSPredicate predicateWithFormat:@"date = %@", date];
        NSError *error = nil;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || error || ([matches count] > 1)) {
            // handle error
        } else if ([matches count] == 1) { // make change
            dreamRecord = [matches firstObject];
            if(title) {
                dreamRecord.title = title;
            }
            if (detail) {
                dreamRecord.detail = detail;
            }
            if (category) {
                dreamRecord.category = category;
            }
        } else {  // add new
            dreamRecord = [NSEntityDescription insertNewObjectForEntityForName:@"DreamRecord"
                                                        inManagedObjectContext:context];
            dreamRecord.date = date;
            dreamRecord.title = title;
            dreamRecord.detail = detail;
            dreamRecord.category = category;
//            NSLog(@"add new record");
        }
    }
    
    return dreamRecord;
    
}
@end
