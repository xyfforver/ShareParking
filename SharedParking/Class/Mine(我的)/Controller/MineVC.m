//
//  MineVC.m
//  SharedParking
//
//  Created by galaxy on 2017/10/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MineVC.h"
@interface MineVC ()

@end

@implementation MineVC
#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
}

- (void)initView{
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = kColorRandom;
}


@end
