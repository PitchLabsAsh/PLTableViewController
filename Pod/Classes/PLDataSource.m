//
//  PLDataSource.m
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLDataSource.h"
#import "PLDataSourcePrivate.h"


@implementation PLDataSource


- (nullable PLDataSourceSection*)sectionAtIndex:(NSUInteger)sectionNumber;
{
    return nil;
}

- (nullable id)itemAtIndexPath:(NSIndexPath *)indexPath;
{
    return nil;
}

- (nullable NSIndexPath *)indexPathForItem:(id)item;
{
    return nil;
}


#pragma mark - Updates

- (void)startUpdate
{
    self.currentUpdate = [PLDataSourceUpdate new];
}

- (void)finishUpdate
{
    if (!self.currentUpdate.isEmpty)
    {
        if ([self.delegate respondsToSelector:@selector(dataSourceDidPerformUpdate:)])
        {
            [self.delegate dataSourceDidPerformUpdate:self.currentUpdate];
        }
    }
    
    self.currentUpdate = nil;
}


@end
