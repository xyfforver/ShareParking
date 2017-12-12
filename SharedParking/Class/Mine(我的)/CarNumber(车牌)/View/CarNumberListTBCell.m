//
//  CarNumberListTBCell.m
//  SharedParking
//
//  Created by galaxy on 2017/11/16.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarNumberListTBCell.h"
#import "CarNumberAddVC.h"
@interface CarNumberListTBCell ()
@property (nonatomic , strong) UIView *infoBgView;
@property (nonatomic , strong) UILabel *carNumLab;
@property (nonatomic , strong) UILabel *endNumLab;

@property (nonatomic , strong) UIView *btnBgView;
@property (nonatomic , strong) UIButton *deleteBtn;
@property (nonatomic , strong) UIButton *editBtn;
@property (nonatomic , strong) UIView *lineView;
@end

@implementation CarNumberListTBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
        
    }
    return self;
}

- (void)setItemModel:(CarportShortItemModel *)itemModel{
    _itemModel = itemModel;
    
    self.carNumLab.text = itemModel.car_chepai;
    self.endNumLab.text = [NSString stringWithFormat:@"发动机尾号：%@",itemModel.car_fadongji];
}

- (void)deleteCarNumber{
    kSelfWeak;
    [CarportShortItemModel deleteCarNumberWithCarId:self.itemModel.id success:^(StatusModel *statusModel) {
        kSelfStrong;
        [WSProgressHUD showImage:nil status:statusModel.message];
        if (statusModel.flag == kFlagSuccess) {
            if (strongSelf.loadBlock) {
                strongSelf.loadBlock();
            }
        }
    }];
}

#pragma mark ---------------event ---------------------/
- (void)deleteAction:(UIButton *)button{
    [UIAlertView alertViewWithTitle:@"提示" message:@"确定要删除该车牌吗？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] onDismiss:^(int buttonIndex, NSString *buttonTitle) {
        [self deleteCarNumber];
    } onCancel:nil];
}

- (void)editAction:(UIButton *)button{
    kSelfWeak;
    CarNumberAddVC *vc = [[CarNumberAddVC alloc]initWithType:2];
    vc.carModel = self.itemModel;
    vc.loadBlock = ^{
        kSelfStrong;
        if (strongSelf.loadBlock) {
            strongSelf.loadBlock();
        }
    };
    [self.Controller.navigationController pushViewController:vc animated:YES];
}


#pragma mark ---------------init ---------------------/
- (void)initView{
    self.contentView.backgroundColor = kBackGroundGrayColor;
    
    [self.contentView addSubview:self.infoBgView];
    [self.infoBgView addSubview:self.carNumLab];
    [self.infoBgView addSubview:self.endNumLab];
    
    [self.contentView addSubview:self.btnBgView];
    [self.btnBgView addSubview:self.deleteBtn];
    [self.btnBgView addSubview:self.lineView];
    [self.btnBgView addSubview:self.editBtn];

    
    [self.btnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.right.mas_equalTo(-kMargin15);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.btnBgView.mas_width).multipliedBy(0.5);
    }];
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.mas_equalTo(self.deleteBtn);
        make.right.mas_equalTo(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kMargin15);
        make.left.mas_equalTo(self.deleteBtn.mas_right).offset(-1);
        make.width.mas_equalTo(1);
        make.centerY.mas_equalTo(self.btnBgView);
    }];

    [self.infoBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.btnBgView);
        make.top.mas_equalTo(kMargin10);
        make.bottom.mas_equalTo(self.deleteBtn.mas_top).offset(-5);
    }];
    
    [self.carNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.right.mas_equalTo(-kMargin15);
        make.top.mas_equalTo(32);
    }];
    
    [self.endNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.carNumLab);
        make.top.mas_equalTo(self.carNumLab.mas_bottom).offset(20);
    }];

    
}

#pragma mark ---------------lazy ---------------------/
- (UIView *)infoBgView{
    if (!_infoBgView) {
        _infoBgView = [[UIView alloc]init];
        _infoBgView.backgroundColor = kColorWhite;
        _infoBgView.layer.cornerRadius = 3;
        _infoBgView.layer.masksToBounds = YES;
    }
    return _infoBgView;
}

- (UILabel *)carNumLab{
    if (!_carNumLab) {
        _carNumLab = [[UILabel alloc]init];
        _carNumLab.font = kFontSizeBold18;
        _carNumLab.textColor = kColorDD9900;
        _carNumLab.textAlignment = NSTextAlignmentCenter;
    }
    return _carNumLab;
}

- (UILabel *)endNumLab{
    if (!_endNumLab) {
        _endNumLab = [[UILabel alloc]init];
        _endNumLab.font = kFontSize16;
        _endNumLab.textColor = kColorBlack;
        _endNumLab.textAlignment = NSTextAlignmentCenter;
    }
    return _endNumLab;
}

- (UIView *)btnBgView{
    if (!_btnBgView) {
        _btnBgView = [[UIView alloc]init];
        _btnBgView.backgroundColor = kColorWhite;
        _btnBgView.layer.cornerRadius = 3;
        _btnBgView.layer.masksToBounds = YES;
    }
    return _btnBgView;
}


- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = kFontSize15;
        [_deleteBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        _deleteBtn.backgroundColor = kColorWhite;
        [_deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (UIButton *)editBtn{
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        _editBtn.titleLabel.font = kFontSize15;
        [_editBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kColor6B6B6B;
    }
    return _lineView;
}


@end
