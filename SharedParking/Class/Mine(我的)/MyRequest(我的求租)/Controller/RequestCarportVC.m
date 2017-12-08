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
@property (strong, nonatomic) IBOutlet UITextField *bournField;
@property (strong, nonatomic) IBOutlet UITextField *rangeField;
@property (strong, nonatomic) IBOutlet UIButton *mistakeBtn;
@property (strong, nonatomic) IBOutlet UIButton *rentBtn;
@property (strong, nonatomic) IBOutlet UITextField *priceField;
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
    [self loadData];
}

- (void)initView{
    self.title = @"求租车位";
    
    self.mistakeBtn.layer.borderWidth = 1;
    self.mistakeBtn.layer.borderColor = kNavBarColor.CGColor;
    [self.mistakeBtn setTitleColor:kColorWhite forState:UIControlStateSelected];
    [self.mistakeBtn setBackgroundImage:[UIImage createImageWithColor:kNavBarColor] forState:UIControlStateSelected];
    
    self.rentBtn.layer.borderWidth = 1;
    self.rentBtn.layer.borderColor = kNavBarColor.CGColor;
    [self.rentBtn setTitleColor:kColorWhite forState:UIControlStateSelected];
    [self.rentBtn setBackgroundImage:[UIImage createImageWithColor:kNavBarColor] forState:UIControlStateSelected];
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

- (void)setRequestData:(MyRequestModel *)model{
    self.priceField.text = [NSString stringWithFormat:@"%.2f",model.help_money];
    self.rangeField.text = [NSString stringWithFormat:@"%ld",model.help_fanwei];
    self.bournField.text = model.help_address;
    
    self.mistakeBtn.selected = !model.help_type;
    self.rentBtn.selected = model.help_type;
    
}
#pragma mark ---------------event ---------------------/
- (IBAction)selectAction:(id)sender {

    self.mistakeBtn.selected = self.mistakeBtn == sender;
    self.rentBtn.selected = !self.mistakeBtn.selected;
}

- (IBAction)confirmAction:(id)sender {
}


@end
