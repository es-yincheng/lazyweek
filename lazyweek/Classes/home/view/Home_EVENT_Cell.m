//
//  Home_LEO_Cell.m
//  lazyweek
//
//  Created by 尹成 on 16/6/24.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "Home_EVENT_Cell.h"
#import "Home_EVENT_Model.h"
#import "UIImageView+WebCache.h"

#define BoardColor [UIColor colorWithRed:0.886 green:0.871 blue:0.882 alpha:1.000].CGColor

@implementation Home_EVENT_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.itemType.layer.masksToBounds = YES;
    self.itemType.layer.cornerRadius = 4;
    self.itemType.layer.borderWidth = 0.5;
    self.itemType.layer.borderColor = BoardColor;
    self.itemType.text = [NSString stringWithFormat:@"  精选  "];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configWithModel:(id)model{
    
    Home_EVENT_Model *eventModel = (Home_EVENT_Model *)model;
    [self.itemImage sd_setImageWithURL:[NSURL URLWithString:[eventModel.front_cover_image_list objectAtIndex:0]]];
    self.itemTitle.text = eventModel.title;
}

@end
