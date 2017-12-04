//
//  ParkingSpaceTBCell.h
//  SharedParking
//
//  Created by galaxy on 2017/10/28.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarportShortListModel.h"
#import "CarportLongListModel.h"
@interface ParkingSpaceTBCell : UITableViewCell

@property (nonatomic , strong) CarportShortListModel *shortModel;
@property (nonatomic , strong) CarportLongListModel *longModel;
@end
