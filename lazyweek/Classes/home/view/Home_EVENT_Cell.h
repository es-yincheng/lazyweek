//
//  Home_LEO_Cell.h
//  lazyweek
//
//  Created by 尹成 on 16/6/24.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Home_EVENT_Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *itemType;

- (void)configWithModel:(id)model;
@end
