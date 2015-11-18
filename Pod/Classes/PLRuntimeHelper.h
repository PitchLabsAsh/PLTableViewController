//
//  PLRuntimeHelper.h
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import <Foundation/Foundation.h>

#pragma clang assume_nonnull begin

@interface PLRuntimeHelper : NSObject

+ (NSString *)classStringForClass:(Class)klass;
+ (NSString *)modelStringForClass:(Class)klass;

@end

#pragma clang assume_nonnull end
