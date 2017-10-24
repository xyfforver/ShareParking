//
//  NSString+String.m
//  EasyGo
//
//  Created by 徐佳琦 on 16/4/19.
//  Copyright © 2016年 Ju. All rights reserved.
//

#import "NSString+String.h"
#import <CommonCrypto/CommonCrypto.h>

#define FileHashDefaultChunkSizeForReadingData 1024*8 

@implementation NSString (String)

+ (BOOL)isNull:(id)obj
{
    BOOL result = NO;
    
    if ([obj isEqual:[NSNull null]] || obj == nil) {
        return YES;
    }
    
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)obj;
        if (!string || [string isEqualToString:@""] || 0 == string.length) {
            result = YES;
        } else if ([string isEqualToString:@"null"]) {
            result = YES;
        }
    }
    
    return result;
}

-(BOOL)isBlank
{
    if([[self stringByStrippingWhitespace] length] == 0)
    {
        return YES;
    }
    
    return NO;
}

-(NSString *)stringByStrippingWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString*) uniqueString
{
    CFUUIDRef	uuidObj = CFUUIDCreate(nil);
    NSString	*uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString;
}

- (NSString*) urlEncodedString {
    
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (__bridge CFStringRef) self,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                                                          kCFStringEncodingUTF8);
    
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) encodedCFString];
    
    if(!encodedString)
        encodedString = @"";
    
    return encodedString;
}

- (NSString*) urlDecodedString {
    
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef) self,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    
    // We need to replace "+" with " " because the CF method above doesn't do it
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) decodedCFString];
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}

+(NSString*)getFileMD5WithPath:(NSString*)path

{
    
    return (__bridge_transfer NSString *)FileMD5HashCreateWithPath((__bridge CFStringRef)path, FileHashDefaultChunkSizeForReadingData);
    
}

CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath,size_t chunkSizeForReadingData) {
    
    // Declare needed variables
    
    CFStringRef result = NULL;
    
    CFReadStreamRef readStream = NULL;
    
    // Get the file URL
    
    CFURLRef fileURL =
    
    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                  
                                  (CFStringRef)filePath,
                                  
                                  kCFURLPOSIXPathStyle,
                                  
                                  (Boolean)false);
    
    if (!fileURL) goto done;
    
    // Create and open the read stream
    
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,
                                            
                                            (CFURLRef)fileURL);
    
    if (!readStream) goto done;
    
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    
    if (!didSucceed) goto done;
    
    // Initialize the hash object
    
    CC_MD5_CTX hashObject;
    
    CC_MD5_Init(&hashObject);
    
    // Make sure chunkSizeForReadingData is valid
    
    if (!chunkSizeForReadingData) {
        
        chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
        
    }
    
    // Feed the data to the hash object
    
    bool hasMoreData = true;
    
    while (hasMoreData) {
        
        uint8_t buffer[chunkSizeForReadingData];
        
        CFIndex readBytesCount = CFReadStreamRead(readStream,(UInt8 *)buffer,(CFIndex)sizeof(buffer));
        
        if (readBytesCount == -1) break;
        
        if (readBytesCount == 0) {
            
            hasMoreData = false;
            
            continue;
            
        }
        
        CC_MD5_Update(&hashObject,(const void *)buffer,(CC_LONG)readBytesCount);
        
    }
    
    // Check if the read operation succeeded
    
    didSucceed = !hasMoreData;
    
    // Compute the hash digest
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5_Final(digest, &hashObject);
    
    // Abort if the read operation failed
    
    if (!didSucceed) goto done;
    
    // Compute the string result
    
    char hash[2 * sizeof(digest) + 1];
    
    for (size_t i = 0; i < sizeof(digest); ++i) {
        
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
        
    }
    
    result = CFStringCreateWithCString(kCFAllocatorDefault,(const char *)hash,kCFStringEncodingUTF8);
    
done:
    
    if (readStream) {
        
        CFReadStreamClose(readStream);
        
        CFRelease(readStream);
        
    }
    
    if (fileURL) {
        
        CFRelease(fileURL);
        
    }
    
    return result;
    
}

- (NSString *)stringToMD5
{
    
    //1.首先将字符串转换成UTF-8编码, 因为MD5加密是基于C语言的,所以要先把字符串转化成C语言的字符串
    const char *fooData = [self UTF8String];
    
    //2.然后创建一个字符串数组,接收MD5的值
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    //3.计算MD5的值, 这是官方封装好的加密方法:把我们输入的字符串转换成16进制的32位数,然后存储到result中
    CC_MD5(fooData, (CC_LONG)strlen(fooData), result);
    /**
     第一个参数:要加密的字符串
     第二个参数: 获取要加密字符串的长度
     第三个参数: 接收结果的数组
     */
    
    //4.创建一个字符串保存加密结果
    NSMutableString *saveResult = [NSMutableString string];
    
    //5.从result 数组中获取加密结果并放到 saveResult中
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%02x", result[i]];
    }
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
    return saveResult;
}

+ (NSString *)calculateTimeWithTimeFormatter:(long long)timeSecond {
    NSString * theLastTime = nil;
    if (timeSecond < 60) {
        theLastTime = [NSString stringWithFormat:@"00:%.2lld", timeSecond];
    }else if(timeSecond >= 60 && timeSecond < 3600){
        theLastTime = [NSString stringWithFormat:@"%.2lld:%.2lld", timeSecond/60, timeSecond%60];
    }else if(timeSecond >= 3600){
        theLastTime = [NSString stringWithFormat:@"%.2lld:%.2lld:%.2lld", timeSecond/3600, timeSecond%3600/60, timeSecond%60];
    }
    return theLastTime;
}


@end
