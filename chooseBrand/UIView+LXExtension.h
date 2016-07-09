

#import <UIKit/UIKit.h>

@interface UIView (LXExtension)
//快速设置控件的位置
@property (nonatomic, assign) CGSize lx_size;
@property (nonatomic, assign) CGFloat lx_width;
@property (nonatomic, assign) CGFloat lx_height;
@property (nonatomic, assign) CGFloat lx_x;
@property (nonatomic, assign) CGFloat lx_y;
@property (nonatomic, assign) CGFloat lx_centerX;
@property (nonatomic, assign) CGFloat lx_centerY;

+ (instancetype)lx_viewFromXib;
/**
 *  判断self和view是否重叠
 */
- (BOOL)lx_intersectsWithView:(UIView *)view;

@end
