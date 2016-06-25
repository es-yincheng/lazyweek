//
//  HomeViewController.m
//  lazyweek
//
//  Created by 尹成 on 16/6/24.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "HomeModel.h"
#import "Home_EVENT_Model.h"
#import "Home_LEO_Model.h"
#import "MJRefresh.h"
#import "BaseAPI.h"
#import "MBProgressHUD+MJ.h"
#import "Home_EVENT_Cell.h"
#import "YCRefreshHeader.h"
#import "HomeHeaderView.h"
#import <POP/POP.h>

#define MenuViewOriginY (- (CGRectGetHeight([UIScreen mainScreen].bounds) - 88))
#define FrontViewOriginY (CGRectGetHeight([UIScreen mainScreen].bounds) - 88)

NSString* const identifierString = @"HomeTableViewCell";

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger pageIndex;
}

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) UIView *frontView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) HomeHeaderView *headerView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backView];
    
//    [self.view addSubview:self.headerView];
//    [self.view addSubview:self.tableView];
//    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.searchView];
    
    [self.view addSubview:self.backView];
    
    [self.view addSubview:self.frontView];
    
    pageIndex = 0;
    [self getHomeItemsAgain];
}

- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - custom
- (void)showMenuView{
    [self hiddenHomeView];
    
//    POPSpringAnimation *menuSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
//    menuSpring.toValue = @(0);
//    menuSpring.beginTime = CACurrentMediaTime();
//    [self.menuView pop_addAnimation:menuSpring forKey:@"menuShow"];
}

- (void)hiddenMenuView{
    POPSpringAnimation *menuSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    menuSpring.toValue = @(MenuViewOriginY);
    menuSpring.beginTime = CACurrentMediaTime();
    [self.tableView pop_addAnimation:menuSpring forKey:@"menuHidden"];
}

- (void)showSearchView{
    [self hiddenHomeView];
    
    POPSpringAnimation *menuSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    menuSpring.toValue = @(0);
    menuSpring.beginTime = CACurrentMediaTime();
    [self.menuView pop_addAnimation:menuSpring forKey:@"searchShow"];
}

- (void)hiddenSearchView{
    POPSpringAnimation *menuSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    menuSpring.toValue = @(MenuViewOriginY);
    menuSpring.beginTime = CACurrentMediaTime();
    [self.tableView pop_addAnimation:menuSpring forKey:@"searchHidden"];
}

- (void)hiddenHomeView{
//    self.frontView.hidden = NO;
    
    
    POPSpringAnimation *homeSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        homeSpring.toValue = @(self.view.bounds.size.height - 88);
        homeSpring.beginTime = CACurrentMediaTime();
        [self.backView.layer pop_addAnimation:homeSpring forKey:@"homeHidden"];
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 0.8)];
    anim.springBounciness = 4.0;
    anim.beginTime = CACurrentMediaTime();
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            NSLog(@"Animation finished!");
        }
    };
    [self.backView.layer pop_addAnimation:anim forKey:@"backViewHidden"];
    
    
    
    
    
//    POPSpringAnimation *homeSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
//    homeSpring.toValue = @(FrontViewOriginY);
//    homeSpring.beginTime = CACurrentMediaTime();
//    [self.navigationView pop_addAnimation:homeSpring forKey:@"homeHidden"];
//    
//    self.tableView.frame = CGRectMake(0, FrontViewOriginY, self.tableView.frame.size.width, self.tableView.frame.size.height);
}

- (void)showHomeView{
    self.frontView.hidden = YES;
    [self hiddenMenuView];
    [self hiddenSearchView];
    
    self.navigationView.backgroundColor = [UIColor whiteColor];
    
    POPSpringAnimation *homeSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    homeSpring.toValue = @(0);
    homeSpring.beginTime = CACurrentMediaTime();
    [self.navigationView pop_addAnimation:homeSpring forKey:@"homShow"];
    
}

- (void)getHomeItemsAgain{
    [[BaseAPI sharedAPI].homeService getHomeItemsWithPageIndex:[NSNumber numberWithInteger:pageIndex]
                                                       success:^(NSDictionary *responseObject) {
                                                           NSMutableArray *items = [HomeModel ycs_objectWithKeyValues:responseObject];
                                                           if (pageIndex == 1) {
                                                               self.dataSource = items;
                                                           } else {
                                                               [self.dataSource addObjectsFromArray:items];
                                                           }
                                                           [self endRefresh];
                                                           pageIndex ++;
                                                           [self.tableView reloadData];
                                                           if (items.count == 0) {
                                                               [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                                           }
                                                       } failure:^(NSError *error) {
                                                           NSLog(@"error:%@",error);
                                                           [MBProgressHUD showMessageAuto:@"网络连接失败，请您稍后重试"];
                                                           [self endRefresh];
                                                       }];
}

- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}


#pragma mark - delegate/dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([NSStringFromClass([[self.dataSource objectAtIndex:indexPath.row] class]) isEqualToString:@"Home_EVENT_Model"]) {
        Home_EVENT_Cell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Home_EVENT_Cell"];
        [cell configWithModel:[self.dataSource objectAtIndex:indexPath.row]];
        return cell;
    }
    else if ([NSStringFromClass([[self.dataSource objectAtIndex:indexPath.row] class]) isEqualToString:@"Home_LEO_Model"]) {
        HomeTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifierString];
        [cell configWithModel:[self.dataSource objectAtIndex:indexPath.row]];
        return cell;
    }
    else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.headerView changeTitle];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    self.headerView.frame = CGRectMake(0, ABS(scrollView.contentOffset.y), self.view.bounds.size.width, ABS(scrollView.contentOffset.y));
//    NSLog(@"scrollView:%f",scrollView.contentOffset.y);
}

#pragma mark - lazy
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:
                      CGRectMake(0, 64, self.navigationView.bounds.size.width, self.view.bounds.size.height-64)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 300;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
            [self getHomeItemsAgain];
        }];
        
        [_tableView registerNib:[UINib nibWithNibName:identifierString bundle:nil] forCellReuseIdentifier:identifierString];
        [_tableView registerNib:[UINib nibWithNibName:@"Home_EVENT_Cell" bundle:nil] forCellReuseIdentifier:@"Home_EVENT_Cell"];
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (HomeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
        _headerView.backgroundColor = [UIColor redColor];
    }
    return _headerView;
}

- (UIView *)navigationView{
    if (!_navigationView) {
        _navigationView = [[UIView alloc] init];
        _navigationView.backgroundColor = [UIColor whiteColor];
        _navigationView.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 64);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, _navigationView.bounds.size.width, 44)];
        view.backgroundColor = [UIColor whiteColor];
        [_navigationView addSubview:view];
        
        
        UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _navigationView.bounds.size.width, view.bounds.size.height)];
        titleLb.textAlignment = NSTextAlignmentCenter;
        titleLb.text = @"懒人周末";
        titleLb.font = [UIFont systemFontOfSize:15];
        titleLb.tintColor = [UIColor grayColor];
        [view  addSubview:titleLb];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, view.bounds.size.height-0.5, view.bounds.size.width, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:line];
        
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 2 + 5, 30, 30)];
        [leftButton setImage:[UIImage imageNamed:@"cat_me@3x"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(showMenuView) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:leftButton];
        
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(view.bounds.size.width - 10 - 30, 7 + 5, 30, 30)];
        [rightButton setImage:[UIImage imageNamed:@"ic_nav_search@3x"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(showSearchView) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:rightButton];
        
    }
    return _navigationView;
}

- (UIView *)menuView{
    if (!_menuView) {
        _menuView = [[UIView alloc] initWithFrame:CGRectMake(0, MenuViewOriginY, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 88)];
        _menuView.backgroundColor = [UIColor greenColor];
    }
    return _menuView;
}

- (UIView *)searchView{
    if (!_searchView) {
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, MenuViewOriginY, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) -88)];
        _searchView.backgroundColor = [UIColor darkGrayColor];
    }
    return _searchView;
}

- (UIView *)frontView{
    if (!_frontView) {
        _frontView = [[UIView alloc] initWithFrame:CGRectMake(0, FrontViewOriginY, CGRectGetWidth([UIScreen mainScreen].bounds), 88)];
        _frontView.hidden = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHomeView)];
        [_frontView addGestureRecognizer:tapGesture];
    }
    return _frontView;
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:self.view.frame];
        _backView.backgroundColor = [UIColor whiteColor];
        [_backView addSubview:self.navigationView];
        [_backView addSubview:self.tableView];
    }
    return _backView;
}

@end
