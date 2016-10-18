//
//  YXNetworkOperation.h
//  YXNetworkingTool
//
//  Created by Rookie_YX on 16/10/14.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//  请求任务对象

#import <Foundation/Foundation.h>
#import "YXNetworkDefine.h"

@interface YXNetworkOperation : NSOperation
/**
 *  实例化一个普通的网络请求任务
 *
 *  @param networkType      网络请求的类型
 *  @param url              url
 *  @param params           参数字典
 *  @param successBlock     成功
 *  @param failureBlock     失败
 */
- (instancetype )initWithtype:(YXNetworkType)networkType
                          url:(NSString *)url
                       params:(NSDictionary *)params
                 successBlock:(successBlock)successBlock
                 failureBlock:(faildBlock)failureBlock;

@end
