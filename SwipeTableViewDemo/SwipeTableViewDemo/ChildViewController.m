//
//  ChildViewController.m
//  SwipeTableViewDemo
//
//  Created by hanbo on 2018/9/28.
//  Copyright © 2018年 hanbo. All rights reserved.
//

#import "ChildViewController.h"

@interface ChildViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ChildViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.backgroundColor = [UIColor yellowColor];
//    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"onepiece_kiudai"]];
//    backImageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.tableView.backgroundView = backImageView; // 背景视图
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
//     self.tableView.layer.cornerRadius = 20;
//    self.tableView.layer.masksToBounds = YES;
    
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 200)];
//    headerView.layer.cornerRadius = 30;
//    headerView.backgroundColor = [UIColor whiteColor];
//    
//    self.tableView.tableHeaderView = headerView;
//   
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedRowHeight = 0;
    }
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    
    [self.view addSubview:self.tableView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"标题%ld", indexPath.row];
    return cell;
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
