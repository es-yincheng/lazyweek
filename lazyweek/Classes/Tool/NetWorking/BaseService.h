//
//  BaseService.h
//  lazyweek
//
//  Created by 尹成 on 16/6/24.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(NSDictionary *responseObject);
typedef void(^FailureBlock)(NSError *error);

@interface BaseService : NSObject

@property (nonatomic, copy) SuccessBlock success;
@property (nonatomic, copy) FailureBlock failure;

@end
