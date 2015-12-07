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

- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (nullable id)itemAtIndexPath:(NSIndexPath *)indexPath;
- (nullable NSIndexPath *)indexPathForItem:(id)item;

- (id)headerModelForSection:(NSInteger)index;
- (id)footerModelForSection:(NSInteger)index;

@end

#pragma clang assume_nonnull end
