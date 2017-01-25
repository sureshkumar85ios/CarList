//
//  NetWorkParser.h
//  CarTest_17
//
//  Created by ADDC on 1/14/17.
//  Copyright © 2017 sureshkumar. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const WEBSERVICENAME;

@interface NetWorkParser : NSObject<NSURLConnectionDelegate>

@property (nonatomic) BOOL logSuccess;
@property (nonatomic) BOOL logErrors;

+(NSDictionary*)getWebserviceResponse:(NSString *)urlString requestType:(NSString *)requestType parDic:(NSString *)parDic andPage:(int)pageCount;
+ (NSDictionary*) Get:(NSString*) resource params:(NSDictionary*)params;

@end
