//
//  AccountSecurityVC.m
//  SharedParking
//
//  Created by galaxy on 2017/12/16.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "AccountSecurityVC.h"
#import "PayPasswordListVC.h"

@interface AccountSecurityVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tbView;
@end

@implementation AccountSecurityVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];

}

- (void)initView{
    self.title = @"账号与安全";
    
    [self.view addSubview:self.tbView];
    

}

#pragma mark ---------------NetWork-------------------------/


#pragma mark ---------------Event-------------------------/


#pragma mark -------------tableView--delegate-------------/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
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
    
//    if (indexPath.row == 0) {
//        cell.textLabel.text = @"更改手机号";
//        rightLab.hidden = NO;
//        NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:kLingBaoUser];
//        rightLab.text = phone;
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }else{
//        cell.textLabel.text = @"修改密码";
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
    switch (indexPath.row) {
        case 0:
            {
                cell.textLabel.text = @"更改手机号";
                rightLab.hidden = NO;
                NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:kLingBaoUser];
                rightLab.text = phone;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            break;
        case 1:
        {
            cell.textLabel.text = @"修改密码";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"支付密码";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        LoginVC *vc = [[LoginVC alloc]initWithType:1 completionBack:^{
//
//        }];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    switch (indexPath.row) {
        case 0:
            {
                LoginVC *vc = [[LoginVC alloc]initWithType:1 completionBack:^{
                    
                }];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case 1:
        {
            [WSProgressHUD showImage:nil status:@"敬请期待"];
        }
            break;
        case 2:
        {
         
            PayPasswordListVC *listVC = [PayPasswordListVC new];
            [self.navigationController pushViewController:listVC animated:YES];
        }
            break;
            
        default:
            break;
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
