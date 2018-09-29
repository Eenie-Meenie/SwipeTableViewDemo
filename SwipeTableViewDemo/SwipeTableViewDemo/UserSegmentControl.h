//
//  UserSegmentControl.h
//  MagicMusic
//
//  Created by wps on 2018/7/20.
//  Copyright © 2018年 Wps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserSegmentControl : UIControl

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, assign) NSInteger selectedSegmentIndex;
@property (nonatomic, copy) void (^IndexChangeBlock)(NSInteger index);

- (instancetype)initWithItems:(NSArray<NSString *> *)items;

@end
