//
//  ParkingRecordVC.m
//  SharedParking
//
//  Created by galaxy on 2017/10/26.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ParkingRecordVC.h"
#import "BaseTBView.h"
#import "ParkingRecordTBCell.h"
@interface ParkingRecordVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) BaseTBView *tbView;


@end

@implementation ParkingRecordVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];

}

- (void)initView{
    self.title = @"停车记录";
    self.view.backgroundColor = kBackGroundGrayColor;
    
    [self.view addSubview:self.tbView];
}

#pragma mark ---------------NetWork-------------------------/


#pragma mark ---------------Event-------------------------/


#pragma mark -------------tableView--delegate-------------/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ParkingRecordTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ParkingRecordTBCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark ---------------Lazy-------------------------/

- (BaseTBView *)tbView{
    if (!_tbView) {
        _tbView = [[BaseTBView alloc]initWithFrame:kScreenRect style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.showsVerticalScrollIndicator = NO;
        _tbView.rowHeight = 120;
        _tbView.backgroundColor = kBackGroundGrayColor;
        _tbView.separatorColor = kColorClear;
        _tbView.tableFooterView = [UIView new];
        _tbView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 15)];
        
        if (@available(iOS 9.0, *)) {
            _tbView.cellLayoutMarginsFollowReadableWidth = NO;
        }

        [_tbView registerClass:[ParkingRecordTBCell class] forCellReuseIdentifier:@"ParkingRecordTBCell"];
    }
    return _tbView;
}
@end
