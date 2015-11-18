//
//  PLRuntimeHelper.m
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLRuntimeHelper.h"

@implementation PLRuntimeHelper

+(NSString *)classStringForClass:(Class)klass
{
    NSString * classString = NSStringFromClass(klass);
    if ([classString rangeOfString:@"."].location != NSNotFound)
    {
        // Swift class, format <ModuleName>.<ClassName>
        classString = [[classString componentsSeparatedByString:@"."] lastObject];
    }
    return classString;
}

+(NSString *)modelStringForClass:(Class)klass
{
    NSString * classString = [self classStringForClass:klass];
    if ([classString isEqualToString:@"__NSCFConstantString"] ||
        [classString isEqualToString:@"__NSCFString"] ||
        [classString isEqualToString:@"_NSContiguousString"] ||
        klass == [NSMutableString class])
    {
        return @"NSString";
    }
    if ([classString isEqualToString:@"__NSCFNumber"] ||
        [classString isEqualToString:@"__NSCFBoolean"])
    {
        return @"NSNumber";
    }
    if ([classString isEqualToString:@"__NSDictionaryI"] ||
        [classString isEqualToString:@"__NSDictionaryM"] ||
       ([classString rangeOfString:@"_NativeDictionaryStorageOwner"].location != NSNotFound) ||
        klass == [NSMutableDictionary class])
    {
        return @"NSDictionary";
    }
    if ([classString isEqualToString:@"__NSArrayI"] ||
        [classString isEqualToString:@"__NSArrayM"] ||
        [classString isEqualToString:@"_NSSwiftArrayImpl"] ||
        [classString isEqualToString:@"_SwiftDeferredNSArray"] ||
        ([classString rangeOfString:@"_ContiguousArrayStorage"].location != NSNotFound) ||
        klass == [NSMutableArray class])
    {
        return @"NSArray";
    }
    if ([classString isEqualToString:@"__NSDate"] || [classString isEqualToString:@"__NSTaggedDate"] || klass == [NSDate class])
    {
        return @"NSDate";
    }
    return classString;
}

@end
