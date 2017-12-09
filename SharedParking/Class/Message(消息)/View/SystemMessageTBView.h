//
//  SystemMessageTBView.h
//  SharedParking
//
//  Created by galaxy on 2017/12/9.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseTBView.h"

@interface SystemMessageTBView : BaseTBView
@property (nonatomic , strong) NSMutableArray *dataArr;

@property (nonatomic , assign) NSInteger page;
@end
