//tage
//  Tostal.m
//  自定义提示框
//承载着
//  Created by apple on 15/7/14.
//  Copyright (c) 2015年 jl. All rights reserved.
//


#import "AppDelegate.h"
#import "Tostal.h"
int initCount;
static Tostal *singleInstance;
@implementation Tostal
//水电费sasdfad

- (void)tostalMesg:(NSString *)mesgStr tostalTime:(int)disTime{
    _mesgStr=mesgStr;
    _disTime=disTime;
    if (!isShow) {
        isShow=YES;
        UIFont *font=[UIFont systemFontOfSize:16];
        CGRect rect=[_mesgStr boundingRectWithSize:CGSizeMake(200, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
        _lbmesg=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        _lbmesg.font=font;
        _lbmesg.text=_mesgStr;
        _lbmesg.numberOfLines=0;
        _lbmesg.textColor=[UIColor whiteColor];
        _mesgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width+20, rect.size.height+20)];
        _mesgView.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        _lbmesg.center=CGPointMake(_mesgView.bounds.size.width/2, _mesgView.bounds.size.height/2);
        _mesgView.backgroundColor=[UIColor blackColor];
        _mesgView.alpha=0.8;
        _mesgView.layer.cornerRadius=5.0;
        _mesgView.layer.masksToBounds=YES;
        [_mesgView addSubview:_lbmesg];
        AppDelegate *deledate=(AppDelegate*)[UIApplication sharedApplication] .delegate;
        [deledate.window addSubview:_mesgView];
        _timer=[NSTimer scheduledTimerWithTimeInterval:_disTime target:self selector:@selector(hiddenTostal) userInfo:nil repeats:NO];
        
    }else{
        initCount++;
        [_timer invalidate];
        _lbmesg.text=_mesgStr;
        UIFont *font=[UIFont systemFontOfSize:16];
        CGRect rect=[_mesgStr boundingRectWithSize:CGSizeMake(200, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
        _mesgView.frame=CGRectMake(0, 0, rect.size.width+20, rect.size.height+20);
        _lbmesg.frame=CGRectMake(0, 0, rect.size.width, rect.size.height);
        _mesgView.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        _lbmesg.center=CGPointMake(_mesgView.bounds.size.width/2, _mesgView.bounds.size.height/2);
        _timer=[NSTimer scheduledTimerWithTimeInterval:_disTime target:self selector:@selector(hiddenTostal) userInfo:nil repeats:NO];
    }
}
- (void)hiddenTostal{
    isShow=NO;

    [_mesgView removeFromSuperview];
}
+(Tostal *)sharTostal{
    @synchronized (self){
        if (singleInstance==nil) {
            singleInstance=[[Tostal alloc] init];
        }
    }
    return singleInstance;
}
@end
