//
//  SeriesCarCell.m
//  chooseBrand
//
//  Created by 祥云创想 on 16/7/6.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "SeriesCarCell.h"
#import "Masonry.h"

/** RGB颜色 */
#define rgb255(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
/** 灰色 */
#define Color(v) rgb255(v, v, v)


@interface SeriesCarCell ()


@property(nonatomic, strong) UIView *bottomLine;
@end

@implementation SeriesCarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self.contentView addSubview:self.selecterImage];
    [self.contentView addSubview:self.carName];
    [self.contentView addSubview:self.bottomLine];
    
    //约束
    [self.carName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@20);
        make.centerY.equalTo(self);
    }];
    
    [self.selecterImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(@(-20));
        make.size.mas_equalTo(CGSizeMake(17, 11));
        make.centerY.equalTo(self);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
}
- (UIImageView *)selecterImage
{
    if (!_selecterImage) {
        _selecterImage = [UIImageView new];
//        _selecterImage.backgroundColor = [UIColor redColor];
        _selecterImage.image = [UIImage imageNamed:@"xuanze"];
        _selecterImage.hidden =YES;
    }
    return _selecterImage;
}
- (UILabel *)carName
{
    if (!_carName) {
        _carName = [UILabel new];
        _carName.text = @"A8";
        _carName.textColor = Color(51);
        _carName.font = [UIFont systemFontOfSize:14];
        [_carName sizeToFit];
    }
    return _carName;
}

//- (void)setCarName:(UILabel *)carName
//{
//    
//}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = Color(242);
        
    }
    return _bottomLine;
}

- (void)setCarFamilyModel:(CarFamilyModel *)carFamilyModel
{
    _carFamilyModel = carFamilyModel;
    self.carName.text = carFamilyModel.FamilyName;
}
@end
