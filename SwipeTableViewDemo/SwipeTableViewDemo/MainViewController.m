//
//  MainViewController.m
//  SwipeTableViewDemo
//
//  Created by hanbo on 2018/9/28.
//  Copyright © 2018年 hanbo. All rights reserved.
//

#import "MainViewController.h"
#import <SwipeTableView/SwipeTableView.h>
#import <SwipeTableView/STHeaderView.h>
#import "ChildViewController.h"

@interface MainViewController ()<SwipeTableViewDataSource, SwipeTableViewDelegate>

/** <#注释#> */
@property (nonatomic, strong) SwipeTableView *swipeTableView;

/** <#注释#> */
@property (nonatomic, strong) ChildViewController *childVC;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"swipeTbaleView";
    
    
    [self addchildVC]; // 添加子VC
    
    self.swipeTableView = [[SwipeTableView alloc]initWithFrame:self.view.bounds];
     _swipeTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _swipeTableView.delegate = self;
    _swipeTableView.dataSource = self;
    _swipeTableView.swipeHeaderBar = nil;
    _swipeTableView.swipeHeaderView = nil;
      _swipeTableView.swipeHeaderBarScrollDisabled = NO;
    _swipeTableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_swipeTableView];
    
}

- (void)addchildVC {
    self.childVC = [[ChildViewController alloc] init];
    [self addChildViewController:self.childVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - accessory method

#pragma mark - SwipeTableView M

- (NSInteger)numberOfItemsInSwipeTableView:(SwipeTableView *)swipeView {
    return 2;
}

- (UIScrollView *)swipeTableView:(SwipeTableView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIScrollView *)view {    
    view = self.childVC.tableView;
    return view;
}

//- (BOOL)swipeTableView:(SwipeTableView *)swipeTableView shouldPullToRefreshAtIndex:(NSInteger)index {
//    return YES;
//}

//- (CGFloat)swipeTableView:(SwipeTableView *)swipeTableView heightForRefreshHeaderAtIndex:(NSInteger)index {
//    return 64;
//}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
