//
//  MyRequestRentHeadView.h
//  SharedParking
//
//  Created by galaxy on 2017/11/9.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum :NSInteger {
    JMHeaderRequestRentType,//我的求租
    JMHeaderReserveParkingSpaceType,//我预订的车位

    
}JMHeaderType;
@interface MyRequestRentHeadView : UIView

- (instancetype)initWithType:(JMHeaderType)type frame:(CGRect)frame;

@property (nonatomic , assign) JMHeaderType type;

@property (nonatomic , copy) void(^reloadBlock)(void);

+ (CGFloat)getHeight;
@end
