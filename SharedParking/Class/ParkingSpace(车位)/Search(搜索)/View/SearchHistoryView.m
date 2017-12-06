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
//    [self.historyData addObjectsFromArray:@[@"小龙虾", @"日本皮皮虾", @"蓝莓", @"美国进口蓝莓", @"意大利拉面", @"西瓜", @"苹果", @"牛肉牛肉牛肉牛肉牛肉牛肉牛肉牛肉", @"🐂", @"🍎", @"🍌",]];
    [self loadSearchHistoryData];

    [self addSubview:self.titleLab];
    [self addSubview:self.tagView];
    [self addSubview:self.clearBtn];

}

#pragma mark ---------------event ---------------------/

#pragma mark ---------------tagView-------------------------/
- (NSInteger)numOfItems {
    return self.historyData.count;
}

- (NSString *)tagView:(YJTagView *)tagView titleForItemAtIndex:(NSInteger)index {
    return self.historyData[index];
}

- (void)tagView:(YJTagView *)tagView didSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"点击%@", self.historyData[index]);
    
    if (self.selectBlock) {
        self.selectBlock(self.historyData[index]);
    }
}

- (void)tagView:(YJTagView *)tagView heightUpdated:(CGFloat)height{
    self.clearBtn.top = tagView.bottom + 50;
}



#pragma mark 本地搜索历史记录
/**
 *  本地搜索历史记录
 */
- (void)loadSearchHistoryData{
    
    NSArray *originData = [[NSUserDefaults standardUserDefaults] objectForKey:kGoodsHistroySearchData];
    
    if (originData.count > 0) {
        [self.historyData addObjectsFromArray:originData];
    }
    [self.tagView reloadData];
}
/**
 *  保存搜索记录
 */
- (void)saveHistoryKeyWord:(NSString *)keyword
{
    NSString *searchKey = [keyword stringByStrippingWhitespace];
    if ([searchKey isBlank]) return;
    if ([self.historyData containsObject:searchKey]) {
        [self.historyData removeObject:searchKey];
        [self.historyData insertObject:searchKey atIndex:0];
    } else {
        [self.historyData insertObject:searchKey atIndex:0];
    }
    //只保存十条
    if (self.historyData.count > 12) {
        [self.historyData removeLastObject];
    }
    
    
    [[NSUserDefaults standardUserDefaults]setObject:self.historyData forKey:kGoodsHistroySearchData];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self.tagView reloadData];
    
}
/**
 *  清除搜索记录
 */
- (void)deleteHistoryData
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您要清除搜索记录么？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.historyData removeAllObjects];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.historyData forKey:kGoodsHistroySearchData];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.tagView reloadData];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    [self.Controller presentViewController:alertController animated:YES completion:NULL];
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
        _tagView = [[YJTagView alloc] initWithFrame:CGRectMake(kMargin15, self.titleLab.bottom + 20, kScreenWidth - kMargin15 * 2, 0)];
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
        [_clearBtn addTarget:self action:@selector(deleteHistoryData) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _clearBtn;
}

@end
