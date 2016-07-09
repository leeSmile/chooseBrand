//
//  LXHttpTool.m
//  sunt6
//
//  Created by 祥云创想 on 16/6/7.
//  Copyright © 2016年 . All rights reserved.
//

#import "LXHttpTool.h"
#import "AFNetworking.h"

@implementation LXHttpTool
+ (AFHTTPRequestOperationManager *)manager {
    static AFHTTPRequestOperationManager *manager = nil;
    if (manager == nil) {
        manager = [AFHTTPRequestOperationManager manager];
    }
    return manager;
}

+(void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success
   failure:(void (^)(NSError *error))failure
{

    AFHTTPRequestOperationManager *mgr = [self manager];

    
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];

    [mgr GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        success(jsonDict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        failure(error);
    }];
    
    

}

+(void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success
    failure:(void (^)(NSError *error))failure
{

    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];;

    
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];

    [mgr POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        success(jsonDict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        failure(error);
    }];

}
@end
