//
//  HomeTableViewCell.h
//  lazyweek
//
//  Created by 尹成 on 16/6/24.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *itemPoi;
@property (weak, nonatomic) IBOutlet UILabel *itemTimeStr;
@property (weak, nonatomic) IBOutlet UILabel *itemFavorite;
@property (weak, nonatomic) IBOutlet UILabel *itemPrice;

- (void)configWithModel:(id)model;

@end
