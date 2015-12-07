//
//  PLMemoryDataSource.h
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLDataSource.h"

#pragma clang assume_nonnull begin

@interface PLMemoryDataSource : PLDataSource

-(void)addItem:(id)item;
-(void)addItem:(id)item toSection:(NSUInteger)sectionNumber;
-(void)addItems:(NSArray *)items;
-(void)addItems:(NSArray *)items toSection:(NSUInteger)sectionNumber;

-(void)insertItem:(id)item toIndexPath:(NSIndexPath *)indexPath;

-(void)reloadItem:(id)item;

- (void)removeItem:(id)item;
- (void)removeItemsAtIndexPaths:(NSArray *)indexPaths;
- (void)removeItems:(NSArray *)items;
- (void)replaceItem:(id)itemToReplace withItem:(id)replacingItem;

- (void)deleteSections:(NSIndexSet *)indexSet;
- (void)setItems:(nullable NSArray *)items forSectionIndex:(NSUInteger)sectionIndex;


- (void)setSectionHeaderModel:(nullable id)headerModel forSectionIndex:(NSUInteger)sectionIndex;
- (void)setSectionFooterModel:(nullable id)footerModel forSectionIndex:(NSUInteger)sectionIndex;


@end

#pragma clang assume_nonnull end
