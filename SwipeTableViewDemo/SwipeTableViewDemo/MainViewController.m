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
#import "CustomSegmentControl.h"
#import "UIView+STFrame.h"
#import "secondViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UserSegmentControl.h"
#import "JXCategoryView.h"
#import "WRNavigationBar.h"

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

#define RGBColorAlpha(r,g,b,f)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:f]
#define RGBColor(r,g,b)          RGBColorAlpha(r,g,b,1)

@interface MainViewController ()<SwipeTableViewDataSource, SwipeTableViewDelegate>

/** <#注释#> */
@property (nonatomic, strong) SwipeTableView *swipeTableView;

/** <#注释#> */
@property (nonatomic, strong) ChildViewController *childVC;

/** <#注释#> */
@property (nonatomic, strong) secondViewController *secondVC;

@property (nonatomic, strong) STHeaderView * tableViewHeader;

@property (nonatomic, strong) UIImageView * headerImageView;

//@property (nonatomic, strong) CustomSegmentControl * segmentBar;

//@property (nonatomic, strong) UserSegmentControl * segmentBar;

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"swipeTbaleView";
    
    
    // 设置导航栏颜色
    [self wr_setNavBarBarTintColor:[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0]];
    
    // 设置初始导航栏透明度
    [self wr_setNavBarBackgroundAlpha:0];
    
    // 设置导航栏按钮和标题颜色
    [self wr_setNavBarTintColor:[UIColor whiteColor]];
    
    [self addchildVC]; // 添加子VC
    
    self.swipeTableView = [[SwipeTableView alloc]initWithFrame:self.view.bounds];
     _swipeTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
      _swipeTableView.shouldAdjustContentSize = YES;
    _swipeTableView.delegate = self;
    _swipeTableView.dataSource = self;
    
    
    /** 设置图片包含bar */
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, kScreenWidth, 50);
    imageView.image = [UIImage imageNamed:@"onepiece_kiudai"];

    imageView.contentMode = UIViewContentModeBottom;

    [imageView addSubview:self.myCategoryView];
   
    _swipeTableView.swipeHeaderView = self.tableViewHeader;
     _swipeTableView.swipeHeaderBar = imageView;
    
    _swipeTableView.swipeHeaderBarScrollDisabled = NO;
     _swipeTableView.alwaysBounceHorizontal = NO;
//     _swipeTableView.swipeHeaderTopInset = 0;
     _swipeTableView.swipeHeaderTopInset = 64;
    
//    _swipeTableView.swipeHeaderBarScrollDisabled = YES;
    [self.view addSubview:_swipeTableView];
    
    
    // 监听childView的偏移量
     @weakify(self);
    [RACObserve(self.childVC.tableView, contentOffset) subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        UIImage * headerImage = [UIImage imageNamed:@"onepiece_kiudai"];
//         CGFloat offsetY =  self.childVC.tableView.contentOffset.y + kScreenWidth * (headerImage.size.height/headerImage.size.width) + self.segmentBar.st_height + 64;
        CGFloat newOffsetY =  self.childVC.tableView.contentOffset.y + kScreenWidth * (headerImage.size.height/headerImage.size.width) + self.myCategoryView.st_height + 64;
    
        if (newOffsetY > 64) {
            CGFloat alpha = (newOffsetY - 64) / 64;
            [self wr_setNavBarBackgroundAlpha:alpha];
            [self wr_setNavBarTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
            [self wr_setNavBarTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
            [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
        }
        else
        {
            [self wr_setNavBarBackgroundAlpha:0];
            [self wr_setNavBarTintColor:[UIColor whiteColor]];
            [self wr_setNavBarTitleColor:[UIColor whiteColor]];
            [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
        }
        
        if (newOffsetY < 0) {

            self.headerImageView.frame = CGRectMake(0, newOffsetY, kScreenWidth, -newOffsetY + kScreenWidth * (headerImage.size.height/headerImage.size.width)+50);
            
//            self.headerImageView.frame = CGRectMake(0, newOffsetY, kScreenWidth, -newOffsetY + kScreenWidth * (headerImage.size.height/headerImage.size.width));
        }
    }];
    
    
    [RACObserve(self.secondVC.tableView, contentOffset) subscribeNext:^(id  _Nullable x) {
        UIImage * headerImage = [UIImage imageNamed:@"onepiece_kiudai"];
        CGFloat newOffsetY =  self.secondVC.tableView.contentOffset.y + kScreenWidth * (headerImage.size.height/headerImage.size.width) + self.myCategoryView.st_height + 64;
        @strongify(self);
        if (newOffsetY > 64) {
            CGFloat alpha = (newOffsetY - 64) / 64;
            [self wr_setNavBarBackgroundAlpha:alpha];
            [self wr_setNavBarTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
            [self wr_setNavBarTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
            [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
        }
        else
        {
            [self wr_setNavBarBackgroundAlpha:0];
            [self wr_setNavBarTintColor:[UIColor whiteColor]];
            [self wr_setNavBarTitleColor:[UIColor whiteColor]];
            [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
        }
        
        if (newOffsetY < 0) {
//              self.headerImageView.frame = CGRectMake(0, newOffsetY, kScreenWidth, -newOffsetY + kScreenWidth * (headerImage.size.height/headerImage.size.width));
            self.headerImageView.frame = CGRectMake(0, newOffsetY, kScreenWidth, -newOffsetY + kScreenWidth * (headerImage.size.height/headerImage.size.width)+50);
        }
    }];
}

- (void)addchildVC {
    self.childVC = [[ChildViewController alloc] init];
    [self addChildViewController:self.childVC];
    
    self.secondVC = [[secondViewController alloc] init];
    [self addChildViewController:self.secondVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define SCROLL_DOWN_LIMIT 100
#pragma mark - accessory method


#pragma mark - SwipeTableView M

- (NSInteger)numberOfItemsInSwipeTableView:(SwipeTableView *)swipeView {
    return 2;
}

- (UIScrollView *)swipeTableView:(SwipeTableView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIScrollView *)view {
   
    if (index == 0) {
        view = self.childVC.tableView;
        return view;
    } else if (index == 1) {
        view = self.secondVC.tableView;
        return view;
    }
    return nil;
}


/** 开始滚动 */
- (void)swipeTableViewDidScroll:(SwipeTableView *)swipeView {
//    NSLog(@"%@", swipeView.contentView.contentSize)
 
}

// swipetableView index变化，改变seg的index
- (void)swipeTableViewCurrentItemIndexDidChange:(SwipeTableView *)swipeView {
//    _segmentBar.selectedSegmentIndex = swipeView.currentItemIndex;
//    _myCategoryView.selectedIndex = swipeView.currentItemIndex;
}

- (STHeaderView *)tableViewHeader {
    if (nil == _tableViewHeader) {
        UIImage * headerImage = [UIImage imageNamed:@"onepiece_kiudai"];
        // swipe header
        self.tableViewHeader = [[STHeaderView alloc]init];
        _tableViewHeader.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth * (headerImage.size.height/headerImage.size.width));
        _tableViewHeader.backgroundColor = [UIColor whiteColor];
//        _tableViewHeader.layer.masksToBounds = YES;
        
        // image view
        self.headerImageView = [[UIImageView alloc]initWithImage:headerImage];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headerImageView.userInteractionEnabled = YES;
//        _headerImageView.frame = _tableViewHeader.bounds;
//        _headerImageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth * (headerImage.size.height/headerImage.size.width) + 50);
        
           _headerImageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth * (headerImage.size.height/headerImage.size.width));
//        _headerImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        // title label
        UILabel * title = [[UILabel alloc]init];
        title.textColor = RGBColor(255, 255, 255);
        title.font = [UIFont boldSystemFontOfSize:17];
        title.text = @"Tap To Full Screen";
        title.textAlignment = NSTextAlignmentCenter;
        title.st_size = CGSizeMake(200, 30);
        title.st_centerX = _headerImageView.st_centerX;
        title.st_bottom = _headerImageView.st_bottom - 20;
        
        // tap gesture
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeader:)];
        
        [_tableViewHeader addSubview:_headerImageView];
        [_tableViewHeader addSubview:title];
//        [_headerImageView addGestureRecognizer:tap];
        [self shimmerHeaderTitle:title];
    }
    return _tableViewHeader;
}

/** label一闪一闪显示 */
- (void)shimmerHeaderTitle:(UILabel *)title {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.75f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        title.transform = CGAffineTransformMakeScale(0.98, 0.98);
        title.alpha = 0.3;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.75f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            title.alpha = 1.0;
            title.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [weakSelf shimmerHeaderTitle:title];
        }];
    }];
}


//- (UserSegmentControl * )segmentBar {
//    if (nil == _segmentBar) {
//        _segmentBar = [[UserSegmentControl alloc]initWithItems:@[@"音乐",@"动态"]];
//        _segmentBar.st_size = CGSizeMake(kScreenWidth, 68);
//        _segmentBar.selectedSegmentIndex = _swipeTableView.currentItemIndex;
//        [_segmentBar addTarget:self action:@selector(changeSwipeViewIndex:) forControlEvents:UIControlEventValueChanged];
//    }
//    return _segmentBar;
//}

//- (CustomSegmentControl * )segmentBar {
//    if (nil == _segmentBar) {
//        self.segmentBar = [[CustomSegmentControl alloc]initWithItems:@[@"Item0",@"Item1"]];
//        _segmentBar.st_size = CGSizeMake(kScreenWidth, 40);
//        _segmentBar.font = [UIFont systemFontOfSize:15];
//        _segmentBar.textColor = RGBColor(100, 100, 100);
//        _segmentBar.selectedTextColor = RGBColor(0, 0, 0);
//        _segmentBar.backgroundColor = RGBColor(249, 251, 198);
//        _segmentBar.selectionIndicatorColor = RGBColor(249, 104, 92);
//        _segmentBar.selectedSegmentIndex = _swipeTableView.currentItemIndex;
//        [_segmentBar addTarget:self action:@selector(changeSwipeViewIndex:) forControlEvents:UIControlEventValueChanged];
//    }
//    return _segmentBar;
//}

- (void)changeSwipeViewIndex:(UISegmentedControl *)seg {
    [_swipeTableView scrollToItemAtIndex:seg.selectedSegmentIndex animated:NO];
    // request data at current index
    [self getDataAtIndex:seg.selectedSegmentIndex];
}

- (JXCategoryTitleView *)myCategoryView {
    if (!_myCategoryView) {
        
        self.myCategoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
         self.myCategoryView.titles = @[@"音乐",@"动态"];
        self.myCategoryView.backgroundColor = [UIColor clearColor];
//        self.myCategoryView.backgroundColor = [UIColor yellowColor];
        self.myCategoryView.titleColorGradientEnabled = YES;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorLineWidth = 50;
        self.myCategoryView.indicators = @[lineView];
        lineView.lineStyle = JXCategoryIndicatorLineStyle_IQIYI;
        // 关联滚动视图
        self.myCategoryView.contentScrollView = self.swipeTableView.contentView;
    }
    return _myCategoryView;
}

#pragma mark - Data Reuqest

// 请求数据（根据视图滚动到相应的index后再请求数据）
- (void)getDataAtIndex:(NSInteger)index {
//    NSInteger numberOfRows = 0;
    // 请求数据后刷新相应的item
}
@end
