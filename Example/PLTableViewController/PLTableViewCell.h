//
//  PLTableViewCell.h
//  PLTableViewController
//
//  Created by Ash Thwaites on 18/11/2015.
//  Copyright © 2015 Ash Thwaites. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PLTableViewController/PLModelTransfer.h>

@interface PLTableViewCell : UITableViewCell <PLModelTransfer>

@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

@end
