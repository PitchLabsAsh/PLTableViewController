//
//  PLTableViewFactory.h
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if __has_feature(nullability) // Xcode 6.3+
#pragma clang assume_nonnull begin
#else
#define nullable
#define __nullable
#endif


@protocol PLTableViewFactoryDelegate
-(UITableView *)tableView;
@end


@interface PLTableViewFactory : NSObject

// register class for models
-(void)registerCellClass:(Class)cellClass forModelClass:(Class)modelClass;
-(void)registerHeaderClass:(Class)headerClass forModelClass:(Class)modelClass;
-(void)registerFooterClass:(Class)footerClass forModelClass:(Class)modelClass;

// register nibs for models
-(void)registerNibNamed:(NSString *)nibName forCellClass:(Class)cellClass modelClass:(Class)modelClass;
-(void)registerNibNamed:(NSString *)nibName forHeaderClass:(Class)headerClass modelClass:(Class)modelClass;
-(void)registerNibNamed:(NSString *)nibName forFooterClass:(Class)footerClass modelClass:(Class)modelClass;

// factory methods
-(UITableViewCell *)cellForModel:(NSObject *)model atIndexPath:(NSIndexPath *)indexPath;
-(UIView *)headerViewForModel:(id)model;
-(UIView *)footerViewForModel:(id)model;

@property (nonatomic, weak) id <PLTableViewFactoryDelegate> delegate;

@end

#if __has_feature(nullability)
#pragma clang assume_nonnull end
#endif
