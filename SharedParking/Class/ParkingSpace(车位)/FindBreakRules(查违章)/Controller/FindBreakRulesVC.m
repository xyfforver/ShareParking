//
//  FindBreakRulesVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/16.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "FindBreakRulesVC.h"
#import "FindBreakRulesView.h"
@interface FindBreakRulesVC ()
@property (nonatomic , strong) FindBreakRulesView *findView;
@end

@implementation FindBreakRulesVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];

}

- (void)initView{
    self.title = @"查违章";
    
    [self.view addSubview:self.findView];
}

#pragma mark ---------------NetWork-------------------------/


#pragma mark ---------------Event-------------------------/


#pragma mark ---------------Lazy-------------------------/
- (FindBreakRulesView *)findView{
    if (!_findView) {
        _findView = [[FindBreakRulesView alloc]initWithFrame:kScreenRect];
    }
    return _findView;
}

@end
