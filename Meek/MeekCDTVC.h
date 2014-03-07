//
//  MeekCDTVCViewController.h
//  Meek
//
//  Created by ZIWEI LIU on 3/2/14.
//  Copyright (c) 2014 ZIWEI LIU. All rights reserved.
//

#import "CoreDataTableViewController.h"

@interface MeekCDTVC : CoreDataTableViewController
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
//@property (nonatomic, strong) NSMutableArray *selectedRowsArray; // of index path
@end
