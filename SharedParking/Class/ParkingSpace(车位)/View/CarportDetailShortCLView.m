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
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CarportDetailShortCLCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CarportDetailShortCLCell" forIndexPath:indexPath];
    cell.titleLab.text = [NSString stringWithFormat:@"%ld区%ld号",indexPath.section,indexPath.row];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            
            CarportDetailShortHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CarportDetailShortHeadView" forIndexPath:indexPath];
            
            view = headView;
        }else{
            UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
            
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
    return CGSizeMake(kScreenWidth, 15);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


#pragma mark ---------------event ---------------------/

#pragma mark -----------------Lazy---------------------/



@end
