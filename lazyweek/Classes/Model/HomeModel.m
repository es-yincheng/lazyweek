
//
//  HomeModel.m
//  lazyweek
//
//  Created by 尹成 on 16/6/24.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "HomeModel.h"
#import "MBProgressHUD+MJ.h"
#import "Home_EVENT_Model.h"
#import "Home_LEO_Model.h"

@implementation HomeModel

+ (NSMutableArray *)ycs_objectWithKeyValues:(id)keyValues{
    
    if (200 != [[keyValues objectForKey:@"status"] intValue]) {
        [MBProgressHUD showMessageAuto:[NSString stringWithFormat:@"%@",[keyValues objectForKey:@"msg"]]];
        return nil;
    }
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    NSArray *resultArray = [keyValues objectForKey:@"result"];
    for (int x = 0; x < resultArray.count; x ++) {
        NSDictionary *dict = [resultArray objectAtIndex:x];
        if ([[dict objectForKey:@"item_type"] isEqualToString:@"event"]) {
            Home_EVENT_Model *model = [Home_EVENT_Model mj_objectWithKeyValues:dict];
            [tempArray addObject:model];
        }
        else if ([[dict objectForKey:@"item_type"] isEqualToString:@"leo"]) {
            Home_LEO_Model *model = [Home_LEO_Model mj_objectWithKeyValues:dict];
            [tempArray addObject:model];
        }
        else {
            NSLog(@"homeItem 新类型：%@",[dict objectForKey:@"item_type"]);
            NSLog(@"                                        \n                                          -\n                                       - - - -\n                                    - - - - - - -\n                                 - - - - - - - - - -\n                              - - - - - - - - - - - - - ");
        }
    }
    
    return tempArray;
}

//+ (NSMutableArray *)yc_objectWithKeyValues:(id)keyValues{
//    if ((0 != [[keyValues objectForKey:@"ErrorCode"] intValue]) ||
//        [keyValues objectForKey:@"Data"] == nil ||
//        ([keyValues objectForKey:@"Data"] == [NSNull null])) {
//        
//        [MBProgressHUD showMessageAuto:[NSString stringWithFormat:@"%@",[keyValues objectForKey:@"ErrorMsg"]]];
//        return nil;
//    }
//    
//    NSArray *orders = [[keyValues objectForKey:@"Data"] objectForKey:@"Items"];
//    return [self mj_objectArrayWithKeyValuesArray:orders context:nil];
//}


//+ (instancetype)yc_objectWithKeyValues:(id)keyValues{
//    
//    if ((0 != [[keyValues objectForKey:@"ErrorCode"] intValue]) ||
//        [keyValues objectForKey:@"Data"] == nil ||
//        ([keyValues objectForKey:@"Data"] == [NSNull null])) {
//        
//        [MBProgressHUD showMessageAuto:[NSString stringWithFormat:@"%@",[keyValues objectForKey:@"ErrorMsg"]]];
//        return nil;
//    }
//    
//    return [self mj_objectWithKeyValues:[keyValues objectForKey:@"Data"] context:nil];
//}

@end
