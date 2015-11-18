//
//  PLTableViewCell.m
//  PLTableViewController
//
//  Created by Ash Thwaites on 18/11/2015.
//  Copyright © 2015 Ash Thwaites. All rights reserved.
//

#import "PLTableViewCell.h"

@implementation PLTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithModel:(id)model
{
    if ([model isKindOfClass:[NSString class]])
    {
        self.cellLabel.text = model;
    }
}


@end
