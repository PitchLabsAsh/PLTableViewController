//
//  UIView+utitlities.h
//  PitchData
//
//  Created by Ash Thwaites on 20/06/2015.
//  Copyright (c) 2015 Ash Thwaites. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIView (utitlities)

+ (instancetype) loadFromXibNamed:(NSString *) xibName;
+ (instancetype) loadFromXib;

- (void) forEachButtonDoBlock:(void (^)(UIButton *button))block;
- (void) forEachSubviewOfClass:(Class)viewClass doBlock:(void (^)(UIView *view))block;

@end
