//
//  JMTitleSelectView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/27.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "JMTitleSelectView.h"
@interface JMTitleSelectView ()

@end

@implementation JMTitleSelectView

- (instancetype)initWithFrame:(CGRect)frame{
    frame = CGRectMake(0, 0, 120, 30);
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initView];
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 15;
    self.layer.borderColor = kColorC1C1C1.CGColor;
    self.layer.borderWidth = 1.0;
    _selectedSegmentIndex = 0;
    
    
    UIButton *mistakeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mistakeBtn.frame = CGRectMake(0, 0, self.width / 2.0, self.height);
    [mistakeBtn setTitle:@" 错时" forState:UIControlStateNormal];
    mistakeBtn.titleLabel.font = kFontSize15;
    [mistakeBtn setTitleColor:kColorBlack forState:UIControlStateNormal];
    [mistakeBtn setTitleColor:kColorWhite forState:UIControlStateSelected];
    [mistakeBtn setBackgroundImage:[UIImage createImageWithColor:kColorBackGroundColor] forState:UIControlStateNormal];
    [mistakeBtn setBackgroundImage:[UIImage createImageWithColor:kNavBarColor] forState:UIControlStateSelected];
    [mistakeBtn setBackgroundImage:[UIImage createImageWithColor:kNavBarColor] forState:UIControlStateHighlighted];
    mistakeBtn.tag = 100;
    [mistakeBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    mistakeBtn.selected = YES;
    [self addSubview:mistakeBtn];
    
    UIButton *rentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rentBtn.frame = CGRectMake(mistakeBtn.right, 0, mistakeBtn.width, mistakeBtn.height);
    [rentBtn setTitle:@"长租 " forState:UIControlStateNormal];
    rentBtn.titleLabel.font = kFontSize15;
    [rentBtn setTitleColor:kColorBlack forState:UIControlStateNormal];
    [rentBtn setTitleColor:kColorWhite forState:UIControlStateSelected];
    [rentBtn setBackgroundImage:[UIImage createImageWithColor:kColorBackGroundColor] forState:UIControlStateNormal];
    [rentBtn setBackgroundImage:[UIImage createImageWithColor:kNavBarColor] forState:UIControlStateSelected];
    [rentBtn setBackgroundImage:[UIImage createImageWithColor:kNavBarColor] forState:UIControlStateHighlighted];
    rentBtn.tag = 101;
    [rentBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rentBtn];
    
    mistakeBtn.selected = 0 == _selectedSegmentIndex;
    rentBtn.selected = 0 != _selectedSegmentIndex ;

}

#pragma mark ---------------event ---------------------/
- (void)changeAction:(UIButton *)button{
    
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

    
}

- (UIButton *)getButtonWithIndex:(NSInteger)index
{
    return (UIButton *)[self viewWithTag:index + 100];
}

#pragma mark -----------------Lazy---------------------/



@end
