//
//  NetWorkParser.m
//  CarTest_17
//
//  Created by ADDC on 1/14/17.
//  Copyright © 2017 sureshkumar. All rights reserved.
//

#import "NetWorkParser.h"

NSString * const WEBSERVICENAME = @"http://api-aws-eu-qa-1.auto1-test.com";


@implementation NetWorkParser

@synthesize logSuccess;
@synthesize logErrors;


+ (NSDictionary*) SendRequest:(NSMutableURLRequest*) request
{
  NSHTTPURLResponse* urlResponse = nil;
  NSError *error = [[NSError alloc] init];
  
  //sending Synchronous request
  NSData *responseData = [self sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
  
  //deserialize to json
  NSDictionary* json = [self requestManagerConfigureDatas:responseData];
  
  if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
 
    NSLog(@"Response Code: %ld", (long)[urlResponse statusCode]);
    NSDictionary *items = [json valueForKey:@"wkda"];
    return items;
    
  }
  else
  {
    NSDictionary *arr_error = @{@"error":[json valueForKey:@"message"]};
    return arr_error;
  }
}


+ (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse **)response error:(NSError **)error
{
  
  NSError __block *err = NULL;
  NSData __block *data;
  BOOL __block reqProcessed = false;
  NSURLResponse __block *resp;
  
  [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable _data, NSURLResponse * _Nullable _response, NSError * _Nullable _error) {
    resp = _response;
    err = _error;
    data = _data;
    reqProcessed = true;
  }] resume];
  
  while (!reqProcessed) {
    [NSThread sleepForTimeInterval:0];
  }
  
  *response = resp;
  *error = err;
  return data;
}

+ (NSDictionary*) Get:(NSString*) resource params:(NSDictionary*)params
{
  NSString *paramStr = @"";
  bool first = true;
  for (NSString* key in params) {
    if( first ){
      paramStr = [NSString stringWithFormat:@"%@?%@=%@", paramStr, (NSString*)key, (NSString*)[params objectForKey:key]];
      first = false;
    }else {
      paramStr = [NSString stringWithFormat:@"%@&%@=%@", paramStr, (NSString*)key, (NSString*)[params objectForKey:key]];
    }
  }
  
  NSURL *urlstr = [NSURL URLWithString:[resource stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlstr];
  [request setHTTPMethod:@"GET"];

  return [self SendRequest:request];
}

+ (NSDictionary*)getWebserviceResponse:(NSString *)urlString requestType:(NSString *)requestType parDic:(NSString *)parDic andPage:(int)pageCount
{
  NSString *url = [NSString stringWithFormat:@"%@%@manufacturer=%@&page=0&pageSize=%d&wa_key=coding-puzzle-client-449cc9d",WEBSERVICENAME,urlString,parDic,pageCount];
  return [self Get:url params:nil];
}

+ (NSDictionary *)requestManagerConfigureDatas:(NSData *)data {
  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
  return dic;
}



@end
