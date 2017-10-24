//
//  ReleaseVC.m
//  SharedParking
//
//  Created by galaxy on 2017/10/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ReleaseVC.h"
@interface ReleaseVC ()

@end

@implementation ReleaseVC
#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
}

- (void)initView{
    self.navigationItem.title = @"发布";
    self.view.backgroundColor = kColorRandom;
}


@end
