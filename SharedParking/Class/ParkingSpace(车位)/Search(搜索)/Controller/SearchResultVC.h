//
//  SearchResultVC.h
//  SharedParking
//
//  Created by galaxy on 2017/12/5.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchResultVC : BaseViewController
- (instancetype)initWithSearchStr:(NSString *)searchStr;

@property (nonatomic , copy) NSString *searchStr;
@end
