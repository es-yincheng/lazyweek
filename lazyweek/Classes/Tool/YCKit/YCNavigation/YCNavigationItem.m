//
//  YCNavigationItem.m
//  lazyweek
//
//  Created by 尹成 on 16/6/25.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "YCNavigationItem.h"

@implementation YCNavigationItem

- (void)setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem{
    if (self.leftBarButtonItem.image) {
        self.leftBarButtonItem.image = [self.leftBarButtonItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
}

@end
