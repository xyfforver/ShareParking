//
//  NSURLConnection+Block.m
//  iOS Blocks
//
//  Created by Ignacio Romero Zurbuchen on 1/11/13.
//  Copyright (c) 2013 DZEN. All rights reserved.
//

#import "NSURLConnection+Block.h"

static iBProgressBlock _progressBlock;
static iBDataBlock _dataBlock;
static iBSuccessBlock _successBlock;
static iBFailureBlock _failureBlock;

@implementation NSURLConnection (Blocks)

+ (NSURLConnection *)sendAsynchronousRequest:(NSURLRequest *)request
                           didUpdateProgress:(iBProgressBlock)progress
                              didReceiveData:(iBDataBlock)data
                          didReceiveResponse:(iBSuccessBlock)success
                            didFailWithError:(iBFailureBlock)fail
{
    _progressBlock = [progress copy];
    _dataBlock = [data copy];
    _successBlock = [success copy];
    _failureBlock = [fail copy];
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];

    return connection;
}

+ (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
    
    if (_successBlock) {
        _successBlock(HTTPResponse);
    }
}

+ (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (_dataBlock) {
        _dataBlock(data);
    }
}

+ (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    NSInteger progress = (totalBytesWritten*100)/totalBytesExpectedToWrite;
    
    if (_progressBlock) {
        _progressBlock(progress);
    }
}

+ (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_failureBlock) {
        _failureBlock(error);
    }
}

@end
