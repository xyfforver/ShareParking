//
//  UIView+BlockGesture.m
//  EasyGo
//
//  Created by ZZH on 16/3/24.
//  Copyright © 2016年 Ju. All rights reserved.
//

#import "UIView+BlockGesture.h"
#import <objc/runtime.h>

static char *kTapActionBlockKey;
static char *kLongPressActionBlockKey;

@implementation UIView (BlockGesture)

- (void)zzh_addTapGestureWithBlock:(GestureActionBlock)tapBlock
{
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlerTapAction:)]];
    self.userInteractionEnabled = YES;
    if (tapBlock) {
        objc_setAssociatedObject(self, &kTapActionBlockKey, tapBlock, OBJC_ASSOCIATION_COPY);
    }
}

- (void)handlerTapAction:(UIGestureRecognizer *)gestureRecoginzer
{
    GestureActionBlock tapActionBlock = objc_getAssociatedObject(self, &kTapActionBlockKey);
    if (tapActionBlock) {
        tapActionBlock(gestureRecoginzer);
    }
}

- (void)zzh_addLongPressWithBlock:(GestureActionBlock)longPressBlock
{
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlerLongPressAction:)]];
    if (longPressBlock) {
        objc_setAssociatedObject(self, &kLongPressActionBlockKey, longPressBlock, OBJC_ASSOCIATION_COPY);
    }
}

- (void)handlerLongPressAction:(UIGestureRecognizer *)gestureRecoginzer
{
    GestureActionBlock longPressActionBlock = objc_getAssociatedObject(self, &kLongPressActionBlockKey);
    if (longPressActionBlock) {
        longPressActionBlock(gestureRecoginzer);
    }
}

@end
