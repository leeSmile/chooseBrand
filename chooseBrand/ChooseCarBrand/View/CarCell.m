//
//  CarCell.m
//  chooseBrand
//
//  Created by 祥云创想 on 16/7/5.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "CarCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
/** RGB颜色 */
#define rgb255(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
/** 灰色 */
#define Color(v) rgb255(v, v, v)
@interface CarCell ()
@property(nonatomic, strong) UIImageView *carImage;
@property(nonatomic, strong) UILabel *carName;

@end

@implementation CarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.contentView.backgroundColor = [UIColor whiteColor];

    [self.contentView addSubview:self.carImage];
    [self.contentView addSubview:self.carName];
    [self.contentView addSubview:self.bottomLine];
    
    //约束
    
    [self.carImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 40));
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self);
    }];
    
    [self.carName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.carImage);
        make.left.equalTo(self.carImage.mas_right).offset(15);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
}

- (UIImageView *)carImage
{
    if (!_carImage) {
        _carImage = [UIImageView new];
        _carImage.image = [UIImage imageNamed:@"Porsche"];
//        [_carImage sd_setImageWithURL:[NSURL URLWithString:@"http://car.qi-che.com/car/images/new_brand_logo/247.jpg"]];
        _carImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _carImage;
}

- (UILabel *)carName
{
    if (!_carName) {
        _carName = [UILabel new];
        _carName.text = @"保时捷";
        _carName.textColor = Color(51);
        _carName.font = [UIFont systemFontOfSize:15];
    }
    return _carName;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = Color(238);
        
    }
    return _bottomLine;
}

- (void)setCarModel:(CarModel *)CarModel
{
    _CarModel = CarModel;
    self.carName.text = CarModel.carname;
    [self.carImage sd_setImageWithURL:[NSURL URLWithString:CarModel.carurl] placeholderImage:nil];
}
@end
