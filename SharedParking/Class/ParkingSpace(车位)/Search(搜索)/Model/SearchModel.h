//
//  SearchModel.h
//  SharedParking
//
//  Created by galaxy on 2017/12/2.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface SearchModel : BaseModel


//搜索
+ (void)searchWithTitle:(NSString *)title success:(NetCompletionBlock)success;
@end
