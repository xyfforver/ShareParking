//
//  ParkingSpaceTBView.m
//  SharedParking
//
//  Created by galaxy on 2017/10/28.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ParkingSpaceTBView.h"
#import "ParkingSpaceTBCell.h"
@interface ParkingSpaceTBView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ParkingSpaceTBView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    [self registerClass:[ParkingSpaceTBCell class] forCellReuseIdentifier:@"ParkingSpaceTBCell"];
    self.delegate = self;
    self.dataSource = self;
    self.tableFooterView = [UIView new];
    self.separatorColor = kBackGroundGrayColor;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark -------------tableView--delegate-------------/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 113;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ParkingSpaceTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ParkingSpaceTBCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}





@end
