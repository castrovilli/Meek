//
//  DreamRecord.h
//  Meek
//
//  Created by ZIWEI LIU on 3/2/14.
//  Copyright (c) 2014 ZIWEI LIU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DreamRecord : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSString * category;

@end
