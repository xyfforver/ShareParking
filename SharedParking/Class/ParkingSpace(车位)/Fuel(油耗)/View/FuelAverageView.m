//
//  FuelAverageView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/1.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "FuelAverageView.h"
#import "FuelAddVC.h"


#import "ParkingSpaceVC.h"
@interface FuelAverageView ()

@end

@implementation FuelAverageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    
}

#pragma mark ---------------event ---------------------/

- (IBAction)fuelAction:(id)sender {
    DLog(@"点击了按钮");
    FuelAddVC *vc = [[FuelAddVC alloc]initWithNibName:@"FuelAddVC" bundle:[NSBundle mainBundle]];
    [self.Controller.navigationController pushViewController:vc animated:YES];
}

#pragma mark -----------------Lazy---------------------/



@end
