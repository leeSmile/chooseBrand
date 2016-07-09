//
//  CarCell.h
//  chooseBrand
//
//  Created by 祥云创想 on 16/7/5.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"
@interface CarCell : UITableViewCell
@property(nonatomic, strong) UIView *bottomLine;
@property(nonatomic, strong)CarModel *CarModel;
@end
