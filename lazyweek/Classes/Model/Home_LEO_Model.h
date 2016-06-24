//
//  Home_LEO_Model.h
//  lazyweek
//
//  Created by 尹成 on 16/6/24.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "HomeModel.h"

@interface Home_LEO_Model : HomeModel

@property (nonatomic, assign) NSNumber     *category_id;
@property (nonatomic, assign) NSNumber     *collected_num;
@property (nonatomic, copy  ) NSString     *time_desc;

/**
 *  {start:@"",end:@""}
 */
@property (nonatomic, strong) NSDictionary *time;
@property (nonatomic, copy  ) NSString     *title;
@property (nonatomic, assign) NSNumber     *show_free;
@property (nonatomic, assign) NSNumber     *want_status;
/**
 *  (@"情侣",@"单身")
 */
@property (nonatomic, strong) NSArray      *tags;
@property (nonatomic, copy  ) NSString     *consult_phone;
@property (nonatomic, assign) NSNumber     *sell_status;
@property (nonatomic, strong) NSArray      *front_cover_image_list;
@property (nonatomic, copy  ) NSString     *category;
@property (nonatomic, copy  ) NSString     *time_info;
/**
 *  目的
 */
@property (nonatomic, copy  ) NSString     *jump_type;
@property (nonatomic, copy  ) NSString     *price_info;
@property (nonatomic, assign) NSNumber     *distance;

@property (nonatomic, assign) NSNumber     *viewed_num;
@property (nonatomic, copy  ) NSString     *biz_phone;
@property (nonatomic, copy  ) NSString     *item_type;
@property (nonatomic, assign) NSNumber     *price;
@property (nonatomic, copy  ) NSString     *poi_name;
@property (nonatomic, assign) NSNumber     *leo_id;
@property (nonatomic, copy  ) NSString     *jump_data;
/**
 *  集合地
 */
@property (nonatomic, copy) NSString *address;

@end
