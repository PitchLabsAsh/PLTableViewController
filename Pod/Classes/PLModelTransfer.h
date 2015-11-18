//
//  PLModelTransfer.h
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//



#import <Foundation/Foundation.h>

#pragma clang assume_nonnull begin


@protocol PLModelTransfer

@required

- (void)updateWithModel:(id)model;

@optional

- (id)model;

@end

#pragma clang assume_nonnull end
