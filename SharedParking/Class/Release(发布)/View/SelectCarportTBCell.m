//
//  SelectCarportTBCell.m
//  SharedParking
//
//  Created by galaxy on 2017/12/11.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "SelectCarportTBCell.h"
@interface SelectCarportTBCell ()
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *addressLab;
@end

@implementation SelectCarportTBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
        
    }
    return self;
}

- (void)setModel:(ReleaseModel *)model{
    _model = model;
    
    self.titleLab.text = model.park_title;
    self.addressLab.text = model.park_address;
    
}


- (void)initView{
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.addressLab];
}

#pragma mark ---------------lazy ---------------------/

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSize16;
        _titleLab.textColor = kColor333333;
        _titleLab.frame = CGRectMake(kMargin15, kMargin15, kScreenWidth - kMargin15 * 2, 20);
    }
    return _titleLab;
}

- (UILabel *)addressLab{
    if (!_addressLab) {
        _addressLab = [[UILabel alloc]init];
        _addressLab.font = kFontSize12;
        _addressLab.textColor = kColor6B6B6B;
        _addressLab.frame = CGRectMake(kMargin15, self.titleLab.bottom + 5, self.titleLab.width, 15);
    }
    return _addressLab;
}

@end
