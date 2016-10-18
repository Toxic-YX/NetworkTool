//
//  CityList.m
//  YXNetworkingTool
//
//  Created by Rookie_YX on 16/10/17.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import "CityList.h"

@implementation CityList
+ (BOOL)propertyIsIgnored:(NSString *)propertyName{
  return YES;
}

- (NSString *)description{
  return [NSString stringWithFormat:@"%@,%@,%@,%@",self.city_id,self.city_name,self.province_id,self.province_name];
}
@end
