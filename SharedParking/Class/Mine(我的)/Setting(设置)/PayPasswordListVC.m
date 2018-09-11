//
//  PayPasswordListVC.m
//  SharedParking
//
//  Created by 尉超 on 2018/1/12.
//  Copyright © 2018年 galaxy. All rights reserved.
//

#import "PayPasswordListVC.h"

@interface PayPasswordListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tbView;

@end

@implementation PayPasswordListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView{
    self.title = @"支付密码";
    
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
    
    
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"修改支付密码";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
            break;
        case 1:
        {
            cell.textLabel.text = @"忘记支付密码";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.row) {
        case 0:
        {
            [WSProgressHUD showImage:nil status:@"敬请期待"];
        }
            break;
        case 1:
        {
            [WSProgressHUD showImage:nil status:@"敬请期待"];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
