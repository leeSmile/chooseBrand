//
//  SeriesCarCell.h
//  chooseBrand
//
//  Created by 祥云创想 on 16/7/6.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarFamilyModel.h"
@interface SeriesCarCell : UITableViewCell
@property(nonatomic, strong) UIImageView *selecterImage;
@property(nonatomic, strong) UILabel *carName;
@property(nonatomic, strong) CarFamilyModel *carFamilyModel;
@end
