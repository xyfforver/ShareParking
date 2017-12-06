//
//  CarportReserveVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/24.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportReserveVC.h"
#import "ReserveSuccessVC.h"

#import "CarportReserveModel.h"
#import "CarportShortItemModel.h"
@interface CarportReserveVC ()
@property (strong, nonatomic) IBOutlet UIButton *numberBtn;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *overPriceLab;
@property (strong, nonatomic) IBOutlet UILabel *lookLab;
@property (strong, nonatomic) IBOutlet UIButton *reserveBtn;
@property (strong, nonatomic) IBOutlet UIButton *reminderBtn;

@property (nonatomic , strong) CarportShortItemModel *carItemModel;

@end

@implementation CarportReserveVC
- (instancetype)initWithParkingId:(NSString *)parkingId{
    self = [super init];
    if (self) {
        self.parkingId = parkingId;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"车位详情";
    self.reminderBtn.hidden = YES;
    
    [self loadData];
    

}

#pragma mark ---------------network ---------------------/
- (void)loadData{
    kSelfWeak;
    [CarportReserveModel carportReserveWithParkingId:self.parkingId success:^(StatusModel *statusModel) {
        kSelfStrong;
        if(statusModel.flag == kFlagSuccess){
            CarportReserveModel *model = statusModel.data;
            if (model.car_chepai.count > 0) {
                strongSelf.carItemModel = [model.car_chepai firstObject];
                [strongSelf.numberBtn setTitle:strongSelf.carItemModel.car_chepai forState:UIControlStateNormal];
            }
            strongSelf.priceLab.text = [NSString stringWithFormat:@"每小时%.2f元",model.park_fee];
            strongSelf.overPriceLab.text = [NSString stringWithFormat:@"每小时%.2f元",model.park_feeovertime];
        }else{
            
        }
    }];
}

- (void)reserveData{
    kSelfWeak;
    [CarportReserveModel reserveWithParkingId:self.parkingId carNumId:self.carItemModel.id success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            CarportReserveModel *model = statusModel.data;
            
            [WSProgressHUD showImage:nil status:@"预订成功！"];
            
            [UIView animateWithDuration:0.5 animations:^{
                ReserveSuccessVC *vc = [[ReserveSuccessVC alloc]initWithReserveId:model.reserve_id];
                [strongSelf.navigationController pushViewController:vc animated:YES];
            }];
            
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
    }];
}

#pragma mark ---------------event ---------------------/

- (IBAction)reserveAction:(id)sender {
    
    [self reserveData];

    
}

@end
