//
//  StackOverflowService.m
//  StackeOverflowClient
//
//  Created by Michael Sweeney on 8/2/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "StackOverflowService.h"
@import AFNetworking;
#import "JSONParser.h"
#import "User.h"

NSString const *clientKey = @"jsVSUlMeEIJ9upZXmb4eFA((";
NSString const *kSearchBaseURL = @"https://api.stackexchange.com/2.2/search";

@implementation StackOverflowService

+(void)questionsForSearchTerm:(NSString *)searchTerm completionHandler:(questionFetchCompletion)completionHandler{
    
    NSString *accessToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    NSString *searchURLString = [NSString stringWithFormat:@"%@?order=desc&sort=activity&intitle=%@&site=stackoverflow&key=%@&access_token=%@", kSearchBaseURL, searchTerm, clientKey, accessToken];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:searchURLString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@", responseObject);
        NSArray *results = [JSONParser questionResultsFromJSON:responseObject];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(results, nil);
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(nil, error);
        });
        
    }];
    
}

+(void)usersForSearchTerm:(NSString *)searchTerm completionHandler:(questionFetchCompletion)completionHandler{
    
    NSString *accessToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    NSString *searchURLString = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/users?order=desc&sort=reputation&inname=%@&site=stackoverflow&key=%@&access_token=%@", searchTerm, clientKey, accessToken];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:searchURLString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
        
        NSArray *results = [JSONParser usersFromJSON:responseObject];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(results, nil);
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(nil, error);
        });
        
    }];
    
}





@end
