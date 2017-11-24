//
//  CarportReserveVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/24.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportReserveVC.h"
#import "ReserveSuccessVC.h"
@interface CarportReserveVC ()
@property (strong, nonatomic) IBOutlet UIButton *numberBtn;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *overPriceLab;
@property (strong, nonatomic) IBOutlet UILabel *lookLab;
@property (strong, nonatomic) IBOutlet UIButton *reserveBtn;

@end

@implementation CarportReserveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"车位详情";
}


- (IBAction)reserveAction:(id)sender {
    ReserveSuccessVC *vc = [[ReserveSuccessVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
