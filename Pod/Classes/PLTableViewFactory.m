//
//  PLTableViewFactory.m
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//



#import "PLTableViewFactory.h"
#import "UIView+utitlities.h"
#import "PLRuntimeHelper.h"
#import "PLModelTransfer.h"

@interface PLTableViewFactory ()

@property (nonatomic,strong) NSMutableDictionary * cellMappingsDictionary;
@property (nonatomic,strong) NSMutableDictionary * headerMappingsDictionary;
@property (nonatomic,strong) NSMutableDictionary * footerMappingsDictionary;

@end

@implementation PLTableViewFactory

- (NSMutableDictionary *)cellMappingsDictionary
{
    if (!_cellMappingsDictionary)
        _cellMappingsDictionary = [[NSMutableDictionary alloc] init];
    return _cellMappingsDictionary;
}

-(NSMutableDictionary *)headerMappingsDictionary
{
    if (!_headerMappingsDictionary)
        _headerMappingsDictionary = [[NSMutableDictionary alloc] init];
    return _headerMappingsDictionary;
}

-(NSMutableDictionary *)footerMappingsDictionary
{
    if (!_footerMappingsDictionary)
        _footerMappingsDictionary = [[NSMutableDictionary alloc] init];
    return _footerMappingsDictionary;
}

#pragma mark - check for features

-(BOOL)nibExistsWIthNibName:(NSString *)nibName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"];
    if (path)
    {
        return YES;
    }
    return NO;
}

#pragma mark - class mapping

-(void)registerCellClass:(Class)cellClass forModelClass:(Class)modelClass
{
    NSParameterAssert([cellClass isSubclassOfClass:[UITableViewCell class]]);
    NSParameterAssert([cellClass conformsToProtocol:@protocol(PLModelTransfer)]);
    NSParameterAssert(modelClass);
    
    NSString * reuseIdentifier = [PLRuntimeHelper classStringForClass:cellClass];
    UITableViewCell * tableCell = [[self.delegate tableView] dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!tableCell)
    {
        // Storyboard prototype cell
        [[self.delegate tableView] registerClass:cellClass
                          forCellReuseIdentifier:reuseIdentifier];
        
        if ([self nibExistsWIthNibName:[PLRuntimeHelper classStringForClass:cellClass]])
        {
            [self registerNibNamed:[PLRuntimeHelper classStringForClass:cellClass]
                      forCellClass:cellClass
                        modelClass:modelClass];
        }
    }

    [self.cellMappingsDictionary setObject:[PLRuntimeHelper classStringForClass:cellClass]
                                    forKey:[PLRuntimeHelper modelStringForClass:modelClass]];
}

-(void)registerNibNamed:(NSString *)nibName
           forCellClass:(Class)cellClass
             modelClass:(Class)modelClass
{
    NSParameterAssert(nibName);
    NSParameterAssert([cellClass conformsToProtocol:@protocol(PLModelTransfer)]);
    NSParameterAssert(modelClass);

    NSAssert([self nibExistsWIthNibName:nibName], @"Nib should exist for registerNibNamed method");
    
    [[self.delegate tableView] registerNib:[UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]]
                    forCellReuseIdentifier:[PLRuntimeHelper classStringForClass:cellClass]];
    
    [self.cellMappingsDictionary setObject:[PLRuntimeHelper classStringForClass:cellClass]
                                    forKey:[PLRuntimeHelper modelStringForClass:modelClass]];
}

-(void)registerHeaderClass:(Class)headerClass forModelClass:(Class)modelClass
{
    [self registerNibNamed:[PLRuntimeHelper classStringForClass:headerClass]
            forHeaderClass:headerClass
                modelClass:modelClass];
}

-(void)registerNibNamed:(NSString *)nibName forHeaderClass:(Class)headerClass
             modelClass:(Class)modelClass
{
    NSParameterAssert(nibName);
    NSParameterAssert([headerClass conformsToProtocol:@protocol(PLModelTransfer)]);
    NSParameterAssert(modelClass);
    NSAssert([self nibExistsWIthNibName:nibName], @"Nib should exist for registerNibNamed method");
    
    if ([headerClass isSubclassOfClass:[UITableViewHeaderFooterView class]])
    {
        [[self.delegate tableView] registerNib:[UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]]
            forHeaderFooterViewReuseIdentifier:[PLRuntimeHelper classStringForClass:headerClass]];
    }
    
    [self.headerMappingsDictionary setObject:NSStringFromClass(headerClass)
                                      forKey:[PLRuntimeHelper modelStringForClass:modelClass]];
}

-(void)registerFooterClass:(Class)footerClass forModelClass:(Class)modelClass
{
    NSParameterAssert(footerClass);
    NSParameterAssert(modelClass);

    [self registerNibNamed:[PLRuntimeHelper classStringForClass:footerClass]
            forFooterClass:footerClass
                modelClass:modelClass];
}

-(void)registerNibNamed:(NSString *)nibName forFooterClass:(Class)footerClass
             modelClass:(Class)modelClass
{
    NSParameterAssert(nibName);
    NSParameterAssert([footerClass conformsToProtocol:@protocol(PLModelTransfer)]);
    NSParameterAssert(modelClass);
    NSAssert([self nibExistsWIthNibName:nibName], @"Nib should exist for registerNibNamed method");
    
    if ([footerClass isSubclassOfClass:[UITableViewHeaderFooterView class]])
    {
        [[self.delegate tableView] registerNib:[UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]]
            forHeaderFooterViewReuseIdentifier:[PLRuntimeHelper classStringForClass:footerClass]];
    }
    
    [self.footerMappingsDictionary setObject:NSStringFromClass(footerClass)
                                      forKey:[PLRuntimeHelper modelStringForClass:modelClass]];
}

-(void)setFooterClassMapping:(Class)footerClass forModelClass:(Class)modelClass
{
    [self.footerMappingsDictionary setObject:NSStringFromClass(footerClass)
                                      forKey:[PLRuntimeHelper modelStringForClass:modelClass]];
}

#pragma mark - View creation

- (UITableViewCell *)cellForModel:(id)model atIndexPath:(NSIndexPath *)indexPath
{
    NSString * reuseIdentifier = [self cellReuseIdentifierForModel:model];
    UITableViewCell <PLModelTransfer> * cell = [[self.delegate tableView] dequeueReusableCellWithIdentifier:reuseIdentifier
                                                                                               forIndexPath:indexPath];
    [cell updateWithModel:model];
    return cell;
}

-(UIView *)headerFooterViewForViewClass:(Class)viewClass
{
    NSString * reuseIdentifier = [PLRuntimeHelper classStringForClass:viewClass];
    UIView * view = [[self.delegate tableView] dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];

    if (!view)
    {
        view = [viewClass loadFromXib];
    }
    return view;
}

-(UIView *)headerViewForModel:(id)model
{
    Class headerClass = [self headerClassForModel:model];
    
    UIView <PLModelTransfer> * view = (id)[self headerFooterViewForViewClass:headerClass];
    [view updateWithModel:model];

    return view;
}

-(UIView *)footerViewForModel:(id)model
{
    Class footerClass = [self footerClassForModel:model];
    
    UIView <PLModelTransfer> * view = (id)[self headerFooterViewForViewClass:footerClass];
    [view updateWithModel:model];
    
    return view;
}

- (NSString *)cellReuseIdentifierForModel:(id)model
{
    NSString *modelClassName = [PLRuntimeHelper modelStringForClass:[model class]];
    
    NSString * cellClassString = [self.cellMappingsDictionary objectForKey:modelClassName];
    
    NSAssert(cellClassString, @"PLCellFactory does not have cell mapping for model class: %@",[model class]);
    
    return cellClassString;
}

-(Class)headerClassForModel:(id)model
{
    NSString *modelClassName = [PLRuntimeHelper modelStringForClass:[model class]];
    
    NSString * headerClassString = [self.headerMappingsDictionary objectForKey:modelClassName];
    
    NSAssert(headerClassString, @"PLCellFactory does not have header mapping for model class: %@",[model class]);
    
    return NSClassFromString(headerClassString);
}

-(Class)footerClassForModel:(id)model
{
    NSString *modelClassName = [PLRuntimeHelper modelStringForClass:[model class]];
    
    NSString * footerClassString = [self.footerMappingsDictionary objectForKey:modelClassName];
    
    NSAssert(footerClassString, @"PLCellFactory does not have footer mapping for model class: %@",[model class]);
    
    return NSClassFromString(footerClassString);
}

@end
