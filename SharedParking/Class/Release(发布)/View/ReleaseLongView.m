//
//  ReleaseLongView.m
//  SharedParking
//
//  Created by galaxy on 2017/12/9.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ReleaseLongView.h"
#import "CarportCertificationVC.h"
@interface ReleaseLongView ()
//
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *titleField;
@property (strong, nonatomic) IBOutlet UILabel *carportLab;
@property (strong, nonatomic) IBOutlet UITextField *numField;
@property (strong, nonatomic) IBOutlet UITextField *priceField;
@property (strong, nonatomic) IBOutlet UITextField *telField;

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


@end

@implementation ReleaseLongView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.infoTextView.placeholder = @"例如：地上车位，在停车场的东北角";
    self.scrollView.contentSize = CGSizeMake(0, self.nextBtn.bottom + 50);
}

#pragma mark ---------------event ---------------------/

- (IBAction)nextAction:(id)sender {
    CarportCertificationVC *vc = [[CarportCertificationVC alloc]initWithNibName:@"CarportCertificationVC" bundle:[NSBundle mainBundle]];
    vc.type = CarportLongRentType;
    [self.Controller.navigationController pushViewController:vc animated:YES];
}
#pragma mark -----------------Lazy---------------------/



@end
