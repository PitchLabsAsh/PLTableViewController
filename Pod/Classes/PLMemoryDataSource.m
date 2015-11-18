//
//  PLMemoryDataSource.m
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLMemoryDataSource.h"
#import "PLDataSourcePrivate.h"

@implementation PLMemoryDataSource

-(instancetype)init
{
    self = [super init];
    self.sections = [NSMutableArray array];
    return self;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < self.sections.count)
    {
        PLDataSourceSection *section = [self sections][indexPath.section];
        if (indexPath.item < section.objects.count)
        {
            return section.objects[indexPath.row];
        }
    }
    return nil;
}

- (void)setItems:(NSArray *)items forSectionIndex:(NSUInteger)sectionIndex
{
    PLDataSourceSection *section = [self sectionAtIndex:sectionIndex];
    [section.objects removeAllObjects];
    [section.objects addObjectsFromArray:items];
    [self.delegate dataSourceNeedsReload];
}

#pragma mark - Adding items

- (void)addItem:(id)item
{
    [self addItem:item toSection:0];
}

- (void)addItem:(id)item toSection:(NSUInteger)sectionNumber
{
    [self startUpdate];
    
    PLDataSourceSection * section = [self getValidSection:sectionNumber];
    NSUInteger numberOfItems = section.objects.count;
    [section.objects addObject:item];
    [self.currentUpdate.insertedRowIndexPaths addObject:[NSIndexPath indexPathForRow:numberOfItems
                                                                           inSection:sectionNumber]];
    
    [self finishUpdate];
}

- (void)addItems:(NSArray *)items
{
    [self addItems:items toSection:0];
}

- (void)addItems:(NSArray *)items toSection:(NSUInteger)sectionNumber
{
    [self startUpdate];
    
    PLDataSourceSection * section = [self getValidSection:sectionNumber];
    
    for (id item in items)
    {
        NSUInteger numberOfItems = section.objects.count;
        [section.objects addObject:item];
        [self.currentUpdate.insertedRowIndexPaths addObject:[NSIndexPath indexPathForRow:numberOfItems
                                                                               inSection:sectionNumber]];
    }
    
    [self finishUpdate];
}

- (void)insertItem:(id)item toIndexPath:(NSIndexPath *)indexPath
{
    [self startUpdate];
    
    PLDataSourceSection * section = [self getValidSection:indexPath.section];
    if ([section.objects count] < indexPath.row)
    {
        return;
    }
    
    [section.objects insertObject:item atIndex:indexPath.row];
    [self.currentUpdate.insertedRowIndexPaths addObject:indexPath];
    [self finishUpdate];
}

- (void)reloadItem:(id)item
{
    [self startUpdate];
    
    NSIndexPath * indexPathToReload = [self indexPathForItem:item];
    
    if (indexPathToReload)
    {
        [self.currentUpdate.updatedRowIndexPaths addObject:indexPathToReload];
    }
    
    [self finishUpdate];
}

- (void)replaceItem:(id)itemToReplace
           withItem:(id)replacingItem
{
    [self startUpdate];
    
    NSIndexPath * originalIndexPath = [self indexPathForItem:itemToReplace];
    if (originalIndexPath && replacingItem)
    {
        PLDataSourceSection * section = [self getValidSection:originalIndexPath.section];
        [section.objects replaceObjectAtIndex:originalIndexPath.row
                                   withObject:replacingItem];
    }
    else
    {
        return;
    }
    
    [self.currentUpdate.updatedRowIndexPaths addObject:originalIndexPath];
    
    [self finishUpdate];
}

#pragma mark - Removing items

- (void)removeItem:(id)item
{
    [self startUpdate];
    
    NSIndexPath * indexPath = [self indexPathForItem:item];
    
    if (indexPath)
    {
        PLDataSourceSection * section = [self getValidSection:indexPath.section];
        [section.objects removeObjectAtIndex:indexPath.row];
    }
    else
    {
        return;
    }
    [self.currentUpdate.deletedRowIndexPaths addObject:indexPath];
    [self finishUpdate];
}

- (void)removeItemsAtIndexPaths:(NSArray *)indexPaths
{
    [self startUpdate];
    NSArray *reverseSortedIndexPaths = [[self class] sortedArrayOfIndexPaths:indexPaths ascending:NO];
    for (NSIndexPath * indexPath in reverseSortedIndexPaths)
    {
        id object = [self objectAtIndexPath:indexPath];
        
        if (object)
        {
            PLDataSourceSection * section = [self getValidSection:indexPath.section];
            [section.objects removeObjectAtIndex:indexPath.row];
            [self.currentUpdate.deletedRowIndexPaths addObject:indexPath];
        }
    }
    [self finishUpdate];
}

- (void)removeItems:(NSArray *)items
{
    [self startUpdate];
    
    NSArray * indexPaths = [self indexPathArrayForItems:items];
    
    for (NSObject * item in items)
    {
        NSIndexPath * indexPath = [self indexPathForItem:item];
        
        if (indexPath)
        {
            PLDataSourceSection * section = [self getValidSection:indexPath.section];
            [section.objects removeObjectAtIndex:indexPath.row];
        }
    }
    [self.currentUpdate.deletedRowIndexPaths addObjectsFromArray:indexPaths];
    [self finishUpdate];
}

#pragma  mark - Sections

- (void)deleteSections:(NSIndexSet *)indexSet
{
    [self startUpdate];
    [self.sections removeObjectsAtIndexes:indexSet];
    [self.currentUpdate.deletedSectionIndexes addIndexes:indexSet];
    [self finishUpdate];
}

#pragma mark - items

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    PLDataSourceSection *section = nil;
    if (indexPath.section < [self.sections count])
    {
        section = self.sections[indexPath.section];
    }
    else
    {
        return nil;
    }
    
    if (indexPath.row < [section.objects count])
    {
        return section.objects[indexPath.row];
    }
    else
    {
        return nil;
    }
}

- (NSIndexPath *)indexPathForItem:(id)item
{
    for (NSUInteger sectionNumber = 0; sectionNumber < self.sections.count; sectionNumber++)
    {
        NSArray * rows = [self.sections[sectionNumber] objects];
        NSUInteger index = [rows indexOfObject:item];
        
        if (index != NSNotFound)
        {
            return [NSIndexPath indexPathForRow:index inSection:sectionNumber];
        }
    }
    return nil;
}

- (PLDataSourceSection *)sectionAtIndex:(NSUInteger)sectionNumber
{
    [self startUpdate];
    PLDataSourceSection * section = [self getValidSection:sectionNumber];
    [self finishUpdate];
    
    return section;
}

#pragma mark - private

- (PLDataSourceSection *)getValidSection:(NSUInteger)sectionNumber
{
    if (sectionNumber < self.sections.count)
    {
        return self.sections[sectionNumber];
    }
    else
    {
        for (NSInteger i = self.sections.count; i <= sectionNumber; i++)
        {
            PLDataSourceSection * section = [PLDataSourceSection new];
            [self.sections addObject:section];
            
            [self.currentUpdate.insertedSectionIndexes addIndex:i];
        }
        return [self.sections lastObject];
    }
}

//This implementation is not optimized, and may behave poorly with lot of sections
- (NSArray *)indexPathArrayForItems:(NSArray *)items
{
    NSMutableArray * indexPaths = [[NSMutableArray alloc] initWithCapacity:[items count]];
    
    for (NSInteger i = 0; i < [items count]; i++)
    {
        NSIndexPath * foundIndexPath = [self indexPathForItem:[items objectAtIndex:i]];
        if (foundIndexPath)
        {
            [indexPaths addObject:foundIndexPath];
        }
    }
    return indexPaths;
}

+(NSArray *)sortedArrayOfIndexPaths:(NSArray *)indexPaths ascending:(BOOL)ascending
{
    NSSortDescriptor * descriptor = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:ascending];
    return [indexPaths sortedArrayUsingDescriptors:@[descriptor]];
}


@end
