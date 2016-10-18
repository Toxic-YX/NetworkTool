//
//  YXNetworkManager.h
//  YXNetworkingTool
//
//  Created by Rookie_YX on 16/10/14.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXNetworkDefine.h"
@class YXNetworkUploadParam;

@interface YXNetworkManager : NSObject

/**
 *  GET 请求
 *
 *  @param url              url
 *  @param params           参数字典
 *  @param successBlock     成功
 *  @param failureBlock     失败
 */
+ (void)getRequestWithURL:(NSString*)url
                   params:(NSDictionary*)params
                  success:(successBlock)successBlock
               faildBlock:(faildBlock)failureBlock;

/**
 *  POST 请求
 *
 *  @param url              url
 *  @param params           参数字典
 *  @param successBlock     成功
 *  @param failureBlock     失败
 */
+ (void)postRequestWithURL:(NSString*)url
                    params:(NSDictionary*)params
                   success:(successBlock)successBlock
                faildBlock:(faildBlock)failureBlock;

/**
 *  上传图片不带进度条
 *
 *  @param url              url
 *  @param params           参数
 *  @param successBlock     成功
 *  @param failureBlock     失败
 *  @param uploadParam      上传图片数据的模型
 */
+ (void)uploadFileWithURL:(NSString*)url
                   params:(NSDictionary*)params
              uploadParam:(YXNetworkUploadParam *)uploadParam
             successBlock:(successBlock)successBlock
             failureBlock:(faildBlock)failureBlock;

/**
 *  上传图片带进度条
 *
 *  @param progressBlock    上传图片的进度
 *  @param url              url
 *  @param params           参数
 *  @param uploadParam      上传图片的数据模型
 *  @param successBlock     成功
 *  @param failureBlock     失败
 */
+ (void)uploadFileWithURL:(NSString*)url
                   params:(NSDictionary*)params
              uploadParam:(YXNetworkUploadParam *)uploadParam
            progressBlock:(progressBlock)progressBlock
             successBlock:(successBlock)successBlock
             failureBlock:(faildBlock)failureBlock;
/**
 *  取消所有的网络请求任务
 */
+ (void)cancelAllOperations;
@end
