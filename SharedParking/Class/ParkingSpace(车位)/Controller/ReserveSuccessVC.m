//
//  ReserveSuccessVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/24.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ReserveSuccessVC.h"

@interface ReserveSuccessVC ()
@property (strong, nonatomic) IBOutlet UILabel *numberLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *addressLab;
@property (strong, nonatomic) IBOutlet UIButton *nowBtn;
@property (strong, nonatomic) IBOutlet UIButton *afterBtn;

@end

@implementation ReserveSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"萧山写字楼";
    
    
    self.afterBtn.layer.borderWidth = 1;
    self.afterBtn.layer.borderColor = kColor6B6B6B.CGColor;
}

- (IBAction)nowAction:(id)sender {
    
}

- (IBAction)afterAction:(id)sender {
    
}


@end
