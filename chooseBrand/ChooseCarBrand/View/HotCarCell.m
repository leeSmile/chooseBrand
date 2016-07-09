//
//  HotCarCell.m
//  chooseBrand
//
//  Created by 祥云创想 on 16/7/5.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "HotCarCell.h"
#import "CarButton.h"
#import "UIView+LXExtension.h"
#import "Masonry.h"
#import "UIButton+WebCache.h"

#define MY_WIHTE [UIScreen mainScreen].bounds.size.width
#define MY_HEIGHT [UIScreen mainScreen].bounds.size.height

/** RGB颜色 */
#define rgb255(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
/** 随机色 */
#define RandomColor rgb255(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
/** 灰色 */
#define Color(v) rgb255(v, v, v)


static int rows = 5;
static int lines = 2;

@interface HotCarCell ()
@property(nonatomic, strong) UIView *centLine;
@property(nonatomic, strong)NSMutableArray *CarBtnArr;
@end

@implementation HotCarCell
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
    CGFloat btnW = MY_WIHTE/rows;
    CGFloat btnH = 55;
    
    
    //热门品牌的个数
    int allHotCarCounts = rows * lines;
    
    for (int i = 0; i<allHotCarCounts; i++) {
        CarButton *btn = [CarButton new];
        btn.tag = 1000 + i;
//        btn.backgroundColor = RandomColor;
        btn.lx_width = btnW;
        btn.lx_height = btnH;
        btn.lx_x = (i % rows)  * btnW;
        btn.lx_y = (i / rows)  * btnH; 
        
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:Color(102) forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"Porsche"] forState:UIControlStateNormal];
        [btn sd_setImageWithURL:[NSURL URLWithString:@"http://car.qi-che.com/car/images/new_brand_logo/247.jpg"] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@""]];
        [btn setTitle:@"保时捷" forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:btn];
        [self.CarBtnArr addObject:btn];
        
    }
    
    
    self.centLine.lx_y =55;
    self.centLine.lx_x = 0;
    self.centLine.lx_height = 1;
    self.centLine.lx_width = MY_WIHTE;
    [self.contentView addSubview:self.centLine];
    
//    [self.centLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@(self.contentView.lx_height/2));
//        make.left.equalTo(self.contentView).offset(15);
//        make.height.equalTo(@33);
//    }];
    
}
- (UIView *)centLine
{
    if (!_centLine) {
        _centLine = [UIView new];
        _centLine.backgroundColor = Color(238);
        
    }
    return _centLine;
}

- (NSMutableArray *)CarBtnArr
{
    if (!_CarBtnArr) {
        _CarBtnArr = [NSMutableArray array];
    }
    return _CarBtnArr;
}


- (void)setCarModelArr:(NSMutableArray<CarModel *> *)CarModelArr
{
    _CarModelArr = CarModelArr;

    for (int i = 0; i<CarModelArr.count; i++) {
        
        for (UIButton *btn in self.CarBtnArr) {
            int tag = (int)btn.tag - 1000;
            if (tag == i) {
                CarModel *model = CarModelArr[i];
                [btn sd_setImageWithURL:[NSURL URLWithString:model.carurl] forState:UIControlStateNormal];
                [btn setTitle:model.carname forState:UIControlStateNormal];
            }
        }
    }
}

- (void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(tableViewCell: didSelectBtnWithCarModel:)]) {
        [self.delegate tableViewCell:self didSelectBtnWithCarModel:self.CarModelArr[(int)btn.tag-1000]];
    }
}
@end
