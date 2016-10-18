//
//  YXNetworkUploadParam.m
//  YXNetworkingTool
//
//  Created by Rookie_YX on 16/10/14.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import "YXNetworkUploadParam.h"
#import <CommonCrypto/CommonDigest.h>
@implementation YXNetworkUploadParam

- (NSString *)fileName{
  
  NSDate *currentDate = [NSDate date];
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-mm-dd"];
  NSString *time = [NSString stringWithFormat:@"%@.png",[self md5WithString:[formatter stringFromDate:currentDate]]];
  return time;
}

- (NSString *)mimeType
{
  return @"image/png";
}
#pragma mark - MD5加密
- (NSString *)md5WithString:(NSString*)str
{
  const char *cStr = [str UTF8String];
  unsigned char result[32];
  CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
  // 先转MD5，再转大写
  return [NSString stringWithFormat:
          @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
          result[0], result[1], result[2], result[3],
          result[4], result[5], result[6], result[7],
          result[8], result[9], result[10], result[11],
          result[12], result[13], result[14], result[15]
          ];
}
@end
