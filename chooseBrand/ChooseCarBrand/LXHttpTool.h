//
//  LXHttpTool.h
//  sunt6
//
//  Created by 祥云创想 on 16/6/7.
//  Copyright © 2016年 杨闯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXHttpTool : NSObject
+(void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success
   failure:(void (^)(NSError *error))failure;
+(void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success
   failure:(void (^)(NSError *error))failure;
@end
