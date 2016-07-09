//
//  CarButton.m
//  chooseBrand
//
//  Created by 祥云创想 on 16/7/5.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "CarButton.h"
#import "UIView+LXExtension.h"
@implementation CarButton



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.lx_y = 5;
    self.imageView.lx_height = 30;
    self.imageView.lx_width = 30;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.lx_centerX = self.lx_width * 0.5;
    
    
    
    self.titleLabel.lx_y = self.imageView.lx_height + 5;
    self.titleLabel.lx_height = self.lx_height - self.titleLabel.lx_y;
    self.titleLabel.lx_width = self.lx_width;
    self.titleLabel.lx_centerX = self.lx_width * 0.5;
}
@end
