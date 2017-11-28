//
//  ReleaseVC.m
//  SharedParking
//
//  Created by galaxy on 2017/10/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ReleaseVC.h"
#import "JMTitleSelectView.h"
#import "ReleaseDetailView.h"
@interface ReleaseVC ()
@property (nonatomic , strong) JMTitleSelectView *titleView;
@property (nonatomic , strong) ReleaseDetailView *detailView;

@end

@implementation ReleaseVC
#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
}

- (void)initView{
    
    self.navigationItem.titleView = self.titleView;
    [self.view addSubview:self.detailView];

}

- (JMTitleSelectView *)titleView{
    if (!_titleView) {
        _titleView = [[JMTitleSelectView alloc]init];
    }
    return _titleView;
}

- (ReleaseDetailView *)detailView{
    if (!_detailView) {
        _detailView = [[[NSBundle mainBundle] loadNibNamed:@"ReleaseDetailView" owner:nil options:nil] lastObject];
        _detailView.frame = self.view.bounds;
    }
    return _detailView;
}
@end
