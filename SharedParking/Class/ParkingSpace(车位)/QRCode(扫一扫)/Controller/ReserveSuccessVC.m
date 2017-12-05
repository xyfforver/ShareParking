//
//  ReserveSuccessVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/24.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ReserveSuccessVC.h"
#import "NavigationVC.h"

#import "CarportReserveModel.h"
@interface ReserveSuccessVC ()
@property (strong, nonatomic) IBOutlet UILabel *numberLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *addressLab;
@property (strong, nonatomic) IBOutlet UIButton *nowBtn;
@property (strong, nonatomic) IBOutlet UIButton *afterBtn;

@end

@implementation ReserveSuccessVC
- (instancetype)initWithReserveId:(NSString *)reserveId{
    self = [super init];
    if (self) {
        self.reserveId = reserveId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"萧山写字楼";
    
    
    self.afterBtn.layer.borderWidth = 1;
    self.afterBtn.layer.borderColor = kColor6B6B6B.CGColor;
    
    [self loadData];
}

#pragma mark ---------------event ---------------------/
- (IBAction)nowAction:(id)sender {
    NavigationVC *vc = [[NavigationVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)afterAction:(id)sender {
    
}

#pragma mark ---------------network ---------------------/
- (void)loadData{
    kSelfWeak;
    [CarportReserveModel reserveWithReserveId:self.reserveId success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            
        }else{
            
        }
    }];
}

@end
