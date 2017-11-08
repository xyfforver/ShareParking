//
//  FuelAddVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/1.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "FuelAddVC.h"

@interface FuelAddVC ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *mileageField;
@property (strong, nonatomic) IBOutlet UITextField *priceField;
@property (strong, nonatomic) IBOutlet UITextField *oilPriceField;
@property (strong, nonatomic) IBOutlet UITextField *oilMassField;

@end

@implementation FuelAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加加油记录";
    self.view.backgroundColor = kBackGroundGrayColor;
    
    self.mileageField.delegate = self;
    self.priceField.delegate = self;
    self.oilPriceField.delegate = self;
    self.oilMassField.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
}

- (void)keyboardWillShow: (NSNotification*)notification {
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]; //获得键盘的rect
    //通过rect做响应的弹起等
}

- (void)keyboardWillHide: (NSNotification*)notification {
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]; //获得键盘的rect
    //通过rect做响应的弹起等
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}


- (IBAction)saveAction:(id)sender {
    
    
    DLog(@"保存");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
