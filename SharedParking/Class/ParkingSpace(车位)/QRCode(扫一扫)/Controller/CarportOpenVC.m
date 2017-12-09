//
//  CarportOpenVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/13.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportOpenVC.h"
#import "OpenStateVC.h"
#import "CarportReserveModel.h"
#import "CarportShortItemModel.h"
@interface CarportOpenVC ()
@property (strong, nonatomic) IBOutlet UIButton *carNumBtn;
@property (strong, nonatomic) IBOutlet UIButton *addCarNumBtn;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *topPriceLab;

@property (nonatomic , strong) CarportShortItemModel *carItemModel;
@end

@implementation CarportOpenVC
- (instancetype)initWithCarportId:(NSString *)carportId{
    self = [super init];
    if (self) {
        self.carportId = carportId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫一扫";
    
    [self loadData];
}

#pragma mark ---------------network ---------------------/
- (void)loadData{
    kSelfWeak;
    [CarportReserveModel qrcodeWithParkingId:self.carportId success:^(StatusModel *statusModel) {
        kSelfStrong;
        if(statusModel.flag == kFlagSuccess){
            CarportReserveModel *model = statusModel.data;
            if (model.chepai_list.count > 0) {
                strongSelf.carItemModel = [model.chepai_list firstObject];
                [strongSelf.carNumBtn setTitle:strongSelf.carItemModel.car_chepai forState:UIControlStateNormal];
            }
            strongSelf.priceLab.text = [NSString stringWithFormat:@"每小时%.2f元",model.park_fee];
            strongSelf.timeLab.text = [NSString stringWithFormat:@"%@-%@",model.park_opentime,model.park_closetime];
        }else{
            
        }
    }];
}



- (IBAction)OpenAction:(id)sender {
    
    [self loginVerifySuccess:^{
        OpenStateVC *vc = [[OpenStateVC alloc]initWithCarportId:self.carportId carNumId:self.carItemModel.id];
        [self.navigationController pushViewController:vc animated:YES];
    }];

}
- (IBAction)selectAction:(id)sender {
    
}

- (IBAction)addAction:(id)sender {
    
}

@end
