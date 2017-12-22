//
//  Util.m
//  HKMember
//
//  Created by Jackie on 14-7-23.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import "Util.h"

@implementation Util

//限制textField输入的文字
+(BOOL)limitTextFieldInputWord:(NSString *)string limitStr:(NSString *)limitStr
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:limitStr] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    return canChange;
}

//限制textField不能输入的字符
+(BOOL)limitTextFieldCanNotInputWord:(NSString *)string limitStr:(NSString *)limitStr
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:limitStr] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    return !canChange;
}

//判断输入的字符长度 一个汉字算2个字符
+ (NSUInteger)unicodeLengthOfString:(NSString *)text {
    NSUInteger asciiLength = 0;
    for(NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

//字符串截到对应的长度包括中文 一个汉字算2个字符
+ (NSString *)subStringIncludeChinese:(NSString *)text ToLength:(NSUInteger)length{
    
    if (text==nil) {
        return text;
    }
    
    NSUInteger asciiLength = 0;
    NSUInteger location = 0;
    for(NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
        
        if (asciiLength==length) {
            location=i;
            break;
        }else if (asciiLength>length){
            location=i-1;
            break;
        }
        
    }
    
    if (asciiLength<length) { //文字长度小于限制长度
        return text;
        
    } else {
        
        __block NSMutableString * finalStr = [NSMutableString stringWithString:text];
        
        [text enumerateSubstringsInRange:NSMakeRange(0, [text length]) options:NSStringEnumerationByComposedCharacterSequences|NSStringEnumerationReverse usingBlock:
         ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
             
//             DLog(@"substring:%@ substringRange:%@  enclosingRange:%@",substring,NSStringFromRange(substringRange),NSStringFromRange(enclosingRange));
             
             if (substringRange.location<=location+1) {
                 NSString *temp=[text substringToIndex:substringRange.location];
                 finalStr=[NSMutableString stringWithString:temp];
                 *stop=YES;
             }
             
         }];

        return finalStr;
    }
}


+(void)limitIncludeChineseTextField:(UITextField *)textField Length:(NSUInteger)maxLength
{
    NSString *toBeString = textField.text;
    NSUInteger length = [self unicodeLengthOfString:toBeString];
    
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            
            if (length > maxLength) {
                
                textField.text = [self subStringIncludeChinese:toBeString ToLength:maxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        
        if (length > maxLength) {
            textField.text = [self subStringIncludeChinese:toBeString ToLength:maxLength];
        }
    }
}


//限制UITextField输入的长度，不包括汉字
+(void)limitTextField:(UITextField *)textField Length:(NSUInteger)maxLength
{
    NSString *toBeString = textField.text;
    if (toBeString.length > maxLength) {
        textField.text = [toBeString substringToIndex:maxLength];
    }
    
}

//用于限制UITextView的输入中英文限制
+(void)limitIncludeChineseTextView:(UITextView *)textview Length:(NSUInteger)maxLength
{
    NSString *toBeString = textview.text;
    NSUInteger length = [self unicodeLengthOfString:toBeString];
    
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textview markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textview positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            
            if (length > maxLength) {
                
                textview.text = [self subStringIncludeChinese:toBeString ToLength:maxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        
        if (length > maxLength) {
            textview.text = [self subStringIncludeChinese:toBeString ToLength:maxLength];
        }
    }
}

//限制UITextView输入的长度，不包括汉字
+(void)limitTextView:(UITextView *)textview Length:(NSUInteger)maxLength
{
    NSString *toBeString = textview.text;
    if (toBeString.length > maxLength) {
        textview.text = [toBeString substringToIndex:maxLength];
    }
    
}

//是否是纯数字
+ (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}


/// 一个字符串中与首字母（"\r"）相同的连续字符个数 (针对搜狗输入的换行键)
+ (int)repeatCharCount:(NSString *)string
{
    NSString *tempStr = nil;
    int count = 0;
    for (int i = 0; i < [string length]; i++)
    {
        tempStr = [string substringWithRange:NSMakeRange(i, 1)];
        if ([tempStr isEqual:@"\r"])
        {
            count++;
        }
        if (i >= count)
        {
            break;
        }
    }
    return count;
}

+ (int)allSpaceCount:(NSString *)string
{
    NSString *tempStr = nil;
    int count = 0;
    for (int i = 0; i < [string length]; i++)
    {
        tempStr = [string substringWithRange:NSMakeRange(i, 1)];
        if ([tempStr isEqual:@" "])
        {
            count++;
        }
        if (i >= count)
        {
            break;
        }
    }
    return count;
}

+ (int)repeatSpaceAndCharCount:(NSString *)string
{
    NSString *tempStr = nil;
    int count = 0;
    for (int i = 0; i < [string length]; i++)
    {
        tempStr = [string substringWithRange:NSMakeRange(i, 1)];
        if ([tempStr isEqual:@" "] || [tempStr isEqual:@"\r"] || [tempStr isEqual:@"\n"])
        {
            count++;
        }
        if (i >= count)
        {
            break;
        }
    }
    return count;
}

// end
@end
