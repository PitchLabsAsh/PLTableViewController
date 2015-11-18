//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLDataSourceUpdate.h"

@implementation PLDataSourceUpdate

- (NSMutableIndexSet *)deletedSectionIndexes
{
    if (!_deletedSectionIndexes)
    {
        _deletedSectionIndexes = [NSMutableIndexSet indexSet];
    }
    return _deletedSectionIndexes;
}

- (NSMutableIndexSet *)insertedSectionIndexes
{
    if (!_insertedSectionIndexes)
    {
        _insertedSectionIndexes = [NSMutableIndexSet indexSet];
    }
    return _insertedSectionIndexes;
}

- (NSMutableIndexSet *)updatedSectionIndexes
{
    if (!_updatedSectionIndexes)
    {
        _updatedSectionIndexes = [NSMutableIndexSet indexSet];
    }
    return _updatedSectionIndexes;
}

- (NSMutableArray *)deletedRowIndexPaths
{
    if (!_deletedRowIndexPaths)
    {
        _deletedRowIndexPaths = [NSMutableArray array];
    }
    return _deletedRowIndexPaths;
}

- (NSMutableArray *)insertedRowIndexPaths
{
    if (!_insertedRowIndexPaths)
    {
        _insertedRowIndexPaths = [NSMutableArray array];
    }
    return _insertedRowIndexPaths;
}

- (NSMutableArray *)updatedRowIndexPaths
{
    if (!_updatedRowIndexPaths)
    {
        _updatedRowIndexPaths = [NSMutableArray array];
    }
    return _updatedRowIndexPaths;
}


-(BOOL)isEmpty
{
    return self.insertedRowIndexPaths.count == 0 &&
            self.updatedRowIndexPaths.count == 0 &&
            self.deletedRowIndexPaths.count == 0 &&
            self.insertedSectionIndexes.count == 0 &&
            self.updatedSectionIndexes.count == 0 &&
            self.deletedSectionIndexes.count == 0;
}

@end
