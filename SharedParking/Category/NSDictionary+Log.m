//
//  NSDictionary+Log.m
//  qunmeng
//
//  Created by 群盟 on 2017/5/3.
//  Copyright © 2017年 sks. All rights reserved.
//

#import "NSDictionary+Log.h"

@implementation NSDictionary (Log)
- (NSString*)descriptionWithLocale:(id)locale {
    
    NSMutableString *str = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key,id obj,BOOL*stop) {
        
        [str appendFormat:@"\t%@ = %@;\n", key, obj];
        
    }];
    
    [str appendString:@"}\n"];
    
    return str;
    
}
@end
