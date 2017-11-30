//
//  SettingVC.m
//  SharedParking
//
//  Created by galaxy on 2017/10/26.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "SettingVC.h"

@interface SettingVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tbView;
@property (nonatomic , strong) NSArray *firstArr;
@property (nonatomic , strong) NSArray *secondArr;

@property (nonatomic , strong) UIView *exitView;
@property (nonatomic,strong)UILabel *cacheLab;

@end

@implementation SettingVC


#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView{
    self.title = @"设置";
    self.view.backgroundColor = kBackGroundGrayColor;
    self.firstArr = @[@"账号与安全",@"租用须知"];
    self.secondArr = @[@"意见反馈",@"软件关于",@"联系客服",@"去评价",@"版本"];
    [self.view addSubview:self.tbView];
}

#pragma mark ---------------NetWork-------------------------/
- (void)logoutAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定退出登录?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self didLogoutLogin];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didLogoutLogin{
    kSelfWeak;
    self.view.userInteractionEnabled = NO;
    self.fd_interactivePopDisabled = YES;
    [WSProgressHUD show];
    [GetDataManager logOutSuccessBlock:^{
        kSelfStrong;
        //退出登陆，不再发送统计信息
        [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccessNotification object:nil];
//        [MobClick profileSignOff];
        [strongSelf backToSuperView];
        [WSProgressHUD dismiss];
        strongSelf.fd_interactivePopDisabled = NO;
        
    } fail:^{
        kSelfStrong;
        strongSelf.view.userInteractionEnabled = YES;
        [WSProgressHUD showImage:nil status:@"退出失败"];
        strongSelf.fd_interactivePopDisabled = NO;
    }];
}

#pragma mark ---------------Event-------------------------/
- (void)contactService{
    
    dispatch_after(0.2, dispatch_get_main_queue(), ^{
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"0571-87787371"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    });
}

- (void)goToComment{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1261795228&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
    
}

#pragma mark - 清理缓存文件
- (void)clearData{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定要清除缓存文件吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //缓存文件的位置
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        [self clearCacheAtPath:cachPath];
    }];
    
    [alertVC addAction:cancleAction];
    [alertVC addAction:sureAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

-(void) clearCacheAtPath:(NSString *)path{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            //删除文件
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    
    [self performSelectorOnMainThread:@selector(clearCachSuccess) withObject:nil waitUntilDone:YES];
}

-(void)clearCachSuccess{
    
    [WSProgressHUD showImage:nil status:@"清除成功"];
    [self.tbView reloadData];
}

#pragma mark - 计算单个文件的大小
-(long long) fileSizeAtPath:(NSString*)filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

#pragma mark - 计算文件夹文件大小
-(CGFloat) getCacheSizeAtPath:(NSString*)folderPath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];//从前向后枚举器
    
    NSString* fileName;
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        //        DLog(@"fileName ==== %@",fileName);
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        //        DLog(@"fileAbsolutePath ==== %@",fileAbsolutePath);
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    
    DLog(@"folderSize ==== %lld",folderSize);
    
    return folderSize/(1024.0*1024.0);
}

#pragma mark -------------tableView--delegate-------------/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.firstArr.count;
    }
    
    return self.secondArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = kFontSize16;
    cell.textLabel.textColor = kColor333333;
    
    UILabel *rightLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 110, 0, 80, 50)];
    rightLab.font = kFontSize15;
    rightLab.textAlignment = NSTextAlignmentRight;
    rightLab.textColor = kColorDarkgray;
    rightLab.hidden = YES;
    [cell addSubview:rightLab];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.firstArr[indexPath.row];
    }else{
        cell.textLabel.text = self.secondArr[indexPath.row];
    }
    

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

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
        
        if (@available(iOS 9.0, *)) {
            _tbView.cellLayoutMarginsFollowReadableWidth = NO;
        }
        
        _tbView.tableFooterView = self.exitView;
        [_tbView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tbView;
}

- (UIView *)exitView{
    if (!_exitView) {
        _exitView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        _exitView.backgroundColor = kColorClear;
        
        UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        exitBtn.frame = CGRectMake(0, 30, kScreenWidth, 43);
        [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [exitBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        exitBtn.backgroundColor = kColorWhite;
        exitBtn.titleLabel.font = kFontSize15;
        [exitBtn addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
        [_exitView addSubview:exitBtn];
    }
    return _exitView;
}



@end
