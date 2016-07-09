//
//  CarHeadView.m
//  chooseBrand
//
//  Created by 祥云创想 on 16/7/5.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "CarHeadView.h"
#import "Masonry.h"
/** RGB颜色 */
#define rgb255(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
/** 灰色 */
#define Color(v) rgb255(v, v, v)

@interface CarHeadView ()

@property(nonatomic, strong) UIView *topLine;
@property(nonatomic, strong) UILabel *lable;
@property(nonatomic, strong) UIView *bottomLine;
@end

@implementation CarHeadView

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
    
    [self addSubview:self.topLine];
    [self addSubview:self.lable];
    [self addSubview:self.bottomLine];
    //约束
//    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self);
//        make.height.equalTo(@3);
//    }];
    
    [self.lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(self);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
}

//- (UIView *)topLine
//{
//    if (!_topLine) {
//        _topLine = [UIView new];
//        _topLine.backgroundColor = Color(242);
//    }
//    return _topLine;
//}

- (UILabel *)lable
{
    if (!_lable) {
        _lable = [UILabel new];
        _lable.text = @"热门品牌";
        _lable.font = [UIFont systemFontOfSize:13];
        _lable.textColor = Color(102);
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
- (void)setNameLable:(NSString *)nameLable
{
    _nameLable = nameLable;
    self.lable.text = nameLable;
}
@end
