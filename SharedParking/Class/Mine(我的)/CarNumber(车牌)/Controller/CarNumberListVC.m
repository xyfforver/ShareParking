//
//  CarNumberListVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/16.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarNumberListVC.h"
#import "CarNumberAddVC.h"
#import "CarNumberListTBCell.h"
@interface CarNumberListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) BaseTBView *tbView;

@end

@implementation CarNumberListVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];

}

- (void)initView{
    
    self.title = @"车牌管理";
    self.navigationItem.rightBarButtonItem = [[self class] rightBarButtonWithName:@"添加车牌" imageName:nil target:self action:@selector(addAction:)];
    
    [self.view addSubview:self.tbView];
}

#pragma mark ---------------NetWork-------------------------/


#pragma mark ---------------Event-------------------------/
- (void)addAction:(UIButton *)button{
    CarNumberAddVC *vc = [[CarNumberAddVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -------------tableView--delegate-------------/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CarNumberListTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarNumberListTBCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark ---------------Lazy-------------------------/
- (BaseTBView *)tbView{
    if(!_tbView){
        _tbView = [[BaseTBView alloc]initWithFrame:kScreenRect style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.rowHeight = 175;
        
        _tbView.separatorColor = kBackGroundGrayColor;
        _tbView.backgroundColor = kBackGroundGrayColor;
        
        [_tbView registerClass:[CarNumberListTBCell class] forCellReuseIdentifier:@"CarNumberListTBCell"];
    }
    return _tbView;
}

@end
