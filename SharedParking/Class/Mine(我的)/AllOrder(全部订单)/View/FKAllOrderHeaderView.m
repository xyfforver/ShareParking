//
//  FKAllOrderHeaderView.m
//  SharedParking
//
//  Created by 尉超 on 2018/1/16.
//  Copyright © 2018年 galaxy. All rights reserved.
//
#define kItemWidth ((self.width + 1)/self.items.count)

#import "FKAllOrderHeaderView.h"

@interface FKAllOrderHeaderView ()
@property (nonatomic, strong) NSArray * items;

@property (strong, nonatomic) UIView *bottomView;
@end

@implementation FKAllOrderHeaderView


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
    self.backgroundColor = kColorWhite;
    for (int i = 0; i < _items.count; i ++) {
        UIButton * itemBt = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBt.tag = 100 + i;
        [itemBt setTitle:_items[i] forState:UIControlStateNormal];
        itemBt.titleLabel.font = kFontSize14;
        
        [itemBt setTitleColor:kColor2b2b2b forState:UIControlStateNormal];
        [itemBt setTitleColor:kNavBarColor forState:UIControlStateSelected];
        
        itemBt.frame = CGRectMake(kItemWidth * i, 0, kItemWidth, self.height);
        if (i == _selectedSegmentIndex) {
            self.selectedSegmentIndex = _selectedSegmentIndex;
        }else {
            //            itemBt.backgroundColor = [UIColor clearColor];
        }
        [itemBt addTarget:self action:@selector(didSelectedSegment:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemBt];
        
        
        if (i != 3) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(itemBt.right - 1, (self.height - 15)/2.0, 1, 15)];
            line.backgroundColor = kColora3a3a3;
            [self addSubview:line];
        }
    }
    
    self.bottomView.frame = CGRectMake((kItemWidth - 60)/2 + self.selectedSegmentIndex * kItemWidth, self.height - 10 , 60, 2);
    [self addSubview:self.bottomView];
    
}

- (void)didSelectedSegment:(UIButton *)button
{
    NSInteger index = button.tag - 100;
    //    self.selectedSegmentIndex = index;
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
        self.bottomView.left = (kItemWidth - 60)/2 + self.selectedSegmentIndex * kItemWidth;
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



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
