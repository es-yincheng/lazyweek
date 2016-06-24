//
//  HomeService.m
//  lazyweek
//
//  Created by 尹成 on 16/6/24.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "HomeService.h"
#import "NetWorking.h"


@implementation HomeService

- (void)getHomeItemsWithPageIndex:(NSNumber *)pageIndex
                          success:(SuccessBlock)success
                          failure:(FailureBlock)failure{
    
    NSString *getHomeItems = [NSString stringWithFormat:@"http://api.lanrenzhoumo.com/main/recommend/index/?city_id=0&lat=31.16539&lon=121.3992&page=%@&session_id=00004252ee76b1a75988ac676581ee387eeac4&v=3",[NSString stringWithFormat:@"%@",pageIndex]];
    
    [[NetWorking sharedNetWorking] getDataWithUrl:getHomeItems Success:success Failure:failure];
    
}

@end
