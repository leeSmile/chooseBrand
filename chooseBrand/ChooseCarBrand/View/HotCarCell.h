//
//  HotCarCell.h
//  chooseBrand
//
//  Created by 祥云创想 on 16/7/5.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"

@class HotCarCell;

@protocol HotCarCellDelegate <NSObject>
- (void)tableViewCell:(HotCarCell *)tableViewCell didSelectBtnWithCarModel:(CarModel *)CarModel;
@end


@interface HotCarCell : UITableViewCell
@property(nonatomic, strong)NSMutableArray<CarModel *> *CarModelArr;
@property(nonatomic, strong)CarModel *CarModel;
@property(nonatomic, weak) id<HotCarCellDelegate> delegate;
@end
