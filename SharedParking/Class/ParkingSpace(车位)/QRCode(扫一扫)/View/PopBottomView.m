//
//  PopBottomView.m
//  lyx
//
//  Created by apple on 2017/10/25.
//  Copyright © 2017年 seeday. All rights reserved.
//

#import "PopBottomView.h"
#import "PopBottomCell.h"

@implementation PopBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        
        //
        self.view_bg = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 275, kScreenWidth, 275)];
        self.view_bg.backgroundColor = [UIColor whiteColor];
        self.view_bg.alpha = 0.0;
        [self addSubview:self.view_bg];
        //
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 275)];
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 55;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view_bg addSubview:self.tableView];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBgAction:)];
        tap.cancelsTouchesInView = NO;
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

-(void)setData:(NSArray *)data{
    if (data.count > 0) {
        
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        [arr addObjectsFromArray:data];
        CarportShortItemModel *cancelModel = [[CarportShortItemModel alloc]init];
        cancelModel.parking_number = @"取消选择";
        cancelModel.id = 0;
        [arr addObject:cancelModel];
        data = arr;

        _data = data;
        CGFloat height_ = _data.count * 55;
        
        CGRect rect_bg = self.view_bg.frame;
        rect_bg.size.height = height_;
        rect_bg.origin.y = kScreenHeight - height_;
        [self.view_bg setFrame: rect_bg];
        
        CGRect rect_tb = self.tableView.frame;
        rect_tb.size.height = height_;
        [self.tableView setFrame: rect_tb];
        
        [self.tableView reloadData];
        
    }
}


#pragma mark----tableView Delegate or dataSource------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"cellIdentify";
    PopBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[PopBottomCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentify];
    }
    
    if (indexPath.row == self.data.count -1) {
        cell.lab_title.textColor = self.cancelColor?self.cancelColor:kColor333333;
    }else{
        cell.lab_title.textColor = kColor333333;
    }
    //
    CarportShortItemModel *model = _data[indexPath.row];
    cell.lab_title.text = model.parking_number;
    //
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == _data.count - 1) {
        [self removeOperateView];
    }else{
        self.blockCallBackIndex(_data[indexPath.row]);
        [self removeOperateView];
    }
}


-(void)viewShow{
    //
    if(!self.superview){
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows){
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            BOOL windowHasSubviews = window.subviews.count != 0;
            if (windowOnMainScreen && windowIsVisible && windowLevelNormal && windowHasSubviews) {
                [window addSubview:self];
                break;
            }
        }
    } else {
        [self.superview bringSubviewToFront:self];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.5;
        self.view_bg.alpha = 1;
    } completion:^(BOOL finished) {

    }];
    //
}


-(void)removeOperateView{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0;
        self.view_bg.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.view_bg removeFromSuperview];
    }];
}


#pragma mark-----action-------
-(void)tapBgAction:(UITapGestureRecognizer *)tap{
    CGPoint tapPointInBgView = [tap locationInView:self];
    CGRect collectionViewRect = self.view_bg.frame;
    
    if (!CGRectContainsPoint(collectionViewRect, tapPointInBgView)) {
        [self removeOperateView];
    }
}


@end
