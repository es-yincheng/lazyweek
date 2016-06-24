//
//  Home_EVENT_Model.h
//  lazyweek
//
//  Created by 尹成 on 16/6/24.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "HomeModel.h"

@interface Home_EVENT_Model : HomeModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *item_type;
@property (nonatomic, copy) NSString *jump_data;
@property (nonatomic, copy) NSString *jump_type;
@property (nonatomic, strong) NSArray *front_cover_image_list;


@end
