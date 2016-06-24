//
//  YCRefreshHeader.m
//  lazyweek
//
//  Created by 尹成 on 16/6/24.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "YCRefreshHeader.h"

@interface YCRefreshHeader(){
    NSArray  *titleArray;
}

//@property (weak, nonatomic) UILabel *label;
//@property (weak, nonatomic) UIImageView *logo;

@property (weak, nonatomic  ) UIButton *title;

@end


@implementation YCRefreshHeader

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    titleArray = @[@"睁眼，因为你心为所动",
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
    
//    // 添加label
//    UILabel *label = [[UILabel alloc] init];
//    label.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
//    label.font = [UIFont boldSystemFontOfSize:16];
//    label.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:label];
//    self.label = label;
//    
//    // logo
//    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
//    logo.contentMode = UIViewContentModeScaleAspectFit;
//    [self addSubview:logo];
//    self.logo = logo;

    UIButton *button = [[UIButton alloc] init];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:button];
    self.title = button;
    
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.title.bounds = CGRectMake(0, 5, self.bounds.size.width, 40);
    self.title.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);

//    self.label.frame = self.bounds;
//    
//    self.logo.bounds = CGRectMake(0, 0, self.bounds.size.width, 100);
//    self.logo.center = CGPointMake(self.mj_w * 0.5, - self.logo.mj_h + 20);
    
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStatePulling:
            [self.title setImage:[UIImage imageNamed:@"cat_me_icon"] forState:UIControlStateNormal];
            [self.title setTitle:[titleArray objectAtIndex:arc4random() % titleArray.count] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
//    switch (state) {
//        case MJRefreshStateIdle:
//            [self.loading stopAnimating];
//            [self.s setOn:NO animated:YES];
//            self.label.text = @"赶紧下拉吖(开关是打酱油滴)";
//            break;
//        case MJRefreshStatePulling:
//            [self.loading stopAnimating];
//            [self.s setOn:YES animated:YES];
//            self.label.text = @"赶紧放开我吧(开关是打酱油滴)";
//            break;
//        case MJRefreshStateRefreshing:
//            [self.s setOn:YES animated:YES];
//            self.label.text = @"加载数据中(开关是打酱油滴)";
//            [self.loading startAnimating];
//            break;
//        default:
//            break;
//    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
//    NSLog(@"pullingPercent:%f",pullingPercent);
    
    self.mj_h = (pullingPercent + 1) * 50;
    
//    self.title.center = CGPointMake(self.mj_w * 0.5, (self.mj_h + pullingPercent) * 0.5);
//    self.title.bounds = CGRectMake(0, -pullingPercent * 10, self.bounds.size.width, 40);
    
    
//    CGFloat red = 1.0 - pullingPercent * 0.5;
//    CGFloat green = 0.5 - 0.5 * pullingPercent;
//    CGFloat blue = 0.5 * pullingPercent;
//    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}


@end