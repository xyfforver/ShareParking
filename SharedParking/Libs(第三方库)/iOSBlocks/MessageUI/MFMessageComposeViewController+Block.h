//
//  MFMessageComposeViewController+Block.h
//  iOS Blocks
//
//  Created by Ignacio Romero Zurbuchen on 12/11/12.
//  Copyright (c) 2013 DZEN. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "iOSBlocksProtocol.h"

#pragma GCC diagnostic ignored "-wall"

/*
 * MessageUI MessageComposeViewController Delegate block methods.
 * @warning Unfortunately , it doesn't work on the simulator.
 */
@interface MFMessageComposeViewController (Block) <MFMessageComposeViewControllerDelegate, iOSBlocksProtocol>

/*
 * Prepares a MessageComposeViewController to be presented with a body message and recipients, and with update blocks to notify when the user finishes by either sending or cancelling the message
 * If this is used on iPad, the MessageComposeViewController will be presented modaly with presentation styled on UIModalPresentationFormSheet.
 *
 * @param body The initial content of the message.
 * @param recipients An array of strings containing the initial recipients of the message.
 * @param creation A block object to be executed when the MessageComposeViewController has been created and is ready to be presented. Returns a configured MessageComposeViewController object.
 * @param finished A block object to be finished when the user wants to dismiss the mail composition view. Returns the configured MessageComposeViewController object.
 */
+ (void)messageWithBody:(NSString *)body
             recipients:(NSArray *)recipients
             onCreation:(iBComposeCreatedBlock)creation
               onFinish:(iBComposeFinishedBlock)finished;

@end
