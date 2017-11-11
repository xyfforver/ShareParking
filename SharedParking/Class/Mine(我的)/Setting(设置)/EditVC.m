//
//  EditVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/11.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "EditVC.h"

@interface EditVC ()
@property (strong, nonatomic) IBOutlet UITextField *phoneNumField;
@property (strong, nonatomic) IBOutlet UITextField *zhifubaoField;

@end

@implementation EditVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"编辑";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
