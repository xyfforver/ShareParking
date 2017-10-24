//
//  NSArray+Log.m
//  qunmeng
//
//  Created by 群盟 on 2017/5/3.
//  Copyright © 2017年 sks. All rights reserved.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)
- (NSString*)descriptionWithLocale:(id)locale {
    
    NSMutableString*str = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL*stop) {
        
        [str appendFormat:@"\t%@,\n", obj];
        
    }];
    
    [str appendString:@")"];
    
    return str;
    
}
@end
