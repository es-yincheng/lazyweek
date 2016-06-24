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

NSString* const identifierString = @"HomeTableViewCell";

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger pageIndex;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) HomeHeaderView *headerView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    
    pageIndex = 0;
    [self getHomeItemsAgain];
}

- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - custom
- (void)getHomeItemsFirst{
//    pageIndex = 0;
//    [self.dataSource removeAllObjects];
//    [self getHomeItemsAgain];
    [self endRefresh];
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
    self.headerView.frame = CGRectMake(0, ABS(scrollView.contentOffset.y), self.view.bounds.size.width, ABS(scrollView.contentOffset.y));
    NSLog(@"scrollView:%f",scrollView.contentOffset.y);
}

#pragma mark - lazy
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 300;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.mj_header = [YCRefreshHeader headerWithRefreshingBlock:^{
//            [self getHomeItemsFirst];
//        }];

//        self.tableView.mj_header = [YCRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(getHomeItemsFirst)];
        
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

@end
