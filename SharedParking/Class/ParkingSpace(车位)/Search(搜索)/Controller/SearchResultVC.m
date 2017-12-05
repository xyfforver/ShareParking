//
//  SearchResultVC.m
//  SharedParking
//
//  Created by galaxy on 2017/12/5.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "SearchResultVC.h"
#import "SearchModel.h"
@interface SearchResultVC ()


@property (nonatomic , assign) NSInteger page;
@end

@implementation SearchResultVC

#pragma mark ---------------LifeCycle-------------------------/
- (instancetype)initWithSearchStr:(NSString *)searchStr{
    self = [super init];
    if (self) {
        self.searchStr = searchStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self loadData];
}

- (void)initView{

}

#pragma mark ---------------NetWork-------------------------/
- (void)loadData{
    [SearchModel searchWithTitle:self.searchStr success:^(StatusModel *statusModel) {
        
    }];
}

#pragma mark ---------------Event-------------------------/


#pragma mark ---------------Lazy-------------------------/


@end
