//
//  HomeTableViewCell.m
//  lazyweek
//
//  Created by 尹成 on 16/6/24.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "Home_LEO_Model.h"
#import "UIImageView+WebCache.h"

#define BoardColor [UIColor colorWithRed:0.886 green:0.871 blue:0.882 alpha:1.000].CGColor

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.itemFavorite.layer.masksToBounds = YES;
    self.itemFavorite.layer.cornerRadius = 4;
    self.itemFavorite.layer.borderWidth = 0.5;
    self.itemFavorite.layer.borderColor = BoardColor;
    
    self.itemTimeStr.layer.masksToBounds = YES;
    self.itemTimeStr.layer.cornerRadius = 4;
    self.itemTimeStr.layer.borderWidth = 0.5;
    self.itemTimeStr.layer.borderColor = BoardColor;
    
    self.itemPrice.layer.masksToBounds = YES;
    self.itemPrice.layer.cornerRadius = 4;
    self.itemPrice.layer.borderWidth = 0.5;
    self.itemPrice.layer.borderColor = BoardColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)configWithModel:(id)model{
    
    Home_LEO_Model *leoModel = (Home_LEO_Model *)model;
    [self.itemImage sd_setImageWithURL:[NSURL URLWithString:[leoModel.front_cover_image_list objectAtIndex:0]]];
    self.itemTitle.text = leoModel.title;
    self.itemPoi.text = [NSString stringWithFormat:@"%@ · %ldkm · %@",leoModel.poi_name,[leoModel.distance integerValue]/1000,leoModel.category];
    self.itemTimeStr.text = [NSString stringWithFormat:@" %@ ",leoModel.time_info];
    if ([leoModel.collected_num intValue] == 0) {
        self.itemFavorite.text = [NSString stringWithFormat:@"      收藏  "];
    } else {
        self.itemFavorite.text = [NSString stringWithFormat:@"      %@收藏  ",leoModel.collected_num];
        
    }
    if (leoModel.price_info.length == 0) {
        self.itemPrice.text = [NSString stringWithFormat:@" 免费 "];
    } else {
        self.itemPrice.text = [NSString stringWithFormat:@" ￥%@ ",leoModel.price];
    }
}

@end
