//
//  CarportOpenVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/13.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportOpenVC.h"
#import "OpenStateVC.h"
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
    
    
    NSArray *itemArr = [UIFont familyNames];
    for (NSString *str in itemArr) {
        DLog(@"%@",str);
    }
}

- (IBAction)OpenAction:(id)sender {
    
    OpenStateVC *vc = [[OpenStateVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
