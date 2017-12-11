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

#pragma mark ---------------event ---------------------/

- (IBAction)nextAction:(id)sender {
    
    
    
    CarportCertificationVC *vc = [[CarportCertificationVC alloc]initWithNibName:@"CarportCertificationVC" bundle:[NSBundle mainBundle]];
    vc.type = CarportShortRentType;
    [self.Controller.navigationController pushViewController:vc animated:YES];
}
#pragma mark -----------------Lazy---------------------/



@end
