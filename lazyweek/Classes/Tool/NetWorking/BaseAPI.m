//
//  BaseApi.m
//  lazyweek
//
//  Created by 尹成 on 16/6/24.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "BaseAPI.h"

static BaseAPI *api;

@implementation BaseAPI

+ (BaseAPI *)sharedAPI{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        api = [[BaseAPI alloc] init];
    });
    return api;
}


- (id)init
{
    self = [super init];
    if(self)
    {
        _homeService = [[HomeService alloc] init];
    }
    return (self);
}

@end
