//
//  CarportCertificationVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/29.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportCertificationVC.h"

@interface CarportCertificationVC ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *equityImgView;
@property (strong, nonatomic) IBOutlet UIButton *equityBtn;
@property (strong, nonatomic) IBOutlet UIImageView *carportImgView;
@property (strong, nonatomic) IBOutlet UIButton *carportBtn;
@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;
@property (strong, nonatomic) IBOutlet UILabel *infoLab;

@end

@implementation CarportCertificationVC
- (instancetype)initWithType:(CarportRentType)type{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    self.scrollView.contentSize = CGSizeMake(0, self.confirmBtn.bottom + 100);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView{
    self.title = @"车位认证";
    
    [self.equityBtn lc_imageTitleVerticalAlignmentWithSpace:25];
    [self.carportBtn lc_imageTitleVerticalAlignmentWithSpace:25];
    self.equityBtn.userInteractionEnabled = NO;
    self.carportBtn.userInteractionEnabled = NO;
  
    self.equityImgView.userInteractionEnabled = YES;
    self.carportImgView.userInteractionEnabled = YES;
    
    self.infoLab.text = @"温馨提示：\n1.为了确保您的车位顺利审核，请提交正确的车位信息。\n2.审核过程中，客服人员将会与您核对车位信息，请您保持电话畅通。\n3.车位注册成功后可自由管理车位。";

//    self.scrollView.contentSize = CGSizeMake(0, self.confirmBtn.bottom + 100);
}


- (IBAction)confirmAction:(id)sender {
    
    
}




@end
