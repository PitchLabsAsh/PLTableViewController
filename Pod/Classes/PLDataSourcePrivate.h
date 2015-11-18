//
//  PLDataSourcePrivate.h
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLDataSource.h"

@interface PLDataSource ()

@property (nonatomic, strong) PLDataSourceUpdate * currentUpdate;

- (void)startUpdate;
- (void)finishUpdate;

@end

