//
//  DreamRecord+DreamRecord_Edit.h
//  Meek
//
//  Created by ZIWEI LIU on 3/2/14.
//  Copyright (c) 2014 ZIWEI LIU. All rights reserved.
//

#import "DreamRecord.h"

@interface DreamRecord (DreamRecord_Edit)
+(DreamRecord *)dreamRecordWithDate:(NSDate *)date
                          editTitle:(NSString *)title
                           orDetail:(NSString *)detail
                         orCategory:(NSString *)category
             inManagedObjectContext:(NSManagedObjectContext *) context;
@end
