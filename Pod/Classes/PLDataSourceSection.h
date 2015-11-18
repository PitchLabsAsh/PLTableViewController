//
//  PLDataSourceSection.h
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma clang assume_nonnull begin

@interface PLDataSourceSection : NSObject

@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, strong) id headerModel;
@property (nonatomic, strong) id footerModel;

@end

#pragma clang assume_nonnull end