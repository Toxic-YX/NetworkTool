//
//  YXNetworkUploadOpeartion.h
//  YXNetworkingTool
//
//  Created by Rookie_YX on 16/10/14.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//  上传任务对象

#import "YXNetworkOperation.h"
#import "YXNetworkDefine.h"
@class YXNetworkUploadOpeartion;
@class YXNetworkUploadParam;

@protocol YXNetworkUploadOpeartionDelegate <NSObject>

/**
 *  上传完成
 *  @param operation  完成
 *
 */
- (void)YXNetworkUploadOperationDidFinished:(YXNetworkUploadOpeartion *)operation;
@end


@interface YXNetworkUploadOpeartion : YXNetworkOperation
/**
 *      进度block
 */
@property (nonatomic, copy) progressBlock progressBlock;
/**
 *      成功block
 */
@property (nonatomic, copy) successBlock successBlock;
/**
 *      失败block
 */
@property (nonatomic, copy) faildBlock failureBlock;
/**
 *      代理 -- YXNetworkUploadOpeartionDelegate
 */
@property (nonatomic, assign) id<YXNetworkUploadOpeartionDelegate>delegate;

/**
 *  上传任务的对象不带进度条
 *
 *  @param url              url
 *  @param params           参数
 *  @param uploadParam      上传图片的数据模型
 *  @param successBlock     成功
 *  @param failureBlock     失败
 */
- (instancetype)initWithURL:(NSString *)url
                     params:(NSDictionary *)params
                uploadParam:(YXNetworkUploadParam *)uploadParam
               successBlock:(successBlock)successBlock
               failureBlock:(faildBlock)failureBlock;
/**
 *  上传图片带进度
 *
 *  @param progressBlock    上传图片的进度
 *  @param url              url
 *  @param params           参数
 *  @param uploadParam      上传图片的数据模型
 *  @param successBlock     成功
 *  @param failureBlock     失败
 */
- (instancetype)initWithURL:(NSString *)url params:(NSDictionary *)params
                uploadParam:(YXNetworkUploadParam *)uploadParam
              progressBlock:(progressBlock)progressBlock
               successBlock:(successBlock)successBlock
               failureBlock:(faildBlock)failureBlock;

@end
