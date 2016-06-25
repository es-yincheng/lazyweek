//
//  YCNavigationController.m
//  lazyweek
//
//  Created by 尹成 on 16/6/25.
//  Copyright © 2016年 尹成. All rights reserved.
//



/**
    navigationcontroller
    navigationbar
    navigationitem
 
 
 
 
 
 
 */



#import "YCNavigationController.h"

@interface YCNavigationController ()

@end

@implementation YCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏字体颜色
    //    Keys for Text Attributes Dictionaries
    //    NSString *const UITextAttributeFont;                       value: UIFont
    //    NSString *const UITextAttributeTextColor;                 value: UIColor
    //    NSString *const UITextAttributeTextShadowColor;       value: UIColor
    //    NSString *const UITextAttributeTextShadowOffset;      value: NSValue wrapping a UIOffset struct.
    [[UINavigationBar appearance] setTitleTextAttributes:
                 [NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName,
                                                            [UIFont systemFontOfSize:15],NSFontAttributeName,
                                                             nil]
     ];

//    //设置Item按钮颜色
//    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
//    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    8、UINavigationController的viewControllers属性
//    
//    　　通过该属性我们可以实现一次性替换整个navigationController的层次, 这个过程如果通过setViewControllers:animated:来设置，并指定动画为YES的画，动画将会从当前的navigationController所显示的vc跳转到所设置的目标viewController的最顶层的那个VC，而中间其他的VC将会被直接从VC层级中移除和添加进来（没有动画）。
    
    
    
    
//    UIImage *img = [UIImage imageNamed:@"cat_me@3x"];
//    img =  [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    //    [self.tabBarItem setSelectedImage:img];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:self action:nil];
//    self.navigationItem.rightBarButtonItem = leftItem;
//    
//    
//    // test ToolBar
//    UIBarButtonItem *one = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
//    UIBarButtonItem *two = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:nil action:nil];
//    UIBarButtonItem *three = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:nil action:nil];
//    UIBarButtonItem *four = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
//    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    [self setToolbarItems:[NSArray arrayWithObjects:flexItem, one, flexItem, two, flexItem, three, flexItem, four, flexItem, nil]];
//    self.navigationController.toolbarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
