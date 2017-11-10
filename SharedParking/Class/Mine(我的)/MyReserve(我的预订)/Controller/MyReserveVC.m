//
//  MyReserveVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/10.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MyReserveVC.h"
#import "MyRequestRentHeadView.h"
#import "MyReserveItemView.h"
@interface MyReserveVC ()
@property (nonatomic , strong) MyRequestRentHeadView *headView;
@property (nonatomic , strong) MyReserveItemView *itemView;
@end

@implementation MyReserveVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];

}

- (void)initView{
    self.title = @"我的预订";
    
    [self.view addSubview:self.headView];
    
    [self.view addSubview:self.itemView];
    
}

#pragma mark ---------------NetWork-------------------------/


#pragma mark ---------------Event-------------------------/


#pragma mark ---------------Lazy-------------------------/
- (MyRequestRentHeadView *)headView{
    if (!_headView) {
        _headView = [[MyRequestRentHeadView alloc]initWithType:JMHeaderReserveParkingSpaceType frame:CGRectMake(0, 0, kScreenWidth, [MyRequestRentHeadView getHeight])];
    }
    return _headView;
}

- (MyReserveItemView *)itemView{
    if (!_itemView) {
        _itemView = [[MyReserveItemView alloc]initWithFrame:CGRectMake(0, self.headView.bottom, kScreenWidth, [MyReserveItemView getHeight])];
    }
    return _itemView;
}

@end
