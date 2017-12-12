//
//  ReleaseDetailView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/27.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ReleaseDetailView.h"
#import "SelectCarportVC.h"
#import "CarportCertificationVC.h"
@interface ReleaseDetailView ()
//
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *carportLab;
@property (strong, nonatomic) IBOutlet UITextField *numField;

//车位类型
@property (strong, nonatomic) IBOutlet UIButton *plotCTBtn;
@property (strong, nonatomic) IBOutlet UIButton *officeCTBtn;
@property (strong, nonatomic) IBOutlet UIButton *otherCTBtn;
@property (strong, nonatomic) IBOutlet UIButton *carSelectBtn;
//出租对象
@property (strong, nonatomic) IBOutlet UIButton *unlimitedRTBtn;
@property (strong, nonatomic) IBOutlet UIButton *limitedRTBtn;
//车位描述
@property (strong, nonatomic) IBOutlet UITextView *infoTextView;
//下一步
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *allHeight;

@property (copy, nonatomic) NSString *parkId;
@end

@implementation ReleaseDetailView

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

- (void)layoutSubviews{
    
    [super layoutSubviews];

    self.infoTextView.placeholder = @"例如：地上车位，在停车场的东北角";
    self.scrollView.contentSize = CGSizeMake(0, self.nextBtn.bottom + 50);
    
    self.carSelectBtn = self.plotCTBtn;
    
    [self setSelectState:self.plotCTBtn];
    [self setSelectState:self.officeCTBtn];
    [self setSelectState:self.otherCTBtn];
    [self setSelectState:self.unlimitedRTBtn];
    [self setSelectState:self.limitedRTBtn];
    
    kSelfWeak;
    [self.carportLab zzh_addTapGestureWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        kSelfStrong;
        SelectCarportVC *vc = [[SelectCarportVC alloc]init];
        vc.backBlock = ^(NSString *parkId, NSString *parkTitle) {
            strongSelf.carportLab.text = parkTitle;
            strongSelf.parkId = parkId;
        };
        [strongSelf.Controller.navigationController pushViewController:vc animated:YES];
    }];
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{

    
}

- (void)setSelectState:(UIButton *)button{
    [button setTitleColor:kColorWhite forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage createImageWithColor:kNavBarColor] forState:UIControlStateSelected];
}

#pragma mark ---------------event ---------------------/

- (IBAction)carportAction:(UIButton *)sender {
    self.carSelectBtn.selected = NO;
    sender.selected = YES;
    self.carSelectBtn = sender;
    
}

- (IBAction)objectAction:(UIButton *)sender {

    self.unlimitedRTBtn.selected = sender == self.unlimitedRTBtn;
    self.limitedRTBtn.selected = !self.unlimitedRTBtn.selected;
}


- (IBAction)nextAction:(id)sender {
    if ([NSString isNull:self.parkId]) {
        [WSProgressHUD showImage:nil status:@"请选择车位所在地点"];
        return;
    }

    if (self.numField.text.length == 0) {
        [WSProgressHUD showImage:nil status:@"请输入泊位编码"];
        return;
    }
    
    ReleaseModel *model = [[ReleaseModel alloc]init];
    model.park_id = self.parkId;
    model.parking_number = self.numField.text;
//    model.park_id = @"2";
//    model.parking_number = @"2";
    model.parking_cheweitype = self.carSelectBtn.tag - 100;
    model.parking_obj = !self.unlimitedRTBtn.selected;
    model.remark = self.infoTextView.text;
    
    CarportCertificationVC *vc = [[CarportCertificationVC alloc]initWithNibName:@"CarportCertificationVC" bundle:[NSBundle mainBundle]];
    vc.type = CarportShortRentType;
    vc.model = model;
    kSelfWeak;
    vc.loadBlock = ^{
        kSelfStrong;
        strongSelf.parkId = nil;
        strongSelf.numField.text = nil;
        strongSelf.infoTextView.text = nil;
    };
    [self.Controller.navigationController pushViewController:vc animated:YES];
}
#pragma mark -----------------Lazy---------------------/



@end
