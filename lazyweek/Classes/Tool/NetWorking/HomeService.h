//
//  HomeService.h
//  lazyweek
//
//  Created by 尹成 on 16/6/24.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"

@interface HomeService : BaseService

- (void)getHomeItemsWithPageIndex:(NSNumber *)pageIndex
                          success:(SuccessBlock)success
                          failure:(FailureBlock)failure;

@end
