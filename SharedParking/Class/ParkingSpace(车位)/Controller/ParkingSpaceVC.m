//
//  ParkingSpaceVC.m
//  SharedParking
//
//  Created by galaxy on 2017/10/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ParkingSpaceVC.h"
@interface ParkingSpaceVC ()

@end

@implementation ParkingSpaceVC
#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
}

- (void)initView{
    self.navigationItem.title = @"车位";
    self.view.backgroundColor = kColorRandom;
    
    self.navigationItem.leftBarButtonItem = [[self class] rightBarButtonWithName:@"扫一扫" imageName:nil target:self action:@selector(codeAction)];
    
    
    // 创建翻转父视图
    UIView *flipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = flipView.bounds;
    [btn1 setTitle:@"列表" forState:UIControlStateNormal];
    btn1.titleLabel.font = kFontSizeBold17;
    [btn1 setTitleColor:kColorBlack forState:UIControlStateNormal];
    btn1.tag = 1;
    [btn1 addTarget:self action:@selector(listAction:) forControlEvents:UIControlEventTouchUpInside];
    [flipView addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = flipView.bounds;
    [btn2 setTitle:@"地图" forState:UIControlStateNormal];
    btn2.titleLabel.font = kFontSizeBold17;
    [btn2 setTitleColor:kColorBlack forState:UIControlStateNormal];
    btn2.tag = 2;
    [btn2 addTarget:self action:@selector(listAction:) forControlEvents:UIControlEventTouchUpInside];
    btn2.hidden = YES;
    [flipView addSubview:btn2];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:flipView];
    self.navigationItem.rightBarButtonItem = rightItem;
}


- (void)codeAction{
    
    
}

- (void)listAction:(UIButton *)button{
    DLog(@"点击了 翻转");
    //获取到flipView
    UIView *flipView = self.navigationItem.rightBarButtonItem.customView;
    
    //取得需要翻转的按钮
    UIView *btn1 = [flipView viewWithTag:1];
    UIView *btn2 = [flipView viewWithTag:2];
    
    //是否从左侧翻转
    BOOL isLeft = btn1.hidden;
    
    //翻转视图
    [self flipWithView:flipView isLeft:isLeft];
    [self flipWithView:self.view isLeft:isLeft];
    
    //改变按钮显示状态
    btn1.hidden = !btn1.hidden;
    btn2.hidden = !btn2.hidden;
    
    button.selected = !button.selected;
}

#pragma mark -flip animation
/*
 view:需要翻转的视图
 isLeft :是否从左侧翻转
 */
- (void)flipWithView:(UIView *)view isLeft:(BOOL)isLeft{
    
    //翻转的效果 枚举
    UIViewAnimationOptions option = isLeft ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight;
    
    [UIView transitionWithView:view duration:.3 options:option animations:NULL completion:NULL];
}


@end
