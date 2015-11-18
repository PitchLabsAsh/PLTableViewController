//
//  PLTableViewController.m
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLTableViewController.h"
#import "PLDataSource.h"
#import "PLTableViewFactory.h"

@interface PLTableViewController () < PLDataSourceUpdating,PLTableViewFactoryDelegate >

@end

@implementation PLTableViewController

@synthesize dataSource = _dataSource;
@synthesize cellFactory = _cellFactory;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        [self setupTableViewControllerDefaults];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setupTableViewControllerDefaults];
    }
    return self;
}

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)sectionNumber
{
    PLDataSourceSection *dataSection = [self.dataSource sectionAtIndex:sectionNumber];
    if ([dataSection.headerModel isKindOfClass:[NSString class]])
        return dataSection.headerModel;
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)sectionNumber
{
    PLDataSourceSection *dataSection = [self.dataSource sectionAtIndex:sectionNumber];
    if ([dataSection.footerModel isKindOfClass:[NSString class]])
        return dataSection.footerModel;
    return nil;
}

- (void)setupTableViewControllerDefaults
{
    // the default animations used on data source changes
    _insertSectionAnimation = UITableViewRowAnimationNone;
    _deleteSectionAnimation = UITableViewRowAnimationAutomatic;
    _reloadSectionAnimation = UITableViewRowAnimationAutomatic;
    
    _insertRowAnimation = UITableViewRowAnimationAutomatic;
    _deleteRowAnimation = UITableViewRowAnimationAutomatic;
    _reloadRowAnimation = UITableViewRowAnimationAutomatic;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PLDataSourceSection *dataSection = [self.dataSource sectionAtIndex:section];
    return dataSection.objects.count;
}


-(PLDataSource *)dataSource
{
    if (!_dataSource)
    {
        PLDataSource * dataSource = [PLDataSource new];
        _dataSource = dataSource;
        _dataSource.delegate = self;
    }
    return _dataSource;
}

- (void)setDataSource:(PLDataSource *)dataSource
{
    _dataSource = dataSource;
    _dataSource.delegate = self;
}

-(PLTableViewFactory *)cellFactory
{
    if (!_cellFactory)
    {
        PLTableViewFactory *cellFactory = [PLTableViewFactory new];
        _cellFactory = cellFactory;
        _cellFactory.delegate = self;
    }
    return _cellFactory;
}

- (void)setCellFactory:(PLTableViewFactory *)cellFactory
{
    _cellFactory = cellFactory;
    _cellFactory.delegate = self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = [self.dataSource itemAtIndexPath:indexPath];
    return [self.cellFactory cellForModel:model atIndexPath:indexPath];
}

#pragma mark - PLDataSourceUpdating delegate methods


- (void)dataSourceWillPerformUpdate
{
    
}

- (void)dataSourceDidPerformUpdate:(PLDataSourceUpdate *)update
{
    [self.tableView beginUpdates];
    
    [self.tableView deleteSections:update.deletedSectionIndexes withRowAnimation:self.deleteSectionAnimation];
    [self.tableView insertSections:update.insertedSectionIndexes withRowAnimation:self.insertSectionAnimation];
    [self.tableView reloadSections:update.updatedSectionIndexes withRowAnimation:self.reloadSectionAnimation];
    
    [self.tableView deleteRowsAtIndexPaths:update.deletedRowIndexPaths withRowAnimation:self.deleteRowAnimation];
    [self.tableView insertRowsAtIndexPaths:update.insertedRowIndexPaths withRowAnimation:self.insertRowAnimation];
    [self.tableView reloadRowsAtIndexPaths:update.updatedRowIndexPaths withRowAnimation:self.reloadRowAnimation];
    
    [self.tableView endUpdates];
}

- (void)dataSourceFailedUpdate:(NSError*)error;
{
    
}

- (void)dataSourceNeedsReload
{
    [self.tableView reloadData];
}

@end
