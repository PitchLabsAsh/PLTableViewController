//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import <Foundation/Foundation.h>

#pragma clang assume_nonnull begin

@interface PLDataSourceUpdate : NSObject

@property (nonatomic, strong) NSMutableIndexSet *deletedSectionIndexes;
@property (nonatomic, strong) NSMutableIndexSet *insertedSectionIndexes;
@property (nonatomic, strong) NSMutableIndexSet *updatedSectionIndexes;
@property (nonatomic, strong) NSMutableArray *deletedRowIndexPaths;
@property (nonatomic, strong) NSMutableArray *insertedRowIndexPaths;
@property (nonatomic, strong) NSMutableArray *updatedRowIndexPaths;

-(BOOL)isEmpty;

@end


@protocol PLDataSourceUpdating <NSObject>

- (void)dataSourceWillPerformUpdate;
- (void)dataSourceDidPerformUpdate:(PLDataSourceUpdate *)update;
- (void)dataSourceFailedUpdate:(NSError*)error;
- (void)dataSourceNeedsReload;

@end



#pragma clang assume_nonnull end
