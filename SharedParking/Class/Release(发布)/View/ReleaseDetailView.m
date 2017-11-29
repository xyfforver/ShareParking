//
//  ReleaseDetailView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/27.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ReleaseDetailView.h"
@interface ReleaseDetailView ()
//
@property (strong, nonatomic) IBOutlet UILabel *carportLab;
@property (strong, nonatomic) IBOutlet UIButton *quNumBtn;
@property (strong, nonatomic) IBOutlet UIButton *haoNumBtn;
//联系方式
@property (strong, nonatomic) IBOutlet UIView *contactView;
@property (strong, nonatomic) IBOutlet UITextField *contactField;
//时间
@property (strong, nonatomic) IBOutlet UIView *timeView;



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

    self.contactView.hidden = YES;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    
    
}

#pragma mark ---------------event ---------------------/

#pragma mark -----------------Lazy---------------------/



@end
