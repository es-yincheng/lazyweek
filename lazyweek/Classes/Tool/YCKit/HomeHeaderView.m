//
//  HomeHeaderView.m
//  lazyweek
//
//  Created by 尹成 on 16/6/24.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "HomeHeaderView.h"

@interface HomeHeaderView()
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) UIButton *title;

@end

@implementation HomeHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.title];
    }
    return self;
}

- (void)changeTitle{
    [self.title setTitle:[self.titleArray objectAtIndex:arc4random() % self.titleArray.count] forState:UIControlStateNormal];
}

#pragma mark - lazy
- (UIButton *)title{
    if (!_title) {
        _title = [[UIButton alloc] initWithFrame:self.bounds];
        [_title setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _title.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.title setImage:[UIImage imageNamed:@"cat_me_icon"] forState:UIControlStateNormal];
    }
    return _title;
}

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        NSArray *tempArray = @[@"睁眼，因为你心为所动",
                               @"启程，只为追寻你所爱",
                               @"我们，做最了解你的人",
                               @"一起走吧，小懒猫",
                               @"保持一颗好奇心，因为世界是彩色的",
                               @"我们始终牵手旅行",
                               @"要和有趣的人在一起才会快乐",
                               @"",@"致总有一天会出发的你",
                               @"请把我留在最好的时光里",
                               @"世界是自己的，与他人无关",
                               @"闭目，难掩喜悦与期待"];
        _titleArray = [NSMutableArray arrayWithArray:tempArray];
    }
    return _titleArray;
}

@end
