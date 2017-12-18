//
//  CarportReserveVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/24.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportReserveVC.h"
#import "ReserveSuccessVC.h"
#import "CarNumberAddVC.h"
#import "PopBottomView.h"

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

@property (nonatomic , strong) CarportReserveModel *carModel;
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
            strongSelf.carModel = statusModel.data;
            if (strongSelf.carModel.car_chepai.count > 0) {
                strongSelf.carItemModel = [strongSelf.carModel.car_chepai firstObject];
                [strongSelf.numberBtn setTitle:strongSelf.carItemModel.car_chepai forState:UIControlStateNormal];
            }
            strongSelf.priceLab.text = [NSString stringWithFormat:@"每小时%.2f元",strongSelf.carModel.park_fee];
            strongSelf.overPriceLab.text = [NSString stringWithFormat:@"每小时%.2f元",strongSelf.carModel.park_feeovertime];
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
    
    [UIAlertView alertViewWithTitle:@"提示" message:@"确定要预订此车位嘛？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] onDismiss:^(int buttonIndex, NSString *buttonTitle) {
        [self reserveData];        
    } onCancel:nil];
 
}
 
- (IBAction)selectAction:(id)sender {
    if (self.carModel.car_chepai.count > 0) {
        PopBottomView *pop = [[PopBottomView alloc]initWithFrame:self.view.bounds];
        pop.cancelColor = [UIColor redColor];
        pop.data = self.carModel.car_chepai;
        kSelfWeak;
        pop.blockCallBackIndex = ^(CarportShortItemModel *model) {
            kSelfStrong;
            strongSelf.carItemModel = model;
            [strongSelf.numberBtn setTitle:strongSelf.carItemModel.car_chepai forState:UIControlStateNormal];
            NSLog(@"id = %@ number:%@",model.id , model.parking_number);
        };
        [pop viewShow];
    }else{
        [WSProgressHUD showImage:nil status:@"请先前往添加车牌"];
    }
}

- (IBAction)addAction:(id)sender {
    CarNumberAddVC *vc = [[CarNumberAddVC alloc]initWithType:1];
    [self.navigationController pushViewController:vc animated:YES];
}





@end
