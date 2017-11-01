//
//  SearchHistoryView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/1.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "SearchHistoryView.h"
#import "YJTagView.h"
@interface SearchHistoryView ()<YJTagViewDelegate, YJTagViewDataSource>
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) YJTagView *tagView;
@property (nonatomic,strong) UIButton *clearBtn;
@end

@implementation SearchHistoryView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    [self.historyData addObjectsFromArray:@[@"小龙虾", @"日本皮皮虾", @"蓝莓", @"美国进口蓝莓", @"意大利拉面", @"西瓜", @"苹果", @"牛肉牛肉牛肉牛肉牛肉牛肉牛肉牛肉", @"🐂", @"🍎", @"🍌",]];
    

    [self addSubview:self.titleLab];
    [self addSubview:self.tagView];
    [self addSubview:self.clearBtn];

}

#pragma mark ---------------event ---------------------/
- (void)clearAction:(UIButton *)button{
    
}

#pragma mark ---------------tagView-------------------------/
- (NSInteger)numOfItems {
    return self.historyData.count;
}

- (NSString *)tagView:(YJTagView *)tagView titleForItemAtIndex:(NSInteger)index {
    return self.historyData[index];
}

- (void)tagView:(YJTagView *)tagView didSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"点击%@", self.historyData[index]);
}

- (void)tagView:(YJTagView *)tagView heightUpdated:(CGFloat)height{
    self.clearBtn.top = tagView.bottom + 50;
}

#pragma mark -----------------Lazy---------------------/
- (NSMutableArray *)historyData{
    if (!_historyData) {
        _historyData = [NSMutableArray array];
    }
    return _historyData;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin15, kMargin15, 100, 20)];
        _titleLab.text = @"历史记录";
        _titleLab.font = kFontSize15;
        _titleLab.textColor = kColor333333;
    }
    return _titleLab;
}

- (YJTagView *)tagView{
    if (!_tagView) {
        _tagView = [[YJTagView alloc] initWithFrame:CGRectMake(kMargin15, _titleLab.bottom + 20, kScreenWidth - kMargin15 * 2, 0)];
        _tagView.dataSource = self;
        _tagView.delegate = self;
        _tagView.themeColor = kColor333333;
        _tagView.tagCornerRadius = 0;
        _tagView.cellHeight = 33;
    }
    return _tagView;
}

- (UIButton *)clearBtn{
    if (!_clearBtn) {
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearBtn.frame = CGRectMake(0, _tagView.bottom + 50, kScreenWidth, 40);
        [_clearBtn setTitle:@"清空记录" forState:UIControlStateNormal];
        [_clearBtn setImage:[UIImage imageNamed:@"search_clear"] forState:UIControlStateNormal];
        _clearBtn.titleLabel.font = kFontSize15;
        [_clearBtn lc_imageTitleHorizontalAlignmentWithSpace:5];
        [_clearBtn setTitleColor:kColor6B6B6B forState:UIControlStateNormal];
        [_clearBtn addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _clearBtn;
}

@end
