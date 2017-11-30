//
//  MessageHeaderView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/30.
//  Copyright © 2017年 galaxy. All rights reserved.
//
#define kItemWidth ((self.width + 1)/self.items.count)

#import "MessageHeaderView.h"
@interface MessageHeaderView ()
@property (nonatomic, strong) NSArray * items;

@property (strong, nonatomic) UIView *bottomView;
@end

@implementation MessageHeaderView

- (instancetype)initWithItems:(NSArray *)items frame:(CGRect)frame{
    self = [self initWithFrame:frame];
    if (self) {
        if (items.count > 0) {
            self.items = items;
            _selectedSegmentIndex = 0;
            [self initView];
        }
    }
    return self;
}

- (void)initView
{
    self.backgroundColor = kBackGroundGrayColor;
    for (int i = 0; i < _items.count; i ++) {
        UIButton * itemBt = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBt.tag = 100 + i;
        [itemBt setTitle:_items[i] forState:UIControlStateNormal];
        itemBt.titleLabel.font = kFontSize15;
        
        [itemBt setTitleColor:kColor6B6B6B forState:UIControlStateNormal];
        [itemBt setTitleColor:kNavBarColor forState:UIControlStateSelected];
        
        itemBt.frame = CGRectMake(kItemWidth * i, 0, kItemWidth, self.height);
        if (i == _selectedSegmentIndex) {
            self.selectedSegmentIndex = _selectedSegmentIndex;
        }else {
            //            itemBt.backgroundColor = [UIColor clearColor];
        }
        [itemBt addTarget:self action:@selector(didSelectedSegment:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemBt];
        
        
        if (i != _items.count - 1) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(itemBt.right - 1, (self.height - 15)/2.0, 1, 15)];
            line.backgroundColor = kColorC1C1C1;
            [self addSubview:line];
        }
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 2, kScreenWidth, 2)];
    line.backgroundColor = kColorC1C1C1;
    [self addSubview:line];
    
    self.bottomView.frame = CGRectMake(self.selectedSegmentIndex * kItemWidth, self.height - 2 , kItemWidth, 2);
    [self addSubview:self.bottomView];
    
}

- (void)didSelectedSegment:(UIButton *)button
{
    NSInteger index = button.tag - 100;
    self.selectedSegmentIndex = index;
    
    if (self.IndexChangeBlock) {
        self.IndexChangeBlock(index);
    }
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex
{
    UIButton *lastSelectButton = [self getButtonWithIndex:_selectedSegmentIndex];
    lastSelectButton.selected = NO;
    
    UIButton *willSelectButton = [self getButtonWithIndex:selectedSegmentIndex];
    willSelectButton.selected = YES;
    
    _selectedSegmentIndex = selectedSegmentIndex;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomView.left = self.selectedSegmentIndex * kItemWidth;
    }];
    
}

- (UIButton *)getButtonWithIndex:(NSInteger)index
{
    return (UIButton *)[self viewWithTag:index + 100];
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = kNavBarColor;
    }
    return _bottomView;
}


+ (CGFloat)defaultHeight
{
    return 45;
}



@end
