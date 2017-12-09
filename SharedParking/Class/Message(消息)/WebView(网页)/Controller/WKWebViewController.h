//
//  WKWebViewController.h
//  yimaxingtianxia
//
//  Created by lingbao on 2017/6/30.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "BaseViewController.h"

@interface WKWebViewController : BaseViewController
/**
 *  @param webStr 链接
 */
- (id)initWithWebStr:(NSString *)webStr withTitle:(NSString *)title;

- (instancetype)initWithHTMLString:(NSString *)string baseURL:(NSURL *)baseURL withTitle:(NSString *)title;

@property (nonatomic,copy)NSString *webStr;

@property (nonatomic,copy)NSString *titleStr;

@property (copy, nonatomic) NSString *htmlString;

@property (strong, nonatomic) NSURL *baseURL;
@end
