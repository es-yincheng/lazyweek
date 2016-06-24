//
//  BaseModel.h
//  lazyweek
//
//  Created by 尹成 on 16/6/24.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface BaseModel : NSObject

+ (NSMutableArray *)ycs_objectWithKeyValues:(id)keyValues;

+ (instancetype)yc_objectWithKeyValues:(id)keyValues;

@end
