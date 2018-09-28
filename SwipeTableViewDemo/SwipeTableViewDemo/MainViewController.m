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

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

@interface MainViewController ()<SwipeTableViewDataSource, SwipeTableViewDelegate>

/** <#注释#> */
@property (nonatomic, strong) SwipeTableView *swipeTableView;

/** <#注释#> */
@property (nonatomic, strong) ChildViewController *childVC;

@property (nonatomic, strong) STHeaderView * tableViewHeader;

@property (nonatomic, strong) UIImageView * headerImageView;

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
    
    _swipeTableView.swipeHeaderView = self.tableViewHeader;
      _swipeTableView.swipeHeaderBarScrollDisabled = NO;
    _swipeTableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_swipeTableView];
    
}

- (void)addchildVC {
    self.childVC = [[ChildViewController alloc] init];
    [self addChildViewController:_childVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - accessory method

#pragma mark - SwipeTableView M

- (NSInteger)numberOfItemsInSwipeTableView:(SwipeTableView *)swipeView {
    return 1;
}

- (UIScrollView *)swipeTableView:(SwipeTableView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIScrollView *)view {    
    view = self.childVC.tableView;
    return view;
}

- (UIView *)tableViewHeader {
    if (nil == _tableViewHeader) {
        UIImage * headerImage = [UIImage imageNamed:@"onepiece_kiudai"];
        // swipe header
        self.tableViewHeader = [[STHeaderView alloc]init];
        _tableViewHeader.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth * (headerImage.size.height/headerImage.size.width));
        _tableViewHeader.backgroundColor = [UIColor whiteColor];
        _tableViewHeader.layer.masksToBounds = YES;
        
        // image view
        self.headerImageView = [[UIImageView alloc]initWithImage:headerImage];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headerImageView.userInteractionEnabled = YES;
        _headerImageView.frame = _tableViewHeader.bounds;
        _headerImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        // title label
//        UILabel * title = [[UILabel alloc]init];
//        title.textColor = RGBColor(255, 255, 255);
//        title.font = [UIFont boldSystemFontOfSize:17];
//        title.text = @"Tap To Full Screen";
//        title.textAlignment = NSTextAlignmentCenter;
//        title.st_size = CGSizeMake(200, 30);
//        title.st_centerX = _headerImageView.st_centerX;
//        title.st_bottom = _headerImageView.st_bottom - 20;
//        
        // tap gesture
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeader:)];
        
        [_tableViewHeader addSubview:_headerImageView];
//        [_tableViewHeader addSubview:title];
//        [_headerImageView addGestureRecognizer:tap];
//        [self shimmerHeaderTitle:title];
    }
    return _tableViewHeader;
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
