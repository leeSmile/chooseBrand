//
//  HotCarHeadView.m
//  chooseBrand
//
//  Created by 祥云创想 on 16/7/6.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "HotCarHeadView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
/** RGB颜色 */
#define rgb255(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
/** 灰色 */
#define Color(v) rgb255(v, v, v)

@interface HotCarHeadView ()

@property(nonatomic, strong) UIImageView *icon;
@property(nonatomic, strong) UILabel *lable;
@property(nonatomic, strong) UIView *bottomLine;
@end

@implementation HotCarHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = Color(242);
    
    [self addSubview:self.icon];
    [self addSubview:self.lable];
    [self addSubview:self.bottomLine];
    //约束
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(self);
        make.left.equalTo(@15);
        
    }];
    
    [self.lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(8);
        make.centerY.equalTo(self);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
}

- (UIImageView *)icon
{
    if (!_icon) {
        _icon = [UIImageView new];

        _icon.image = [UIImage imageNamed:@"remen"];
    }
    return _icon;
}

- (UILabel *)lable
{
    if (!_lable) {
        _lable = [UILabel new];
        _lable.text = @"热门品牌";
        _lable.font = [UIFont systemFontOfSize:15];
        _lable.textColor = Color(51);
    }
    return _lable;
}
- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = Color(242);
        
    }
    return _bottomLine;
}

- (void)setCarModel:(CarModel *)CarModel
{
    _CarModel = CarModel;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:CarModel.carurl] placeholderImage:nil];
    self.lable.text = CarModel.carname;
}

@end
