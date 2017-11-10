//
//  iOSBlocksProtocol.h
//  iOS Blocks
//
//  Created by Ignacio Romero Zurbuchen on 2/12/13.
//  Copyright (c) 2011 DZen Interaktiv.
//  Licence: MIT-Licence
//

#import <Foundation/Foundation.h>

/*
 * Generic block constants for free usage over different classes.
 */
@protocol iOSBlocksProtocol <NSObject>

typedef void (^iBVoidBlock)();
typedef void (^iBCompletionBlock)(BOOL completed);

typedef void (^iBDismissBlock)(int buttonIndex, NSString *buttonTitle);
typedef void (^iBPhotoPickedBlock)(UIImage *chosenImage);

typedef void (^iBComposeCreatedBlock)(UIViewController *controller);
typedef void (^iBComposeFinishedBlock)(UIViewController *controller, NSError *error);

typedef void (^iBProgressBlock)(NSInteger connectionProgress);
typedef void (^iBDataBlock)(NSData *data);
typedef void (^iBSuccessBlock)(NSHTTPURLResponse *HTTPResponse);
typedef void (^iBFailureBlock)(NSError *error);

typedef void (^iBRowPickedBlock)(NSString *title);

typedef void (^iBListBlock)(NSArray *list);

typedef void (^iBStatusBlock)(unsigned int status);

@end