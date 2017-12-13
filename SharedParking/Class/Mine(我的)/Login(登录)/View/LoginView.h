//
//  LoginView.h
//  SharedParking
//
//  Created by galaxy on 2017/12/1.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView
@property (nonatomic ,assign) NSInteger type;

@property (nonatomic , copy) void(^loginBlock)(NSString *tel , NSString *code);

@end
