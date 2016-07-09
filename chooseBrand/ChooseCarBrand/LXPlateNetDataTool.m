//
//  LXPlateNetDataTool.m
//  chooseBrand
//
//  Created by 祥云创想 on 16/7/7.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "LXPlateNetDataTool.h"
#import "LXHttpTool.h"
#import "MJExtension.h"
#import "CarModel.h"
#import "CarFamilyModel.h"
#import "Tostal.h"
@interface LXPlateNetDataTool ()
@property (nonatomic, strong) NSMutableArray *indexTitleArr;
@end

@implementation LXPlateNetDataTool
- (NSMutableArray *)indexTitleArr
{
    if (!_indexTitleArr) {
        _indexTitleArr = [NSMutableArray array];
    }
    return _indexTitleArr;
}

-(void)getPlateData:(void(^)(id json,NSMutableArray *indexTitleArr))block
{
    [LXHttpTool get:@"http://10.136.122.119:8080/testJsoup/carBrand/carBrandListForIOS.do" parameters:nil success:^(id json) {
        
        NSArray *modelArr = [CarModel objectArrayWithKeyValuesArray:json];
        
        
        //
        NSMutableArray *arrayForArrays = [[NSMutableArray alloc] init];
        NSMutableArray *tempArray = nil;
        BOOL flag = NO;
        for (int i = 0; i < modelArr.count; i++) {
            CarModel * model = modelArr[i];
            if (![self.indexTitleArr containsObject:model.carletter]) {
                [self.indexTitleArr addObject:model.carletter];
                tempArray = [[NSMutableArray alloc] init];
                flag = NO;
            }
            if ([self.indexTitleArr containsObject:model.carletter]) {
                [tempArray addObject:modelArr[i]];
                if (flag == NO) {
                    [arrayForArrays addObject:tempArray];
                    flag = YES;
                }
            }
            
        }

        block(arrayForArrays,self.indexTitleArr);
        
    } failure:^(NSError *error) {
        block(error,nil);
    }];

}
-(void)getHotPlateData:(void(^)(id json))block
{
    [LXHttpTool get:@"http://10.136.122.119:8080/testJsoup/carBrand/hotCarBrandList.do" parameters:nil success:^(id json) {
        
        NSLog(@"%@",json);
        NSArray *arr = [CarModel objectArrayWithKeyValuesArray:json];
        
        block(arr);
        
    } failure:^(NSError *error) {
        block(error);
    }];
}

-(void)getCarModelDataWithCarName:(NSString *)carName block:(void(^)(id json))block
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"vehicleName"] =carName;
    [LXHttpTool post:@"http://10.136.122.119:8080/testJsoup/carBrand/serch.do" parameters:parameters success:^(id json) {
        
        NSLog(@"%@",json);
        if (json == nil) {
            [[Tostal sharTostal] tostalMesg:@"暂未找到车型" tostalTime:1];
            block(@"暂未找到车型");
            return ;
        }
        NSArray *arr = [CarFamilyModel objectArrayWithKeyValuesArray:json];
        block(arr);
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        block(error);
    }];
}

-(void)getCarDisplaceDataWithCarName:(NSString *)carName carID:(NSString *)carID block:(void(^)(id json))block
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"vehicleName"] =carName;
    parameters[@"FamilyId"] =carID;
    [LXHttpTool post:@"http://10.136.122.119:8080/testJsoup/carBrand/family.do" parameters:parameters success:^(NSArray *json) {
        
        NSLog(@"%@",json);
        if (json == nil) {
            [[Tostal sharTostal] tostalMesg:@"暂未找到车型" tostalTime:1];
            block(@"暂未找到车型");
            return ;
        }
        NSMutableArray *newJson = [NSMutableArray array];
        for (int i = 0; i<json.count; i++) {
            NSDictionary *dic  = json[i];
            NSString *key = [NSString stringWithFormat:@"%zd",i];
            NSString *value = dic[key];
            [newJson addObject:value];
        }

        block(newJson);
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        block(error);
    }];
}

-(void)getCarGearBoxDataWithCarName:(NSString *)carName carID:(NSString *)carID enginedesc:(NSString *)enginedesc block:(void(^)(id json))block
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"vehicleName"] =carName;
    parameters[@"FamilyId"] =carID;
    parameters[@"enginedesc"] =enginedesc;
    [LXHttpTool post:@"http://10.136.122.119:8080/testJsoup/carBrand/gearboxtype.do" parameters:parameters success:^(NSArray *json) {
        
        NSLog(@"%@",json);
        if (json == nil) {
            [[Tostal sharTostal] tostalMesg:@"暂未找到车型" tostalTime:1];
            block(@"暂未找到车型");
            return ;
        }
        NSMutableArray *newJson = [NSMutableArray array];
        for (int i = 0; i<json.count; i++) {
            NSDictionary *dic  = json[i];
            NSString *key = [NSString stringWithFormat:@"%zd",i];
            NSString *value = dic[key];
            [newJson addObject:value];
        }
        //        NSArray *arr = [CarFamilyModel objectArrayWithKeyValuesArray:json];
        //
        block(newJson);
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        block(error);
    }];
}
-(void)getCarVersionDataWithCarName:(NSString *)carName carID:(NSString *)carID enginedesc:(NSString *)enginedesc gearboxtype:(NSString *)gearboxtype block:(void(^)(id json))block
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"vehicleName"] =carName;
    parameters[@"FamilyId"] =carID;
    parameters[@"enginedesc"] =enginedesc;
    parameters[@"gearboxType"] =gearboxtype;
    
    [LXHttpTool post:@"http://10.136.122.119:8080/testJsoup/carBrand/vehicle.do" parameters:parameters success:^(NSArray *json) {
        
        NSLog(@"%@",json);
        if (json == nil) {
            [[Tostal sharTostal] tostalMesg:@"暂未找到车型" tostalTime:1];
            block(@"暂未找到车型");
            return ;
        }
        NSMutableArray *newJson = [NSMutableArray array];
        for (int i = 0; i<json.count; i++) {
            NSDictionary *dic  = json[i];
//            NSString *key = [NSString stringWithFormat:@"%zd",i];
            NSString *value = dic[@"ConfigName"];
            [newJson addObject:value];
        }
        //        NSArray *arr = [CarFamilyModel objectArrayWithKeyValuesArray:json];
        //
        block(newJson);
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        block(error);
    }];
    
}
@end
