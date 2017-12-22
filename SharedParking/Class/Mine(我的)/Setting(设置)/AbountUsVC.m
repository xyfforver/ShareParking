//
//  AbountUsVC.m
//  SharedParking
//
//  Created by galaxy on 2017/12/22.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "AbountUsVC.h"

@interface AbountUsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tbView;

@end

@implementation AbountUsVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];

}

- (void)initView{
    self.title = @"关于我们";
    
    [self.view addSubview:self.tbView];
    
    
}

#pragma mark ---------------NetWork-------------------------/


#pragma mark ---------------Event-------------------------/


#pragma mark -------------tableView--delegate-------------/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = kFontSize16;
    cell.textLabel.textColor = kColor333333;
    
    UILabel *rightLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 120, 0, 100, 50)];
    rightLab.font = kFontSize15;
    rightLab.textAlignment = NSTextAlignmentRight;
    rightLab.textColor = kColorDarkgray;
    rightLab.hidden = YES;
    [cell addSubview:rightLab];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"软件关于";
        

    }else{
        cell.textLabel.text = @"版本";
        //当前版本
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        // app版本
        NSString *current = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        rightLab.text = [NSString stringWithFormat:@"%@",current];
        rightLab.hidden = NO;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {

    }
}

#pragma mark ---------------Lazy-------------------------/

- (UITableView *)tbView{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:kScreenRect style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.showsVerticalScrollIndicator = NO;
        _tbView.rowHeight = 52;
        _tbView.backgroundColor = kBackGroundGrayColor;
        _tbView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tbView.estimatedRowHeight = 0;
        _tbView.estimatedSectionHeaderHeight = 0;
        _tbView.estimatedSectionFooterHeight = 0;
        _tbView.tableFooterView = [UIView new];
        _tbView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        
        if (@available(iOS 9.0, *)) {
            _tbView.cellLayoutMarginsFollowReadableWidth = NO;
        }
        
        [_tbView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tbView;
}

@end
