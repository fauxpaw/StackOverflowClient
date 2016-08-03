//
//  JSONParser.h
//  StackeOverflowClient
//
//  Created by Michael Sweeney on 8/2/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"
#import "User.h"

@interface JSONParser : NSObject

+(NSArray *)questionResultsFromJSON: (NSDictionary *)jsonData;
+(NSArray *)usersFromJSON: (NSDictionary *)userData;

@end
