//
//  CarportOpenVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/13.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportOpenVC.h"
#import "OpenStateVC.h"
#import "CarNumberAddVC.h"

#import "CarportReserveModel.h"
#import "CarportShortItemModel.h"
#import "PopBottomView.h"
@interface CarportOpenVC ()
@property (strong, nonatomic) IBOutlet UIButton *carNumBtn;
@property (strong, nonatomic) IBOutlet UIButton *addCarNumBtn;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *topPriceLab;

@property (nonatomic , strong) CarportReserveModel *carModel;
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
    
    [self loadData:nil];
}

#pragma mark ---------------network ---------------------/
- (void)loadData:(NSString *)carNumber{
    kSelfWeak;
    [CarportReserveModel qrcodeWithParkingId:self.carportId success:^(StatusModel *statusModel) {
        kSelfStrong;
        if(statusModel.flag == kFlagSuccess){
            strongSelf.carModel = statusModel.data;
            if (strongSelf.carModel.chepai_list.count > 0) {
                if (carNumber) {
                    for (CarportShortItemModel *itemModel in strongSelf.carModel.chepai_list) {
                        if ([itemModel.parking_number isEqualToString:carNumber]) {
                            strongSelf.carItemModel = itemModel;
                            break;
                        }
                    }
                }else{
                    strongSelf.carItemModel = [strongSelf.carModel.chepai_list lastObject];
                }
                
                [strongSelf.carNumBtn setTitle:strongSelf.carItemModel.car_chepai forState:UIControlStateNormal];
            }
            strongSelf.priceLab.text = [NSString stringWithFormat:@"每小时%.2f元",strongSelf.carModel.park_fee];
            strongSelf.timeLab.text = [NSString stringWithFormat:@"%@-%@",strongSelf.carModel.park_opentime,strongSelf.carModel.park_closetime];
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
    if (self.carModel.chepai_list.count > 0) {
        PopBottomView *pop = [[PopBottomView alloc]initWithFrame:self.view.bounds];
        pop.cancelColor = [UIColor redColor];
        pop.data = self.carModel.chepai_list;
        kSelfWeak;
        pop.blockCallBackIndex = ^(CarportShortItemModel *model) {
            kSelfStrong;
            strongSelf.carItemModel = model;
            [strongSelf.carNumBtn setTitle:strongSelf.carItemModel.car_chepai forState:UIControlStateNormal];
            NSLog(@"id = %@ number:%@",model.id , model.parking_number);
        };
        [pop viewShow];
    }else{
        [WSProgressHUD showImage:nil status:@"请先前往添加车牌"];
    }
}

- (IBAction)addAction:(id)sender {
    CarNumberAddVC *vc = [[CarNumberAddVC alloc]initWithType:1];
    kSelfWeak;
    vc.loadBlock = ^(NSString *carNumber) {
        kSelfStrong;
        [strongSelf loadData:carNumber];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

@end
