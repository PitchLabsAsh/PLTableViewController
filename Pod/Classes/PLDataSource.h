//
//  PLDataSource.h
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "PLDataSourceSection.h"
#import "PLDataSourceUpdate.h"

#pragma clang assume_nonnull begin


@interface PLDataSource : NSObject

@property (nonatomic, weak, nullable) id <PLDataSourceUpdating> delegate;
@property (nonatomic, strong) NSMutableArray * sections;

- (nullable PLDataSourceSection*)sectionAtIndex:(NSUInteger)sectionNumber;
- (nullable id)itemAtIndexPath:(NSIndexPath *)indexPath;
- (nullable NSIndexPath *)indexPathForItem:(id)item;

@end

#pragma clang assume_nonnull end
