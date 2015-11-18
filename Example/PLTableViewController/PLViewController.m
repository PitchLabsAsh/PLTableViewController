//
//  PLViewController.m
//  PLTableViewController
//
//  Created by Ash Thwaites on 11/17/2015.
//  Copyright (c) 2015 Ash Thwaites. All rights reserved.
//

#import "PLViewController.h"
#import "PLTableViewCell.h"

@interface PLViewController ()

@end

@implementation PLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.cellFactory registerCellClass:[PLTableViewCell class] forModelClass:[NSString class]];
    
    PLMemoryDataSource *testSource = [PLMemoryDataSource new];
    self.dataSource = testSource;
    [testSource addItems:@[@"First",@"Second",@"Third"]];
    [testSource addItems:@[@"First",@"Second",@"Third"] toSection:1];
    
    PLDataSourceSection *section = testSource.sections[0];
    section.headerModel = @"Section1";

    PLDataSourceSection *section2 = testSource.sections[1];
    section2.headerModel = @"Section2";

    
}


@end
