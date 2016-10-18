//
//  YXNetworkOperation.m
//  YXNetworkingTool
//
//  Created by Rookie_YX on 16/10/14.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import "YXNetworkOperation.h"

@interface YXNetworkOperation(){
}

@end
@implementation YXNetworkOperation

- (instancetype)initWithtype:(YXNetworkType)networkType url:(NSString *)url params:(NSDictionary *)params successBlock:(successBlock)successBlock failureBlock:(faildBlock)failureBlock{
  
  self = [super init];
  if (self) {
    DTLog(@"<------- 请求url地址 ------>%@",url);
    DTLog(@"<------- 请求参数地址 ------>%@",params);
    
    NSMutableURLRequest *request = nil;
    NSMutableString *urlM = [NSMutableString stringWithString:url];
    if (networkType == YXNetworkTypeGET) {
      [urlM appendFormat:@"?%@",[self getParmasString:params]];
      request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlM]];
    }
    else
    {
      request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
      request.HTTPMethod = @"POST";
      request.HTTPBody = [[self getParmasString:params] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    }
    request.timeoutInterval = NetTimeoutInterval;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      if (!error) {
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        DTLog(@"<------- 请求的返回结果地址 ------>%@",result);
        if (successBlock) {
          successBlock(result);
        }
      }
      else
      {
        if (failureBlock) {
          failureBlock(error);
        }
      }
    }];
    [task resume];
  }
  return self;
}

- (NSString*)getParmasString:(NSDictionary*)params{
  
  if (!params || params.count == 0) {
    return @"";
  }
  NSMutableString *mutableStr = [NSMutableString string];
  [params enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
    [mutableStr appendFormat:@"%@=",key];
    [mutableStr appendFormat:@"%@=",obj];
  }];
  [mutableStr deleteCharactersInRange:NSMakeRange(mutableStr.length - 1, 1)];
  return mutableStr;
}

@end
