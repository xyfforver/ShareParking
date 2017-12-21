//
//  FuelAddVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/1.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "FuelAddVC.h"
#import "DateDayView.h"
#import "FuelModel.h"
@interface FuelAddVC ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *mileageField;
@property (strong, nonatomic) IBOutlet UITextField *priceField;
@property (strong, nonatomic) IBOutlet UITextField *oilPriceField;
@property (strong, nonatomic) IBOutlet UITextField *oilMassField;
@property (strong, nonatomic) IBOutlet UILabel *dateLab;

@property (nonatomic , strong) DateDayView *dateView;
@end

@implementation FuelAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];

}

- (void)initView{
    self.title = @"添加加油记录";
    self.view.backgroundColor = kBackGroundGrayColor;
    
    self.mileageField.delegate = self;
    self.priceField.delegate = self;
    self.oilPriceField.delegate = self;
    self.oilMassField.delegate = self;
    
    [self.dateLab zzh_addTapGestureWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
        [manager resignFirstResponder];
        
        DateDayView *dayView = [[DateDayView alloc]initWithConfirm:^(NSString *dateStr) {
            self.dateLab.text = dateStr;
        }];
        [dayView show];
    }];
}

#pragma mark ---------------loadData ---------------------/
- (void)saveData{
    [FuelModel addFuelRecordWithDateStr:self.dateLab.text mileage:self.mileageField.text price:self.priceField.text oilPrice:self.oilPriceField.text oilMass:self.oilMassField.text success:^(StatusModel *statusModel) {
        [WSProgressHUD showImage:nil status:statusModel.message];
        if (statusModel.flag == kFlagSuccess) {
            [self backToSuperView];
        }
    }];
}

#pragma mark ---------------event ---------------------/
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    //限制输入 保留小数点后两位
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    //只能输入一个小数点
    if ([futureString containsString:@"."] && [string isEqual:@"."]) {
        return NO;
    }
    [futureString  insertString:string atIndex:range.location];
    
    //限制输入2位小数
    if (![self judgeAmout:futureString]) {
        return NO;
    }
    
    return  [self setTextFieldValue:textField futureString:futureString];

}

- (BOOL)judgeAmout:(NSString *)futureString{
    //限制只能输入小数点后两位
    NSInteger flag=0;
    const NSInteger limited = 2;
    for (NSInteger i = futureString.length-1; i>=0; i--) {
        
        if ([futureString characterAtIndex:i] == '.') {
            
            if (flag > limited) {
                return NO;
            }
            
            break;
        }
        flag++;
    }

    return YES;

}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    if (textField.text.length > 0 ) {
        [self setTextFieldValue:textField futureString:textField.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    
    return YES;
}

- (BOOL)setTextFieldValue:(UITextField *)textField futureString:(NSString *)futureString{
    if (textField == self.priceField) {
        if (self.oilPriceField.text.length > 0) {
            CGFloat result = [futureString floatValue]/[self.oilPriceField.text floatValue];
            self.oilMassField.text = [NSString stringWithFormat:@"%.2f",result];
            return YES;
        }
        
        if (self.oilMassField.text.length > 0) {
            CGFloat result = [futureString floatValue]/[self.oilMassField.text floatValue];
            self.oilPriceField.text = [NSString stringWithFormat:@"%.2f",result];
            return YES;
        }
    }
    
    if (textField == self.oilPriceField) {
        if (self.priceField.text.length > 0) {
            CGFloat result = [self.priceField.text floatValue]/[futureString floatValue];
            self.oilMassField.text = [NSString stringWithFormat:@"%.2f",result];
            return YES;
        }
        
        if (self.oilMassField.text.length > 0) {
            CGFloat result = [futureString floatValue] * [self.oilMassField.text floatValue];
            self.priceField.text = [NSString stringWithFormat:@"%.2f",result];
            return YES;
        }
    }
    
    if (textField == self.oilMassField) {
        if (self.oilPriceField.text.length > 0) {
            CGFloat result = [futureString floatValue] * [self.oilPriceField.text floatValue];
            self.priceField.text = [NSString stringWithFormat:@"%.2f",result];
            return YES;
        }
        
        if (self.priceField.text.length > 0) {
            CGFloat result = [self.priceField.text floatValue]/[futureString floatValue];
            self.oilPriceField.text = [NSString stringWithFormat:@"%.2f",result];
            return YES;
        }
    }
    return YES;
}

- (IBAction)saveAction:(id)sender {
    
    if (self.dateLab.text.length == 0) {
        [WSProgressHUD showImage:nil status:@"请添加加油时间"];
        return;
    }
    
    if (self.mileageField.text.length == 0) {
        [WSProgressHUD showImage:nil status:@"请添加当前里程表读数"];
        return;
    }
    
    if (self.priceField.text.length == 0) {
        [WSProgressHUD showImage:nil status:@"请添加本次加油金额"];
        return;
    }
    
    if (self.oilPriceField.text.length == 0) {
        [WSProgressHUD showImage:nil status:@"请添加当日油价"];
        return;
    }
    
    if (self.oilMassField.text.length == 0) {
        [WSProgressHUD showImage:nil status:@"请添加本次加油量"];
        return;
    }
    
    DLog(@"保存");
    [self saveData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
