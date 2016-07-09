//
//  LXPlateNetDataTool.h
//  chooseBrand
//
//  Created by 祥云创想 on 16/7/7.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXPlateNetDataTool : NSObject
//所有品牌
-(void)getPlateData:(void(^)(id json,NSMutableArray *indexTitleArr))block;
//热门品牌
-(void)getHotPlateData:(void(^)(id json))block;
//某一品牌下的所有车系列
-(void)getCarModelDataWithCarName:(NSString *)carName block:(void(^)(id json))block;
//发动机排量
-(void)getCarDisplaceDataWithCarName:(NSString *)carName carID:(NSString *)carID block:(void(^)(id json))block;
//选择档位
-(void)getCarGearBoxDataWithCarName:(NSString *)carName carID:(NSString *)carID enginedesc:(NSString *)enginedesc block:(void(^)(id json))block;
//选择版本
-(void)getCarVersionDataWithCarName:(NSString *)carName carID:(NSString *)carID enginedesc:(NSString *)enginedesc gearboxtype:(NSString *)gearboxtype block:(void(^)(id json))block;
@end
