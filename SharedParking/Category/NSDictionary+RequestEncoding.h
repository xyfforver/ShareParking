//
//  NSDictionary+RequestEncoding.h
//  EasyGo
//
//  Created by 徐佳琦 on 16/5/19.
//  Copyright © 2016年 Ju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (RequestEncoding)

-(NSString*) urlEncodedKeyValueString;
-(NSString*) jsonEncodedKeyValueString;
-(NSString*) plistEncodedKeyValueString;

@end
