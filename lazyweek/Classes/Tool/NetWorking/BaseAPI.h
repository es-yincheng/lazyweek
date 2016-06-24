//
//  BaseApi.h
//  lazyweek
//
//  Created by 尹成 on 16/6/24.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeService.h"

@interface BaseAPI : NSObject

@property (strong, nonatomic) HomeService   *homeService;

+ (BaseAPI *)sharedAPI;

@end
