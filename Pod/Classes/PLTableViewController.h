//
//  PLTableViewController.h
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import <UIKit/UIKit.h>

@class PLDataSource;
@class PLTableViewFactory;

@interface PLTableViewController : UITableViewController 

@property (nonatomic, assign) UITableViewRowAnimation insertSectionAnimation;
@property (nonatomic, assign) UITableViewRowAnimation deleteSectionAnimation;
@property (nonatomic, assign) UITableViewRowAnimation reloadSectionAnimation;
@property (nonatomic, assign) UITableViewRowAnimation insertRowAnimation;
@property (nonatomic, assign) UITableViewRowAnimation deleteRowAnimation;
@property (nonatomic, assign) UITableViewRowAnimation reloadRowAnimation;

@property (nonatomic, strong, null_resettable) PLDataSource *dataSource;
@property (nonatomic, strong, null_resettable) PLTableViewFactory * cellFactory;

@end
