//
//  LoginReminderVC.h
//  SharedParking
//
//  Created by galaxy on 2017/12/1.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginReminderVC : BaseViewController
{
    
    UIScrollView *startScroll;
    
    UIImageView *img;
    
}

@property (nonatomic, copy) dispatch_block_t completionBack;

@end
