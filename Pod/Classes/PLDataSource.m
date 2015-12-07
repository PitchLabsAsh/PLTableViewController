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

- (NSInteger)numberOfSections;
{
    return 0;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section;
{
    return 0;
}

- (nullable id)itemAtIndexPath:(NSIndexPath *)indexPath;
{
    return nil;
}

- (nullable NSIndexPath *)indexPathForItem:(id)item;
{
    return nil;
}


- (id)headerModelForSection:(NSInteger)section;
{
    return nil;
}

- (id)footerModelForSection:(NSInteger)section;
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
