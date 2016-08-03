//
//  StackOverflowService.h
//  StackeOverflowClient
//
//  Created by Michael Sweeney on 8/2/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^questionFetchCompletion)(NSArray *results, NSError *error);

@interface StackOverflowService : NSObject

+(void)questionsForSearchTerm:(NSString *)searchTerm completionHandler:(questionFetchCompletion)completionHandler;


+(void)usersForSearchTerm:(NSString *)searchTerm completionHandler:(questionFetchCompletion)completionHandle;

@end
