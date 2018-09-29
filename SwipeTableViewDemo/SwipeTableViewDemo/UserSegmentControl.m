//
//  UserSegmentControl.m
//  MagicMusic
//
//  Created by wps on 2018/7/20.
//  Copyright © 2018年 Wps. All rights reserved.
//

#import "UserSegmentControl.h"
#import "UIView+STFrame.h"
#import "UIButton+Edge.h"
#define RGBA(R,G,B,A)    [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

@interface UserSegmentControl ()

@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) NSArray * items;

@end

@implementation UserSegmentControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithItems:(NSArray *)items {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        if (items.count > 0) {
            self.items = items;
        }
    }
    return self;
}

- (void)commonInit {
    _contentView = [UIView new];
    _contentView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_contentView];
    _font = [UIFont systemFontOfSize:16];
//    _textColor = RGBA(255, 255, 255, 0.6);
    _textColor = [UIColor blackColor];
    _selectedTextColor = [UIColor redColor];
//    _selectedTextColor = RGBA(255, 255, 255, 1);
    _items = @[@"Segment0",@"Segment1"];
    _selectedSegmentIndex = 0;
    UIView *cornerView = [[UIView alloc] initWithFrame:CGRectMake(0, 56, 375, 20)];
    cornerView.layer.cornerRadius = 8;
//    cornerView.backgroundColor = COLOR(8);
    cornerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:cornerView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *subView in _contentView.subviews) {
        [subView removeFromSuperview];
    }
    
//    _contentView.backgroundColor = _backgroundColor;
    _contentView.frame = self.bounds;
    for (int i = 0; i < _items.count; i ++) {
        UIButton * itemBt = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBt.tag = 666 + i;
        [itemBt setTitleColor:_textColor forState:UIControlStateNormal];
        [itemBt setTitleColor:_selectedTextColor forState:UIControlStateSelected];
        [itemBt setTitle:_items[i] forState:UIControlStateNormal];
        [itemBt.titleLabel setFont:_font];
        [itemBt setImage:[UIImage imageNamed:@"user_page_index"] forState:UIControlStateSelected];
        [itemBt setImage:[UIImage imageNamed:@"user_page_index_no"] forState:UIControlStateNormal];
        [itemBt setImagePositionWithType:SSImagePositionTypeBottom spacing:3];
        CGFloat itemWidth = self.st_width/_items.count;
        itemBt.st_size = CGSizeMake(itemWidth, self.st_height - 12);
        itemBt.st_x    = itemWidth * i;
        itemBt.st_y    = 0;
        if (i == _selectedSegmentIndex) {
            itemBt.selected = YES;
        }else {
//            itemBt.backgroundColor = [UIColor clearColor];
        }
        [itemBt addTarget:self action:@selector(didSelectedSegment:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:itemBt];
    }
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 10)];
    redView.backgroundColor = [UIColor redColor];
    
    
    
    [_contentView addSubview:redView];
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex {
    UIButton * oldItemBt      = [_contentView viewWithTag:666 + _selectedSegmentIndex];
//    oldItemBt.backgroundColor = [UIColor clearColor];
    oldItemBt.selected        = NO;
    
    UIButton * itemBt      = [_contentView viewWithTag:666 + selectedSegmentIndex];
    itemBt.selected        = YES;
    _selectedSegmentIndex  = selectedSegmentIndex;
}

- (void)didSelectedSegment:(UIButton *)itemBt {
    UIButton * oldItemBt      = [_contentView viewWithTag:666 + _selectedSegmentIndex];
//    oldItemBt.backgroundColor = [UIColor clearColor];
    oldItemBt.selected        = NO;
    
    _selectedSegmentIndex  = itemBt.tag - 666;
    if (self.IndexChangeBlock) {
        self.IndexChangeBlock(_selectedSegmentIndex);
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    itemBt.selected        = YES;
}

@end
