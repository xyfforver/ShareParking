//
//  PopBottomCell.m
//  lyx
//
//  Created by apple on 2017/10/25.
//  Copyright © 2017年 seeday. All rights reserved.
//

#import "PopBottomCell.h"

@implementation PopBottomCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.lab_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 55)];
        self.lab_title.font = [UIFont systemFontOfSize:15];
        self.lab_title.textColor = kColor333333;
        self.lab_title.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.lab_title];
        
        UIView *viewLine = [[UIView alloc]initWithFrame:CGRectMake(15, 55-0.5, kScreenWidth-15*2, 0.5)];
        viewLine.backgroundColor = kColorBackGroundColor;
        [self.contentView addSubview:viewLine];
        
        
    }
    return self;
}



@end
