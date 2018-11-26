//
//  Tostal.h
//  自定义提示框
//
//  Created by apple on 15/7/14.
//  Copyright (c) 2015年 jl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tostal : NSObject
{
    UIView *_mesgView;
    UILabel *_lbmesg;
    NSString *_mesgStr;
    NSTimer *_timer;
    int _disTime;
    BOOL isShow;
}

// 偏下部显示黑色弹窗
- (void)lowTostalMesg:(NSString *)mesgStr tostalTime:(int)disTime;

- (void)tostalMesg:(NSString *)mesgStr tostalTime:(int)disTime;
+(Tostal *)sharTostal;
@end
