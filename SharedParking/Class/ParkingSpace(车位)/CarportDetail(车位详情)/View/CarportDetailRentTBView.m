//
//  CarportDetailRentTBView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/24.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportDetailRentTBView.h"
#import "CarportDetailRentTBCell.h"
@interface CarportDetailRentTBView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) NSArray *titleArr;
@end

@implementation CarportDetailRentTBView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSelectionStyleNone;
    self.rowHeight = 50;
    
    self.titleArr = @[@"地址：",@"停车时间：",@"出租对象：",@"租用须知："];
    [self registerClass:[CarportDetailRentTBCell class] forCellReuseIdentifier:@"CarportDetailRentTBCell"];
    
}

#pragma mark ---------------event ---------------------/
- (void)telAction:(UIButton *)button{
    if ([NSString isNull:self.longModel.user_mobile]) {
        [WSProgressHUD showImage:nil status:@"商家联系方式被吞了"];
        return;
    }
    dispatch_after(0.2, dispatch_get_main_queue(), ^{
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.longModel.user_mobile];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    });
    
}

#pragma mark -------------tableView--delegate-------------/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CarportDetailRentTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarportDetailRentTBCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.subLab.textColor = kColor6B6B6B;
    cell.titleLab.text = self.titleArr[indexPath.row];
    if (indexPath.row == 0) {
        cell.subLab.text = self.longModel.park_address;
    }else if (indexPath.row == 1){
        cell.subLab.text = [NSString stringWithFormat:@"%@-%@",self.longModel.park_opentime,self.longModel.park_closetime];
    }else if (indexPath.row == 2){
        cell.subLab.text = self.longModel.parking_obj ? @"仅限本小区业主" : @"不限";
    }else{
        cell.subLab.text = @"查看";
        cell.subLab.textColor = kColorDD9900;
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 210;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]init];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin15, 20, 100, 20)];
    titleLab.text = @"描述：";
    titleLab.textColor = kColor333333;
    titleLab.font = kFontSize15;
    [footerView addSubview:titleLab];
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(kMargin15, titleLab.bottom + kMargin10, kScreenWidth - kMargin15 * 2, 90)];
    textView.textColor = kColor6B6B6B;
    textView.text = self.longModel.remark;
    textView.font = kFontSize14;
    textView.layer.cornerRadius = 3;
    textView.layer.masksToBounds = YES;
    textView.layer.borderColor = kBackGroundGrayColor.CGColor;
    textView.layer.borderWidth = 1.0;
    textView.userInteractionEnabled = YES;
    [footerView addSubview:textView];
    
    UIButton *telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [telBtn setTitle:@"电话联系" forState:UIControlStateNormal];
    telBtn.backgroundColor = kNavBarColor;
    telBtn.titleLabel.font = kFontSize15;
    telBtn.layer.cornerRadius = 20;
    telBtn.layer.masksToBounds = YES;
    telBtn.frame = CGRectMake((kScreenWidth - 180)/2.0, textView.bottom + kMargin15, 180, 40);
    [telBtn addTarget:self action:@selector(telAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:telBtn];

    return footerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        DLog(@"跳转");
    }
}

#pragma mark -----------------Lazy---------------------/



@end
