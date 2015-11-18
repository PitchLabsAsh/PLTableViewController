//
//  PLDataSourceSection.m
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLDataSourceSection.h"

@implementation PLDataSourceSection

- (NSMutableArray *)objects
{
    if (!_objects)
    {
        _objects = [NSMutableArray array];
    }
    return _objects;
}


- (NSUInteger)numberOfObjects
{
    return [self.objects count];
}


@end
