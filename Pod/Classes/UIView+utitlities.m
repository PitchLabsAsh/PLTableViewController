//
//  UIView+utitlities.m
//  PitchData
//
//  Created by Ash Thwaites on 20/06/2015.
//  Copyright (c) 2015 Ash Thwaites. All rights reserved.
//

#import "UIView+utitlities.h"
#import "PLRuntimeHelper.h"

@implementation UIView (utitlities)

+ (id) loadFromXibNamed:(NSString *) xibName {
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName
                                                             owner:nil
                                                           options:nil];
    for(id currentObject in topLevelObjects) {
        if([currentObject isKindOfClass:self]) {
            return currentObject;
        }
    }
    return nil;
}

+ (id) loadFromXib {
    return [self loadFromXibNamed:[PLRuntimeHelper classStringForClass:self]];
}

- (void) forEachButtonDoBlock:(void (^)(UIButton *button))block
{
    for (UIView *subview in self.subviews)
    {
        if ([subview isKindOfClass:[UIButton class]])
        {
            block((UIButton *)subview);
        } else {
            [subview forEachButtonDoBlock:block];
        }
    }
}

- (void) forEachSubviewOfClass:(Class)viewClass doBlock:(void (^)(UIView *view))block;
{
    for (UIView *subview in self.subviews)
    {
        if ([subview isKindOfClass:viewClass])
        {
            block(subview);
        } else {
            [subview forEachSubviewOfClass:viewClass doBlock:block];
        }
    }
}

@end
