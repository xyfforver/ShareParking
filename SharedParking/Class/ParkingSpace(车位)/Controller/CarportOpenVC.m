//
//  CarportOpenVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/13.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportOpenVC.h"

@interface CarportOpenVC ()
@property (strong, nonatomic) IBOutlet UIButton *carNumBtn;
@property (strong, nonatomic) IBOutlet UIButton *addCarNumBtn;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *topPriceLab;

@end

@implementation CarportOpenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫一扫";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
