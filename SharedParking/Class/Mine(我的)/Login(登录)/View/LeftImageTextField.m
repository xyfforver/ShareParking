//
//  ServiceTextField.m
//  ZQB
//
//  Created by YangXu on 14-7-22.
//
//

#import "LeftImageTextField.h"

@implementation LeftImageTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 40, self.height)];
        leftView.backgroundColor = kColorClear;
        
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, leftView.width, leftView.height)];
        _leftImageView.contentMode = UIViewContentModeCenter;
        [leftView addSubview:_leftImageView];
        
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

@end
