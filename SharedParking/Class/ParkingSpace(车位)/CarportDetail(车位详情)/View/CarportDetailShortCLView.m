//
//  CarportDetailShortCLView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportDetailShortCLView.h"
#import "CarportDetailShortCLCell.h"
#import "CarportDetailShortHeadView.h"

#import "CarportReserveVC.h"

#import "CarportShortItemModel.h"
@interface CarportDetailShortCLView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation CarportDetailShortCLView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = kColorWhite;
    
    [self registerClass:[CarportDetailShortCLCell class] forCellWithReuseIdentifier:@"CarportDetailShortCLCell"];
    [self registerClass:[CarportDetailShortHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CarportDetailShortHeadView"];
    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
    
}

#pragma mark ------------collectionView delegate ------------------/
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 2;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shortModel.parkinglist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CarportDetailShortCLCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CarportDetailShortCLCell" forIndexPath:indexPath];
    
    CarportShortItemModel *itemModel = self.shortModel.parkinglist[indexPath.row];
    cell.titleLab.text = itemModel.parking_number;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            
            CarportDetailShortHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CarportDetailShortHeadView" forIndexPath:indexPath];
            headView.shortModel = self.shortModel;
            
            view = headView;
        }
    }
    
    return view;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(kScreenWidth, 65);
    }
    return CGSizeZero;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CarportShortItemModel *itemModel = self.shortModel.parkinglist[indexPath.row];
    
    CarportReserveVC *vc = [[CarportReserveVC alloc]initWithParkingId:itemModel.id];
    [self.Controller.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark ---------------event ---------------------/

#pragma mark -----------------Lazy---------------------/



@end
