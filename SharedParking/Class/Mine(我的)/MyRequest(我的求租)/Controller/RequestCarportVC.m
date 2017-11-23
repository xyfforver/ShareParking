//
//  RequestCarportVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "RequestCarportVC.h"

@interface RequestCarportVC ()
@property (strong, nonatomic) IBOutlet UITextField *bournField;
@property (strong, nonatomic) IBOutlet UITextField *rangeField;
@property (strong, nonatomic) IBOutlet UIButton *mistakeBtn;
@property (strong, nonatomic) IBOutlet UIButton *rentBtn;
@property (strong, nonatomic) IBOutlet UITextField *priceField;
@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;

@end

@implementation RequestCarportVC

- (void)viewDidLoad {
    [super viewDidLoad];

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
- (IBAction)selectAction:(id)sender {

    self.mistakeBtn.selected = self.mistakeBtn == sender;
    self.rentBtn.selected = !self.mistakeBtn.selected;
}

- (IBAction)confirmAction:(id)sender {
}


@end
