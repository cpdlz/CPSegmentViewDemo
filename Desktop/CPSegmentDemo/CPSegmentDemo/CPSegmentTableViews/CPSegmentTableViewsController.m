//
//  CPSegmentTableViewsController.m
//  CPSegmentDemo
//
//  Created by chenp on 16/9/27.
//  Copyright © 2016年 chenp. All rights reserved.
//

#import "CPSegmentTableViewsController.h"
#import "CPSegmentView.h"
#import "MJRefresh.h"
/** 随机色 */
#define CPCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define CPRandomColor_RGB CPCOLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define MaxNums  9 // 和TableView个数一致

@interface CPSegmentTableViewsController ()<CPSegmentViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BOOL refreshSetup[MaxNums];
}
@property (nonatomic, strong) NSMutableArray *tableViewArr;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger tabBarLastIndex;
@end

@implementation CPSegmentTableViewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TableViews";
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableViewArr = [[NSMutableArray alloc] init];
    _dataSource = [[NSMutableArray alloc] init];
    [self structuralData];
    
    NSArray *titleArr = @[@"视图1",@"视图2",@"视图3",@"视图4",@"视图5",@"视图6",@"视图7",@"视图8",@"视图9"];
    
    for (int i = 0; i < titleArr.count; i++) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor whiteColor];
        [_tableViewArr addObject:tableView];
        
    }
    
    CPSegmentView *segmentView = [[CPSegmentView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) andTitleArray:titleArr andShowTableViewsArray:_tableViewArr];
    segmentView.delegate = self;
    [self.view addSubview:segmentView];
    
    // 给第一个tableView添加refresh
    [self setupRefreshWithIndex:0];
    _tabBarLastIndex = 0;
}


- (void)structuralData {

    NSDictionary *dict0 = @{@"0":@"平生不相思0", @"1" : @"level0"};
    NSDictionary *dict1 = @{@"0":@"平生不相思1", @"1" : @"level1"};
    NSDictionary *dict2 = @{@"0":@"平生不相思2", @"1" : @"level2"};
    NSDictionary *dict3 = @{@"0":@"平生不相思3", @"1" : @"level3"};
    NSDictionary *dict4 = @{@"0":@"平生不相思4", @"1" : @"level4"};
    NSDictionary *dict5 = @{@"0":@"平生不相思5", @"1" : @"level5"};
    NSDictionary *dict6 = @{@"0":@"平生不相思6", @"1" : @"level6"};
    NSDictionary *dict7 = @{@"0":@"平生不相思7", @"1" : @"level7"};
    NSDictionary *dict8 = @{@"0":@"平生不相思8", @"1" : @"level8"};
    NSDictionary *dict9 = @{@"0":@"平生不相思9", @"1" : @"level9"};
    
    if (_dataSource.count != 0) [_dataSource removeAllObjects];
    
    [_dataSource addObject:dict0];
    [_dataSource addObject:dict1];
    [_dataSource addObject:dict2];
    [_dataSource addObject:dict3];
    [_dataSource addObject:dict4];
    [_dataSource addObject:dict5];
    [_dataSource addObject:dict6];
    [_dataSource addObject:dict7];
    [_dataSource addObject:dict8];
    [_dataSource addObject:dict9];
}

- (void)setupRefreshWithIndex:(NSInteger)index {
    
    UITableView *tableView = self.tableViewArr[index];
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    //tableView.mj_header.automaticallyChangeAlpha = YES;
    
    if (index == 0) {
        [tableView.mj_header beginRefreshing];
    }
    
    tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    refreshSetup[index] = YES;
}

- (void)loadNew {
    
    // 刷新当前TableView数据
    UITableView *tableView = self.tableViewArr[_tabBarLastIndex];
    [tableView.mj_header endRefreshing];
    [tableView reloadData];
    
}


- (void)loadMore {
    
    // 加载更多数据（下一页）
    UITableView *tableView = self.tableViewArr[_tabBarLastIndex];
    [tableView.mj_footer endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger number=0;
    if (_tabBarLastIndex == 0) {
        number = 1;
    } else if (_tabBarLastIndex == 1) {
        number = 2;
    } else if (_tabBarLastIndex == 2) {
        number = 3;
    } else if (_tabBarLastIndex == 3) {
        number = 4;
    } else if (_tabBarLastIndex == 4) {
        number = 5;
    } else if (_tabBarLastIndex == 5) {
        number = 6;
    } else if (_tabBarLastIndex == 6) {
        number = 7;
    } else if (_tabBarLastIndex == 7) {
        number = 8;
    } else if (_tabBarLastIndex == 8) {
        number = 9;
    }
    return number;
    //return _tabBarLastIndex + 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"cell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.text = _dataSource[indexPath.row][@"0"];
        cell.detailTextLabel.text = _dataSource[indexPath.row][@"1"];
        /* 忽略点击效果 */
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

#pragma mark - CPSegmentViewDelegate
- (void)didSelectIndex:(NSInteger)index {

    NSLog(@"_tabBarLastIndex:%ld",index);
    _tabBarLastIndex = index;
    
    if (refreshSetup[_tabBarLastIndex] == NO) {
        [self setupRefreshWithIndex:_tabBarLastIndex];
    }
    UITableView *tableView = self.tableViewArr[_tabBarLastIndex];
    [tableView.mj_header beginRefreshing];
    [tableView reloadData];
    [tableView.mj_header endRefreshing];
}


@end
