//
//  RequestCarportVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "RequestCarportVC.h"
#import "MyRequestModel.h"
@interface RequestCarportVC ()
@property (strong, nonatomic) IBOutlet UITextField *bournField;//目的地
@property (strong, nonatomic) IBOutlet UITextField *rangeField;//范围
@property (strong, nonatomic) IBOutlet UIButton *rentBtn;
@property (strong, nonatomic) IBOutlet UITextField *priceField;//价格
@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;

@end

@implementation RequestCarportVC
- (instancetype)initWithRequestId:(NSString *)requestId{
    self = [super init];
    if (self) {
        self.requestId = requestId;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    if (self.requestId) {
        [self loadData];
    }
}

- (void)initView{
    self.title = @"求租车位";
    
//    self.rentBtn.layer.borderWidth = 1;
//    self.rentBtn.layer.borderColor = kNavBarColor.CGColor;
//    [self.rentBtn setTitleColor:kColorWhite forState:UIControlStateSelected];
//    [self.rentBtn setBackgroundImage:[UIImage createImageWithColor:kNavBarColor] forState:UIControlStateSelected];
}

#pragma mark ---------------network ---------------------/
- (void)loadData{
    kSelfWeak;
    [MyRequestModel myRequestInfoWithId:self.requestId success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            [strongSelf setRequestData:statusModel.data];
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
    }];
}

- (void)issueMyRequestData{
    [MyRequestModel issueMyRequestInfoWithAddress:self.bournField.text range:self.rangeField.text price:self.priceField.text success:^(StatusModel *statusModel) {
        [self getDataWithStatusModel:statusModel];
    }];
}

- (void)updateMyRequestData{
    [MyRequestModel UpdateMyRequestInfoWithId:self.requestId address:self.bournField.text range:self.rangeField.text price:self.priceField.text success:^(StatusModel *statusModel) {
        [self getDataWithStatusModel:statusModel];
    }];
}

- (void)getDataWithStatusModel:(StatusModel *)statusModel{
    if (statusModel.flag == kFlagSuccess) {
        if (self.reloadBlock) {
            self.reloadBlock();
        }
        
        [self backToSuperView];
    }else{
        [WSProgressHUD showImage:nil status:statusModel.message];
    }
}

- (void)setRequestData:(MyRequestModel *)model{
    self.priceField.text = [NSString stringWithFormat:@"%.2f",model.help_money];
    self.rangeField.text = [NSString stringWithFormat:@"%ld",model.help_fanwei];
    self.bournField.text = model.help_address;

    
}
#pragma mark ---------------event ---------------------/
- (IBAction)selectAction:(id)sender {


}

- (IBAction)confirmAction:(id)sender {
    if (self.bournField.text.length <= 0) {
        [WSProgressHUD showImage:nil status:@"请输入目的地"];
        return;
    }
    
    if (self.rangeField.text.length <= 0) {
        [WSProgressHUD showImage:nil status:@"请输入求租范围"];
        return;
    }
    
    if (self.priceField.text.length <= 0) {
        [WSProgressHUD showImage:nil status:@"请输入理想价格"];
        return;
    }
    
    if (self.requestId) {
        [self updateMyRequestData];
    }else{
        [self issueMyRequestData];
    }
}


@end
