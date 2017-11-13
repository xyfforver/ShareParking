//
//  FuelAddRecordVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/13.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "FuelAddRecordVC.h"
#import "FuelCounterTBView.h"
@interface FuelAddRecordVC ()
@property (nonatomic , strong) FuelCounterTBView *tbView;
@end

@implementation FuelAddRecordVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];

}

- (void)initView{
    self.title = @"加油记录";
    
    [self.view addSubview:self.tbView];
}

#pragma mark ---------------NetWork-------------------------/


#pragma mark ---------------Event-------------------------/


#pragma mark ---------------Lazy-------------------------/
- (FuelCounterTBView *)tbView{
    if (!_tbView) {
        _tbView = [[FuelCounterTBView alloc]initWithFrame:CGRectMake(0, kMargin10, kScreenWidth, kBodyHeight - kMargin10) style:UITableViewStylePlain];
        _tbView.type = 1;
    }
    return _tbView;
}

@end
