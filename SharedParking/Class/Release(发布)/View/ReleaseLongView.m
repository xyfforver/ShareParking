//
//  ReleaseLongView.m
//  SharedParking
//
//  Created by galaxy on 2017/12/9.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ReleaseLongView.h"
#import "SelectCarportVC.h"
#import "CarportCertificationVC.h"
#import "ReleaseModel.h"
@interface ReleaseLongView ()<UITextViewDelegate>
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
@property (strong, nonatomic) IBOutlet UIButton *carSelectBtn;
//出租对象
@property (strong, nonatomic) IBOutlet UIButton *unlimitedRTBtn;
@property (strong, nonatomic) IBOutlet UIButton *limitedRTBtn;
//车位描述
@property (strong, nonatomic) IBOutlet UITextView *infoTextView;
//下一步
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;


@property (copy, nonatomic) NSString *parkId;
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
    
    self.infoTextView.placeholder = @"例如：地上车位，在停车场的东北角(50字以内)";
    self.infoTextView.delegate = self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:self.infoTextView];
    
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


- (void)setSelectState:(UIButton *)button{
    [button setTitleColor:kColorWhite forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage createImageWithColor:kNavBarColor] forState:UIControlStateSelected];
}

#pragma mark ---------------event ---------------------/
#pragma mark - Notification Method
-(void)textViewEditChanged:(NSNotification *)obj
{
    UITextView *textView = (UITextView *)obj.object;
    [Util limitTextView:textView Length:50];
//    NSUInteger length = textView.text.length;
//    DLog(@"%@,%@",@(length),textView.text);
}

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
    if (self.titleField.text.length == 0) {
        [WSProgressHUD showImage:nil status:@"请输入车位标题"];
        return;
    }
    
    if ([NSString isNull:self.parkId]) {
        [WSProgressHUD showImage:nil status:@"请选择车位所在地点"];
        return;
    }
    
    if (self.numField.text.length == 0) {
        [WSProgressHUD showImage:nil status:@"请输入泊位编码"];
        return;
    }
    
    if (self.priceField.text.length == 0) {
        [WSProgressHUD showImage:nil status:@"请输入出租金额"];
        return;
    }
    
    if (![self.telField.text isTel]) {
        [WSProgressHUD showImage:nil status:@"请输入正确的手机号码"];
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
    model.parking_title = self.titleField.text;
    model.parking_fee = self.priceField.text;
    model.user_mobile = self.telField.text;
    
    CarportCertificationVC *vc = [[CarportCertificationVC alloc]initWithNibName:@"CarportCertificationVC" bundle:[NSBundle mainBundle]];
    vc.type = CarportLongRentType;
    vc.model = model;
    kSelfWeak;
    vc.loadBlock = ^{
        kSelfStrong;
        strongSelf.parkId = nil;
        strongSelf.numField.text = nil;
        strongSelf.infoTextView.text = nil;
        strongSelf.titleField.text = nil;
        strongSelf.priceField.text = nil;
        strongSelf.telField.text = nil;
    };
    [self.Controller.navigationController pushViewController:vc animated:YES];
}
#pragma mark -----------------Lazy---------------------/



@end
