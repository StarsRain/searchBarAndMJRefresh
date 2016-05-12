//
//  ViewController.m
//  TestMJRefresh
//
//  Created by myApple on 16/5/12.
//  Copyright © 2016年 myApple. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UISearchBar * testSearchBar;
    UISearchDisplayController * testDisplayController;
    UITableView * testTableView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self prepareSearchDisplayView];
    [self prepareSearchDisplayViewSelf];
    //不知道是不是跟 UISearchDisplayController 被废弃有关
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark ---------- 全局变量的displaycontroller（下拉不显示refresh字体）
-(void)prepareSearchDisplayView
{
    testSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    testDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:testSearchBar contentsController:self];
    [self prepareTableView];//不正常
//    [self prepareTableViewByOther];//正常
   
}

#pragma mark -----------局部变量displaycontroller（下拉显示refresh字体）
-(void)prepareSearchDisplayViewSelf
{
    testSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
   UISearchDisplayController * DisplayController = [[UISearchDisplayController alloc]initWithSearchBar:testSearchBar contentsController:self];
//    [self prepareTableView];
    [self prepareTableViewByOther];
}

#pragma mark ---------加载searchbar 先再加载mjrefresh
-(void)prepareTableView
{
    testTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    testTableView.delegate = self;
    testTableView.dataSource = self;
    [self.view addSubview:testTableView];
    testTableView.tableFooterView = [UIView new];
    testTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    testTableView.tableHeaderView = testSearchBar;
    [testTableView.mj_header beginRefreshing];
    testTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [testTableView.mj_header endRefreshing];
        NSLog(@"refresh");
    }];
    
}

#pragma mark -------------先加载mjrefresh 再加载searchbar
-(void)prepareTableViewByOther
{
    testTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    testTableView.delegate = self;
    testTableView.dataSource = self;
    [self.view addSubview:testTableView];
    testTableView.tableFooterView = [UIView new];
    testTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [testTableView.mj_header beginRefreshing];
    testTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [testTableView.mj_header endRefreshing];
        NSLog(@"refresh");
    }];
    testTableView.tableHeaderView = testSearchBar;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identityId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identityId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identityId];
    }
    cell.textLabel.text = @"This is text";
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
