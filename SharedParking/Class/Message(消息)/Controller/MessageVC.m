//
//  MessageVC.m
//  SharedParking
//
//  Created by galaxy on 2017/10/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MessageVC.h"
@interface MessageVC ()

@end

@implementation MessageVC
#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
}

- (void)initView{
    self.navigationItem.title = @"消息";
    self.view.backgroundColor = kColorRandom;
}


@end
